from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.pool import NullPool
from database.models import Base
from config import settings


# Создаем асинхронный движок БД
engine = create_async_engine(
    settings.DATABASE_URL,
    echo=False,
    poolclass=NullPool,
)

# Создаем фабрику сессий
async_session_maker = async_sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False,
)


async def get_session() -> AsyncSession:
    """Получить асинхронную сессию БД"""
    async with async_session_maker() as session:
        yield session


async def create_tables():
    """Создать все таблицы в БД"""
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


async def drop_tables():
    """Удалить все таблицы из БД (для разработки)"""
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
