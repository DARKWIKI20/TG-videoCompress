FROM python:3.10-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# نصب مستقیم نسخه پایدار lxml قبل از سایر پکیج‌ها
RUN pip3 install --no-cache-dir "lxml<5.2.0" lxml_html_clean
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod +x run.sh

CMD ["bash", "run.sh"]
