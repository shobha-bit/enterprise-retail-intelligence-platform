from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv("python/.env")

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

try:
    engine = create_engine(DATABASE_URL)

    with engine.connect():
        print("=" * 50)
        print("✅ PostgreSQL Connected Successfully!")
        print("=" * 50)
        print(f"Database : {DB_NAME}")
        print(f"User     : {DB_USER}")
        print(f"Host     : {DB_HOST}")
        print(f"Port     : {DB_PORT}")
        print("=" * 50)

except Exception as e:
    print("❌ Connection Failed")
    print(e)