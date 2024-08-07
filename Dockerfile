FROM alpine:latest

# Install necessary packages and build tools
RUN apk update && \
    apk add --no-cache \
    bash \
    fortune \
    netcat-openbsd \
    perl \
    perl-utils \
    wget \
    tar

# Download and install cowsay from source
RUN wget -O- https://github.com/tnalpgge/rank-amateur-cowsay/archive/master.tar.gz | tar zx && \
    cd rank-amateur-cowsay-master && \
    chmod +x install.sh && \
    ./install.sh /usr/local

# Create a working directory
WORKDIR /usr/src/app

# Copy the script into the container
COPY wisecow.sh .

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the port the app runs on, you need to use port mapping (RUN: docker run -p 4499:4499 wisecow-app)
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]
