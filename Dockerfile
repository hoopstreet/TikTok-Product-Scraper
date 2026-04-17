# Version 2.0.1 - Force Rebuild
FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1 PORT=7860 HOME=/home/user
RUN useradd -m -u 1000 user
WORKDIR /home/user/app
RUN apt-get update && apt-get install -y wget gnupg libglib2.0-0 libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxext6 libxfixes3 librandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2 && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir "crawl4ai[api,all]"
RUN playwright install chromium --with-deps
USER user
COPY --chown=user . .
EXPOSE 7860
CMD ["uvicorn", "crawl4ai.api.main:app", "--host", "0.0.0.0", "--port", "7860"]
