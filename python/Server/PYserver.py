# -*- coding: utf-8 -*-
import os
import shutil

from urllib import request
from fastapi import FastAPI, UploadFile, File ,Form, HTTPException
from fastapi.responses import JSONResponse
from tensorflow import keras
import joblib
from pydantic import BaseModel
import base64
import pymysql
from PIL import Image
import io
import sqlite3
from fastapi.staticfiles import StaticFiles
import numpy as np



app = FastAPI()

app.mount("/getimages", StaticFiles(directory=os.path.join(os.getcwd(), "getimages")), name="getimages")

@app.get("/test")
def gogo():
    return {"message" : "Hello 세상"}


UPLOAD_DIRECTORY = "./getimages"

@app.post("/upload")
async def upload_image(file: UploadFile = File(...)):
    box = (50,50,350,350)
    name = ['신선','평범','상함']
    model = keras.models.load_model("./Model(CNN)/best-cnn-model3.keras")

    # 모델 요약 보기
    #print(model.summary())
    # print(model)
    # print(file.size)
    # print(file.content_type)
    file_location = os.path.join(UPLOAD_DIRECTORY, file.filename)
    with open(file_location, "wb+") as file_object:
        shutil.copyfileobj(file.file, file_object)

    data = Image.open(f"./getimages/{file.filename}")
    #print(data.size)
    cropped_img = data.crop(box)
    a = np.array(cropped_img)
    a = a / 255.0
    a = a.reshape(1,300,300,3)
    result = model.predict(a)
    #print(name[np.argmax(result)])
    
    
    return JSONResponse(content={"result": name[np.argmax(result)]})

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app,host='127.0.0.1',port=8000)


# uvicorn PYserver:app --reload