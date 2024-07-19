
from fastapi import FastAPI, Request

app = FastAPI()

@app.get("/")
def read_health(request: Request):
    return request.headers

@app.get("/health")
def read_health():
    return {"status": "healthy"}