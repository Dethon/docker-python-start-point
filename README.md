# Docker-Python Start Point

[![CodeQL](https://github.com/Dethon/docker-python-start-point/actions/workflows/codeql.yml/badge.svg?branch=master)](https://github.com/Dethon/docker-python-start-point/actions/workflows/codeql.yml)
[![Hadolint](https://github.com/Dethon/docker-python-start-point/actions/workflows/hadolint.yml/badge.svg?branch=master)](https://github.com/Dethon/docker-python-start-point/actions/workflows/hadolint.yml)
[![Testing](https://github.com/Dethon/docker-python-start-point/actions/workflows/testing.yml/badge.svg?branch=master)](https://github.com/Dethon/docker-python-start-point/actions/workflows/testing.yml)

A hello world app that can be used as a start point to develop a Python web application.

## Description

The example application provides three Docker containers:
* A development container to connect your IDE with and develop the application without installing dependencies in your local machine.
* A deployment container that exposes the web application.
* A test cointainer that runs mypy and pytest when building.
