FROM python:3.9.18-bullseye

RUN git clone https://github.com/winiciusallan/rinha-backend-django.git /rinha

WORKDIR /rinha/app

RUN pip install -r requirements.txt

EXPOSE 80

CMD python manage.py makemigrations && python manage.py migrate 

ENTRYPOINT python manage.py runserver 0.0.0.0:80 
