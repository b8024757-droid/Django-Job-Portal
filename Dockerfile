FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libcairo2 \
    libcairo2-dev \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf-2.0-0 \
    libglib2.0-0 \
    libgirepository-1.0-1 \
    libffi-dev \
    shared-mime-info \
    fonts-dejavu-core \
    libharfbuzz0b \
    libfribidi0 \
    libjpeg62-turbo \
    libpng16-16 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN cp .env.dev.sample .env

RUN chmod +x entrypoint.sh

ENV APP_HOME=/app
ENV DEBUG=1

RUN mkdir -p $APP_HOME/staticfiles
RUN mkdir -p $APP_HOME/mediafiles

EXPOSE 8000

CMD ["sh", "entrypoint.sh"]
