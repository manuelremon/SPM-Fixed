FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY backend/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

RUN useradd -ms /bin/bash spm

COPY backend /app/backend

RUN mkdir -p /app/backend/logs /app/backend/data \
    && chown -R spm:spm /app/backend

USER spm

EXPOSE 5000

CMD ["gunicorn", "-w", "4", "-t", "60", "-b", "0.0.0.0:5000", "backend.app:create_app()"]
