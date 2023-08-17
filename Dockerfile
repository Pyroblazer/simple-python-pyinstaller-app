FROM ubuntu:latest

# Install di dalam image
RUN apt-get update && apt-get install -y \
    nano \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Perintah default yang akan dijalankan saat kontainer berjalan
CMD ["/bin/bash"]