FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN apt-get update && apt-get install -y \
    bash curl wget git vim nano htop tmux screen \
    procps net-tools iproute2 \
    openssh-client \
    unzip zip tar gzip bzip2 \
    build-essential gcc g++ make \
    python3 python3-pip \
    nodejs npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

RUN echo 'export PS1="\[\e[36m\]philterm\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\$ "' >> /root/.bashrc \
    && echo 'alias ll="ls -la"' >> /root/.bashrc \
    && echo 'alias la="ls -A"' >> /root/.bashrc \
    && mkdir -p /workspace \
    && echo 'cd /workspace' >> /root/.bashrc

EXPOSE 3000

CMD ["ttyd", "-p", "3000", "-W", "bash"]
