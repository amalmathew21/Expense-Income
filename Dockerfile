
# Use an official Python runtime as a parent image
FROM python:3.9

ENV PYTHONUNBUFFERED = 1

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file into the container
COPY . /code

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project files into the container
COPY . .

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_HOST=localhost
ENV POSTGRES_PORT=5432
ENV POSTGRES_DB=expenseincome

# Expose port 8000 for the Django app
EXPOSE 8000

# Run migrations and start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
