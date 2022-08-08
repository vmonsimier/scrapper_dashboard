FROM python:3.8

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir web/ && mkdir web/staticfiles

WORKDIR /usr/src/app/web/staticfiles

RUN pip install --upgrade pip
COPY ./requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn"  , "-b", "10.0.0.8:80", "wsgi:application"]