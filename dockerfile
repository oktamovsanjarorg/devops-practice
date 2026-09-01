FROM python:3.11-alpine
WORKDIR /app
COPY requirments.txt .
RUN pip install --no-cache-dir -r requirments.txt
COPY main.py .
CMD ["python3", "main.py"]
