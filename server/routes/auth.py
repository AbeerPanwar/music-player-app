import os
import uuid
import bcrypt
from fastapi import Depends, HTTPException, Header
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import Session
from pydantic_schemas.user_login import UserLogin
import jwt
from sqlalchemy.orm import joinedload
from middleware.auth_middleware import auth_middleware


router = APIRouter()

@router.post('/signup', status_code= 201)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400, "user with same email already exists!")

    hash_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt(16))
    user_db = User(id=str(uuid.uuid4()), email= user.email, name= user.name, password= hash_pw)

    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post('/login')
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(400, "the user with this email does not exists")

    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)
    if not is_match :
        raise HTTPException(400, "Incorrect Password!")
    
    secret = os.getenv("PASSWORD_KEY")
    if not secret:
        print("PASSWORD_KEY missing")
        
    token = jwt.encode({"id": user_db.id}, secret)

    return {"token": token, "user": user_db}

@router.get('/')
def current_user(db: Session=Depends(get_db), user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(joinedload(User.favorites)).first()

    if not user:
        raise HTTPException(404, 'User not found!')
    
    return user
        