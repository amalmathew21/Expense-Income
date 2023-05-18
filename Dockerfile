# Base image
FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update \
    && apt-get install -y \
        postgresql-client \
        libpq-dev \
        gcc \
        python3-dev \
        musl-dev \
        libffi-dev \
        openssl \
        libssl-dev \
        libgirepository1.0-dev \
        gir1.2-gtk-3.0 \
        gobject-introspection \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the Django project
WORKDIR /app

# Copy the Django project files to the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set the Django project's entry point
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "incomeexpense.wsgi:application"]

# Expose the port for the Django application
EXPOSE 8000
