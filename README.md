# 🧠 IBKR REST API via FastAPI + Docker (Test Task)

Привет! Это решение тестового задания по контейнеризации IB Gateway и реализации REST API через FastAPI.

---

## 📌 Краткое описание

Я реализовал REST API с помощью FastAPI (Python), который обращается к IB Gateway через `ib_insync`. Всё завернуто в Docker-контейнер (FastAPI), и подключается к рабочему IB Gateway.

Полностью автоматизировать запуск самого IB Gateway **в Docker-контейнере** (в headless-режиме) не удалось — об этом ниже в разделе «Проблема с запуском Gateway в Docker». Тем не менее, **решение рабочее, API отвечает, IB Gateway доступен, можно тестировать.**

---

## 🗂 Структура проекта

```
ibkr_project/
├── api
│   ├── Dockerfile              # Контейнер FastAPI
│   ├── main.py                 # Логика API
│   └── requirements.txt
├── docker-compose.yml          # Запуск FastAPI
└── ib_gateway
    ├── config.ini              # Конфиг для IBC (если нужно)
    ├── Dockerfile              # (Пробный запуск Gateway)
    └── entrypoint.sh           # Скрипт запуска IBC + Gateway
```

---

## 🔥 Реализованные цели

✅ FastAPI-приложение в Docker  
✅ Эндпоинт `GET /account`  
✅ Использование переменных окружения  
✅ `docker-compose.yml` для запуска  
✅ API тестируется через curl/Postman  
✅ README с описанием

---

## 🚀 Запуск

### 1. Убедитесь, что IB Gateway уже работает на хосте (или в другом контейнере)
- Включите API в настройках IB Gateway
- Проверьте, что открыт порт `4002`
- В Trusted IP добавьте `127.0.0.1`

> Я запускал IB Gateway на Ubuntu вручную и всё работает 

### 2. Запуск FastAPI (через Docker)

```bash
docker-compose up --build
```

### 3. Тест API (через curl)

```bash
curl http://localhost:8000/account
```

---

## 🌍 Переменные окружения

Указаны в `docker-compose.yml`:

| Переменная     | Назначение                            |
|----------------|----------------------------------------|
| IB_HOST        | Хост, где работает IB Gateway          |
| IB_PORT        | Порт для API-соединения (обычно 4002) |
| IB_CLIENT_ID   | ID клиента (произвольный int)          |

---

## 📉 Проблема с запуском IB Gateway в Docker

Я потратил немало времени, чтобы запустить IB Gateway внутри контейнера. Пробовал:

- **Официальный установщик**
- **Offline-версию**
- **IBC** для автологина
- **Проброс портов**
- **Headless-режим**

Однако, из-за того что IB Gateway — это Java GUI-приложение, ему требуется `DISPLAY` и полноценное X-сервер окружение (`xvfb`, `fluxbox`, `x11vnc` и т.п.). В обычном контейнере без GUI он просто не запускается корректно — порт `4002` не поднимается, хотя логин как бы "проходит".

Я проверил: **на Ubuntu всё работает идеально**, порт открыт, API отвечает.

---

## ✅ Вывод

Контейнеризовано всё, что возможно в рамках текущих ограничений. Я построил рабочую связку:

- FastAPI в Docker
- IB Gateway — на хост-машине (Ubuntu)

API стабильно работает, запросы проходят. IB-соединение — живое.

---

## 🔧 Возможные улучшения

- Поднять IB Gateway в контейнере с GUI через `xvfb + VNC`
- Использовать репозиторий вроде [stoqey/ib-gateway-docker](https://github.com/stoqey/ib-gateway-docker)
- Разнести API и Gateway в разные контейнеры, связанные по сети

---

## 🧑‍💻 Автор

Volodymyr Prykhodko  
[vprikhodko85@gmail.com]

---

