FROM ubuntu:22.04

# Обновление и установка зависимостей
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    openjdk-17-jre \
    xvfb \
    socat \
    net-tools \
    x11vnc \
    && apt-get clean

# Копируем IB Gateway инсталлятор и IBC
WORKDIR /opt/ib

# Скачиваем IB Gateway (офлайн версия)
RUN curl -O https://download2.interactivebrokers.com/installers/ibgateway/stable-standalone/ibgateway-stable-standalone-linux-x64.sh && \
    chmod +x ibgateway-stable-standalone-linux-x64.sh && \
    ./ibgateway-stable-standalone-linux-x64.sh -q

# Устанавливаем IBC
RUN mkdir -p /opt/ibc && \
    curl -L -o IBC.zip https://github.com/IbcAlpha/IBC/releases/download/3.15.1/IBCLinux-3.15.1.zip && \
    unzip IBC.zip -d /opt/ib/ibc && \
    chmod +x /opt/ib/ibc/gatewaystart.sh && \
    chmod -R +x /opt/ib/ibc/scripts && \
    ln -s /opt/ib/ibc/scripts /opt/ibc/scripts && \
    ln -s /opt/ib/ibc /opt/ibc/ibc

# Копируем конфиги позже (будут в volume)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

