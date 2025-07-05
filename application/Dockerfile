FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential libleveldb-dev python3-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
ENTRYPOINT ["/start.sh"]
