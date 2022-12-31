import uvicorn
from fastapi import FastAPI
from syl.greetings import hello_world

app = FastAPI()


@app.get("/")
def hello_world_greeting() -> dict:
    """:return: Json with a hello_world greeting"""

    return {"greeting": hello_world()}


def start() -> None:
    uvicorn.run("syl.entrypoints:app", host="0.0.0.0", port=8000, reload=True)


if __name__ == "__main__":
    start()
