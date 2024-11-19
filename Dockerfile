# Stage 1: Build Stage
# Use a Python base image to build the application
FROM --platform=linux/amd64 python:3.11-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies (using pip)
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Stage 2: Runtime Stage
# Use a smaller Python runtime image to run the app
FROM --platform=linux/amd64 python:3.11-alpine AS runtime

# Set the working directory in the runtime container
WORKDIR /app

# Copy the installed dependencies and app code from the build stage
COPY --from=build /app /app

# Expose the port the app will run on
EXPOSE 8080

# Set the command to run the app (assuming your app entry point is 'app.py')
CMD ["python", "app.py"]
