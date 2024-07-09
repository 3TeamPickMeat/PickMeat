# -*- coding: utf-8 -*-
import json
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
import uvicorn


app = FastAPI()

app.mount("/getimages", StaticFiles(directory=os.path.join(os.getcwd(), "getimages")), name="getimages")

@app.get("/test")
def gogo():
    return {"message" : "Hello 세상"}


UPLOAD_DIRECTORY = "./getimages"



@app.post("/upload")
async def upload_image(file: UploadFile = File(...) ,x: str = Form(...), y: str = Form(...), w: str = Form(...), h: str = Form(...)):

    x_float = float(x)
    y_float = float(y)
    w_float = float(w)
    h_float = float(h)
    #print(size)
    print(f"x: {x_float}, y: {y_float}, w: {w_float}, h: {h_float}")
    # crop_data = json.loads(size)
    # print(crop_data)
    

    print("입장함")
    # print("스트링값",crop_data)
    # print("타입",crop_data.type())
    print(file)
    box = (x_float,y_float,w_float,h_float)
    name = ['신선','평범','상함']
    model = keras.models.load_model("./Model/best-cnn-model3.keras")

    # 모델 요약 보기
    #print(model.summary())
    # print(model)
    # print(file.size)
    # print(file.content_type)
    file_location = os.path.join(UPLOAD_DIRECTORY, file.filename)
    with open(file_location, "wb+") as file_object:
        shutil.copyfileobj(file.file, file_object)

    data = Image.open(f"./getimages/{file.filename}")
    print(data.size)
    cropped_img = data.crop((box))
    a = cropped_img.resize((300,300))
    a = np.array(a)
    a = a.reshape(-1,300,300,3)
    a = a / 255.0
    result = model.predict(a)
    print(name[np.argmax(result)])

    #return " ok"
    return JSONResponse(content={"result": name[np.argmax(result)]})

if __name__ == "__main__":

    uvicorn.run(app,host='192.168.10.138',port=8000)


# uvicorn PYserver:app --reload
# uvicorn PYserver:app --host 192.168.10.138 --port 8000 --reload