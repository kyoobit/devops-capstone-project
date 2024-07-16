FROM python:3.9-slim

# Create a working directory
WORKDIR /app
# Install the required dependencies
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy the appliaction contents
COPY service/ ./service/

# Add a user account and set permissions for the application content
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the appliaction service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]