import random
from typing import List

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Payment(BaseModel):
    id: int
    product_name: str
    amount: float
    status: str  # "completed" or "failed"


payments: List[Payment] = []


@app.get("/")
async def root():
    return {"message": "Hello."}


@app.post("/pay")
def make_payment(payment: Payment):
    payment.status = random.choice(['completed', 'failed'])
    payments.append(payment)
    return payment


@app.get("/payments")
def get_payments():
    return payments
