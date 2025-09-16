# Dockerfile for Wisecow app
FROM alpine:3.19

# Install bash + netcat (required by wisecow.sh)
RUN apk add --no-cache bash netcat-openbsd

WORKDIR /app

# Copy script
COPY wisecow.sh .

# Make it executable
RUN chmod +x wisecow.sh

# Expose the port Wisecow runs on
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]

