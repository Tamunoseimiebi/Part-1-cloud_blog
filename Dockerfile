# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /Part-1-cloud_blog

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD [ "python", "init_db.py" ]

CMD [ "python", "app.py"]
