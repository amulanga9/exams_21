from datetime import datetime
from sqlalchemy import BigInteger, String, Text, DateTime, ForeignKey, Enum
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from typing import Optional, List
import enum


class Base(DeclarativeBase):
    pass


class UserType(enum.Enum):
    """Тип пользователя: участник или команда"""
    PARTICIPANT = "participant"
    TEAM = "team"


class InvitationStatus(enum.Enum):
    """Статус приглашения"""
    PENDING = "pending"
    ACCEPTED = "accepted"
    REJECTED = "rejected"


class TeamStatus(enum.Enum):
    """Статус команды"""
    ACTIVE = "active"
    INACTIVE = "inactive"
    COMPLETE = "complete"


class User(Base):
    """Модель пользователя"""
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    telegram_id: Mapped[int] = mapped_column(BigInteger, unique=True, nullable=False, index=True)
    username: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    user_type: Mapped[UserType] = mapped_column(Enum(UserType), nullable=False)
    primary_skill: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    additional_skills: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    idea_what: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    idea_who: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    last_active: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)

    # Relationships
    led_teams: Mapped[List["Team"]] = relationship("Team", back_populates="leader", foreign_keys="Team.leader_id")
    sent_invitations: Mapped[List["Invitation"]] = relationship(
        "Invitation",
        back_populates="from_user",
        foreign_keys="Invitation.from_user_id"
    )
    received_invitations: Mapped[List["Invitation"]] = relationship(
        "Invitation",
        back_populates="to_user",
        foreign_keys="Invitation.to_user_id"
    )

    def __repr__(self) -> str:
        return f"<User(id={self.id}, telegram_id={self.telegram_id}, name={self.name})>"


class Team(Base):
    """Модель команды"""
    __tablename__ = "teams"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    team_name: Mapped[str] = mapped_column(String(255), nullable=False)
    idea_description: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    leader_id: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False, index=True)
    needed_skills: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    status: Mapped[TeamStatus] = mapped_column(Enum(TeamStatus), default=TeamStatus.ACTIVE)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)

    # Relationships
    leader: Mapped["User"] = relationship("User", back_populates="led_teams", foreign_keys=[leader_id])
    invitations: Mapped[List["Invitation"]] = relationship(
        "Invitation",
        back_populates="from_team",
        foreign_keys="Invitation.from_team_id"
    )

    def __repr__(self) -> str:
        return f"<Team(id={self.id}, team_name={self.team_name}, leader_id={self.leader_id})>"


class Invitation(Base):
    """Модель приглашения"""
    __tablename__ = "invitations"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    from_user_id: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False, index=True)
    from_team_id: Mapped[Optional[int]] = mapped_column(ForeignKey("teams.id"), nullable=True, index=True)
    to_user_id: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False, index=True)
    message: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    status: Mapped[InvitationStatus] = mapped_column(
        Enum(InvitationStatus),
        default=InvitationStatus.PENDING
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    viewed_at: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)
    responded_at: Mapped[Optional[datetime]] = mapped_column(DateTime, nullable=True)

    # Relationships
    from_user: Mapped["User"] = relationship(
        "User",
        back_populates="sent_invitations",
        foreign_keys=[from_user_id]
    )
    to_user: Mapped["User"] = relationship(
        "User",
        back_populates="received_invitations",
        foreign_keys=[to_user_id]
    )
    from_team: Mapped[Optional["Team"]] = relationship(
        "Team",
        back_populates="invitations",
        foreign_keys=[from_team_id]
    )

    def __repr__(self) -> str:
        return f"<Invitation(id={self.id}, from_user_id={self.from_user_id}, to_user_id={self.to_user_id}, status={self.status})>"
