FROM python:3.9-slim

RUN apt-get update -qq -y && \
    apt-get install -y \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-4-1 \
    libnss3 \
    xdg-utils
 
RUN pip install pytest-playwright beautifulsoup4

RUN playwright install

COPY yopass_secret_test.py .

CMD ["python", "yopass_secret_test.py"]
