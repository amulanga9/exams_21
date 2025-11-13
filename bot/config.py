from dataclasses import dataclass
from os import getenv
from dotenv import load_dotenv

# Загружаем переменные окружения из .env файла
load_dotenv()


@dataclass
class Settings:
    """Настройки приложения"""

    # Telegram Bot
    BOT_TOKEN: str

    # Database
    DB_HOST: str
    DB_PORT: int
    DB_NAME: str
    DB_USER: str
    DB_PASSWORD: str
    DATABASE_URL: str

    def __init__(self):
        # Telegram
        self.BOT_TOKEN = getenv("BOT_TOKEN", "")

        # Database
        self.DB_HOST = getenv("DB_HOST", "localhost")
        self.DB_PORT = int(getenv("DB_PORT", "5432"))
        self.DB_NAME = getenv("DB_NAME", "teammates_bot")
        self.DB_USER = getenv("DB_USER", "postgres")
        self.DB_PASSWORD = getenv("DB_PASSWORD", "")

        # Формируем DATABASE_URL если не указан явно
        self.DATABASE_URL = getenv(
            "DATABASE_URL",
            f"postgresql+asyncpg://{self.DB_USER}:{self.DB_PASSWORD}@{self.DB_HOST}:{self.DB_PORT}/{self.DB_NAME}"
        )

        # Валидация
        if not self.BOT_TOKEN:
            raise ValueError("BOT_TOKEN не установлен в переменных окружения")
        if not self.DB_PASSWORD:
            raise ValueError("DB_PASSWORD не установлен в переменных окружения")


# Создаем экземпляр настроек
settings = Settings()
