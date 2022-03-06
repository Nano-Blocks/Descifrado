FROM python:3.8

COPY ./descifrado ./descifrado
COPY ./Pipfile .
COPY ./Pipfile.lock .

RUN pip install pipenv
RUN pipenv install --ignore-pipfile --system