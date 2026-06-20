FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright dependencies
RUN pip install playwright && \
    playwright install-deps && \
    playwright install chromium

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create directories
RUN mkdir -p logs

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=run.py

# Expose port
EXPOSE 5000

# Run application
CMD ["python", "run.py"]
