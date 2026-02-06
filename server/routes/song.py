import os
import uuid
import cloudinary
import cloudinary.uploader
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session
from database import get_db
from middleware.auth_middleware import auth_middleware


router = APIRouter()


cloudinary.config( 
    cloud_name = "docuxwgzi", 
    api_key = "147756476361968", 
    api_secret = os.getenv("Cloudinary_API_Secret"),
    secure=True
)

@router.post('/upload')
def upload_song(song: UploadFile = File(...), 
                thumbnail: UploadFile = File(...), 
                artist: str = Form(), 
                song_name: str = Form(), 
                hex_code: str = Form(),
                db: Session = Depends(get_db),
                auth_dict = Depends(auth_middleware)) :
    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type='auto', folder=f'songs/{song_id}')
    print(song_res)
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type='image', folder=f'songs/{song_id}')
    print(thumbnail_res)
    return 'OK'