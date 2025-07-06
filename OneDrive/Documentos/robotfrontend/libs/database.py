import os
from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv()

class MongoDB:
    def __init__(self):
        self.client = MongoClient(os.getenv("MONGO_URI"))
        self.db = self.client[os.getenv("DB_NAME")]
        self.users = self.db[os.getenv("COLLECTION_NAME")]

    def delete_user(self, email):
        return self.users.delete_one({"email": email}).deleted_count > 0

    def close_connection(self):
        self.client.close()

# Funções para Robot Framework
def Delete_User(email):
    db = MongoDB()
    try:
        result = db.delete_user(email)
        return result
    finally:
        db.close_connection()

def Get_User(email):
    db = MongoDB()
    try:
        return db.users.find_one({"email": email})
    finally:
        db.close_connection()