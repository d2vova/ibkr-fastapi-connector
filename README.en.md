# 🧠 IBKR REST API via FastAPI + Docker (Test Task)

Hello! This is a solution to a test task involving containerization of the IB Gateway and building a REST API using FastAPI.

---

## 📌 Project Summary

This project implements a REST API using FastAPI (Python), which communicates with the Interactive Brokers (IB) Gateway through `ib_insync`. The API service is fully containerized, and connects to an externally running IB Gateway.

Complete automation of the IB Gateway within a Docker container (in headless mode) was not successful — more on that in the “Why IB Gateway Doesn’t Run Well in Docker” section. However, the final solution works as expected: the API responds, IB Gateway is accessible, and the integration is testable.

---

## 🗂 Project Structure

```
ibkr_project/
├── api
│   ├── Dockerfile              # FastAPI container
│   ├── main.py                 # API logic
│   └── requirements.txt
├── docker-compose.yml          # FastAPI launch configuration
└── ib_gateway
    ├── config.ini              # IBC config (optional)
    ├── Dockerfile              # Gateway test build (not used in final)
    └── entrypoint.sh           # IBC + Gateway headless launch attempt
```

---

## 🔥 Completed Objectives

✅ FastAPI app in Docker  
✅ `/account` REST endpoint  
✅ Environment variable support  
✅ `docker-compose.yml` for easy launch  
✅ API testable via curl or Postman  
✅ Detailed documentation (this README)

---

## 🚀 How to Run

### 1. Start IB Gateway manually (on your host)

Ensure that:
- API access is enabled in IB Gateway settings
- Port `4002` is open
- `127.0.0.1` is added to the Trusted IPs

> Gateway has been tested and confirmed to work on Ubuntu — see screenshot in `./docs/ib_gateway_running.png`

### 2. Launch the FastAPI container

```bash
docker-compose up --build
```

### 3. Test API via curl

```bash
curl http://localhost:8000/account
```

---

## 🌍 Environment Variables

Defined in `docker-compose.yml`:

| Variable       | Description                                |
|----------------|--------------------------------------------|
| IB_HOST        | Host where IB Gateway is running           |
| IB_PORT        | API connection port (usually 4002)         |
| IB_CLIENT_ID   | Arbitrary client ID (integer)              |

---

## ❌ Why IB Gateway Doesn’t Run Well in Docker

Multiple attempts were made to run IB Gateway inside Docker:

- Official installer
- Offline version
- IBC (IB Controller) for auto-login
- Port forwarding
- Headless mode

Unfortunately, IB Gateway is a Java GUI application. It requires access to a `DISPLAY` environment (e.g. X server or VNC) to properly initialize. In a typical headless Docker environment, the gateway fails to open port `4002`, even though it appears to log in.

**Running it natively on Ubuntu works perfectly**, and confirms that the issue is Docker-specific.

---

## ✅ Final Working Setup

This hybrid approach was chosen as a reliable and stable solution:

- FastAPI runs inside Docker  
- IB Gateway runs natively (on host OS)

The connection is live, the API responds, and the system can be tested reliably.

---

## 🛠 Possible Improvements

- Run IB Gateway inside Docker using `xvfb` + `VNC`
- Use community container like [stoqey/ib-gateway-docker](https://github.com/stoqey/ib-gateway-docker)
- Run Gateway and API in separate containers connected via Docker network

---

## 👨‍💻 Author

Volodymyr Prykhodko  
[vprikhodko85@gmail.com]

---


