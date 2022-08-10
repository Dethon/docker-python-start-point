FROM python:3.10.4-buster as base

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.14 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VIRTUAL_ENV="/opt/pysetup/.venv"
ENV PATH="$POETRY_HOME/bin:$VIRTUAL_ENV/bin:$PATH"

###############################################################################

FROM base as build-base
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    curl \
    build-essential
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

WORKDIR $PYSETUP_PATH
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev

###############################################################################

FROM base as test
WORKDIR $PYSETUP_PATH
COPY --from=build-base $POETRY_HOME $POETRY_HOME
COPY --from=build-base $PYSETUP_PATH $PYSETUP_PATH
RUN poetry install

COPY . /code/app
WORKDIR /code/app
ENV PYTHONPATH=/code/app/src
RUN mypy src && pytest tests

###############################################################################

FROM base as deploy
ENV FASTAPI_ENV=production
COPY --from=build-base $PYSETUP_PATH $PYSETUP_PATH
COPY ./src /app/
WORKDIR /app
EXPOSE 80

###############################################################################

FROM base as dev
ENV FASTAPI_ENV=development
WORKDIR $PYSETUP_PATH

COPY --from=build-base $POETRY_HOME $POETRY_HOME
COPY --from=build-base $PYSETUP_PATH $PYSETUP_PATH

RUN apt update && \
  apt install -y \
  sudo \
  htop \
  git \
  nano \
  vim \
  curl \
  default-jre \
  iputils-ping

ARG GID
ARG UID
RUN groupadd -f --gid $GID gro
RUN useradd --uid $UID --gid $GID -m usr
RUN chown $UID:$GID -R $POETRY_HOME && chown $UID:$GID -R $PYSETUP_PATH
USER $UID
ENV SHELL=/bin/bash

RUN poetry install

###############################################################################
