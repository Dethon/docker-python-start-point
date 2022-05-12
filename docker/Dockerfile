FROM python:3.10.4-buster as base

WORKDIR /code
ENV PYTHONPATH=/code/app/src

ENV VIRTUAL_ENV=/code/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY docker/requirements_base.txt .
RUN python -m pip install -r requirements_base.txt

###############################################################################

FROM base as test
COPY docker/requirements_test.txt .
RUN python -m pip install -r requirements_test.txt
COPY . ./app
RUN python -m mypy app/src/ && python -m pytest app/tests

###############################################################################

FROM base as deploy
COPY docker/requirements_deploy.txt .
RUN python -m pip install -r requirements_deploy.txt
COPY . ./app
EXPOSE 80

###############################################################################

FROM base as dev
RUN apt update && \
  apt install -y \
  openssh-server \
  sudo \
  htop \
  git \
  nano \
  vim \
  curl \
  default-jre \
  iputils-ping

COPY docker/requirements_dev.txt .
COPY docker/requirements_test.txt .
COPY docker/requirements_deploy.txt .
RUN python -m pip install -r requirements_test.txt &&  \
  python -m pip install -r requirements_dev.txt && \
  python -m pip install -r requirements_deploy.txt
ENV MYPYPATH=/code/app/src

RUN mkdir /var/run/sshd && \
  echo "root:password" | chpasswd && \
  sed -i "s/\#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
EXPOSE 22

###############################################################################
