# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Expose port
EXPOSE 8000

# Run the FastAPI app with Gunicorn
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "app.main:app", "-b", "0.0.0.0:8000"]
# just run uvicorn app.main:app --host 0.0.0.0 --port 8000 when developing. gunicorn is better for production as it handles multiple calls better. 
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]