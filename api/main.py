import os
import asyncio
from fastapi import FastAPI
from ib_insync import IB
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

# Получение конфигов из .env
IB_HOST = os.getenv("IB_HOST", "ibgateway")
IB_PORT = int(os.getenv("IB_GATEWAY_PORT", 4002))
IB_CLIENT_ID = int(os.getenv("IB_CLIENT_ID", 1))

ib = IB()

@app.on_event("startup")
async def startup_event():
    print(f"Waiting for IB Gateway...")
    await asyncio.sleep(10) 
    print(f"Connecting to IB Gateway at {IB_HOST}:{IB_PORT}...")
    await ib.connectAsync("ibgateway", 4002, clientId=1)

@app.on_event("shutdown")
def shutdown_event():
    ib.disconnect()

@app.get("/account")
def get_account_summary():
    summary = ib.accountSummary()
    return {item.tag: item.value for item in summary}

