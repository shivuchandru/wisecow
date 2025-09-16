# Use a small base image with bash and netcat
FROM alpine:3.19

# Install bash and netcat (nc)
RUN apk add --no-cache bash netcat-openbsd

# Set working directory
WORKDIR /app

# Copy script into container
COPY wisecow.sh .

# Make script executable
RUN chmod +x wisecow.sh

# Expose port (the script uses 4499)
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]
