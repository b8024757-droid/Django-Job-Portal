#!/bin/bash

python manage.py migrate --noinput
python manage.py collectstatic --noinput

python create_admin.py

exec gunicorn jobs.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 2
