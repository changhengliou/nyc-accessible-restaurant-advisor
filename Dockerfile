FROM python:3.7.9-stretch

WORKDIR /app

COPY . .

RUN apt-get update && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:ubuntugis/ppa

RUN apt-get update 2&>1

RUN apt-get install -y gdal-bin libgdal-dev

RUN pip install -r requirements.txt

RUN ./manage.py makemigrations && ./manage.py migrate && ./manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn", "nyc_accessible_restaurant_advisor.wsgi", "--bind=0.0.0.0:8000"]
