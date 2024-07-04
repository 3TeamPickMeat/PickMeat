# -*- coding: utf-8 -*-
from fastapi import FastAPI
import pymysql

app = FastAPI()

# def connect():
#     # MySql Connection
#     conn = pymysql.connect(
#         host='127.0.0.1',
#         user='root',
#         password='qwer1234',
#         db='education',
#         charset='utf8'
#     )
#     return conn

@app.get("/test")
def gogo():
    return "hi"


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app,host='127.0.0.1',port=8000)


# uvicorn students:app --reload