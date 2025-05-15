#!/bin/bash

export TRADING_MODE=${TRADING_MODE:-paper}
export TWS_USERID=${TWS_USERNAME}
export TWS_PASSWORD=${TWS_PASSWORD}
export IB_GATEWAY_DIR="/root/Jts"

# Печатаем ENV переменные для логирования
echo "ENV переменные:"
echo "TWS_USERNAME=$TWS_USERNAME"
echo "TWS_PASSWORD=[скрыт]"
echo "TRADING_MODE=$TRADING_MODE"
echo "IB_GATEWAY_DIR=$IB_GATEWAY_DIR"

# Листаем директорию с IBC и её скрипты
echo "Содержимое /opt/ib/ibc:"
ls -l /opt/ib/ibc

echo "Содержимое /opt/ib/ibc/scripts:"
ls -l /opt/ib/ibc/scripts

# Настройка виртуального экрана
echo "Настраиваем Xvfb и DISPLAY..."
if ! pgrep Xvfb > /dev/null; then
    echo "Запускаем Xvfb..."
    Xvfb :1 -screen 0 1024x768x16 &
    sleep 2
else
    echo "Xvfb уже запущен"
fi
export DISPLAY=:1
echo "DISPLAY=$DISPLAY"

# Запуск IB Gateway через IBC
echo "Запускаем IB Gateway через IBC..."
cd /opt/ib/ibc

# Вместо фонового запуска используем прямой запуск, чтобы контейнер продолжал работать
./gatewaystart.sh

# Не даём контейнеру завершиться до завершения IB Gateway
wait $(pgrep gatewaystart.sh)

