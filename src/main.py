from fastapi import FastAPI
from greetings import hello_world

app = FastAPI()


@app.get("/")
def hello_world_greeting() -> dict:
    """:return: Json with a hello_world greeting"""

    return {"greeting": hello_world()}
