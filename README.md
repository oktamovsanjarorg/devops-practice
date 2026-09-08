# DevOps Practice & CI/CD Pipeline 🚀

Ushbu repozitoriy zamonaviy DevOps amaliyotlari: **Docker**, **Docker Compose**, **Nginx Reverse Proxy**, **GitHub Actions**, **Jenkins Pipeline** va **Pytest** avtomatlashtirilgan testlarini o'z ichiga olgan to'liq ishlab chiqarish (production-ready) muhitini namoyish etadi.

---

## 🏗️ Arxitektura (Architecture)

```text
       [ Foydalanuvchi / Klient ]
                   │
                   ▼ (HTTP :80)
     ┌───────────────────────────┐
     │    Nginx Reverse Proxy    │
     │  (Gzip, Proxy Headers)    │
     └─────────────┬─────────────┘
                   │
                   ▼ (HTTP :5000)
     ┌───────────────────────────┐
     │      Flask Web App        │
     │  (/, /health, /info)      │
     └───────────────────────────┘
```

---

## 🛠️ Texnologiyalar Steki

- **Dasturlash tili:** Python 3.11
- **Veb freymvork:** Flask 3.0.3
- **Testlash:** Pytest 8.3.2
- **Konteynerlashtirish:** Docker & Docker Compose (Multi-container)
- **Veb-server / Proxy:** Nginx Alpine
- **CI/CD:** GitHub Actions (`.github/workflows/ci.yml`) & Jenkins (`Jenkinsfile`)
- **Registrator:** Docker Hub

---

## 📂 Loyiha Tuzilmasi

```bash
devops-practice/
├── .github/
│   └── workflows/
│       └── ci.yml               # GitHub Actions CI/CD pipeline
├── nginx/
│   ├── conf.d/
│   │   └── default.conf         # Nginx upstream & server konfiguratsiyasi
│   └── nginx.conf               # Asosiy Nginx konfiguratsiyasi
├── scripts/
│   └── devops-ctl.sh            # Loyihani boshqarish utility skripti
├── tests/
│   ├── __init__.py
│   └── test_app.py              # Pytest avtomatlashtirilgan testlari
├── Dockerfile                   # Python Flask ilovasi uchun Dockerfile
├── docker-compose.yml           # Ko'p konteynerli arxitektura
├── Jenkinsfile                  # Jenkins Pipeline skripti
├── main.py                      # Flask asosiy ilovasi
├── README.md                    # Loyiha hujjatlari
└── requirements.txt             # Python bog'liqliklari
```

---

## 📡 API Endpointlar

| Metod | Endpoint | Tavsif | Status |
|---|---|---|---|
| `GET` | `/` | Asosiy sahifa xabari | `200 OK` |
| `GET` | `/health` | Konteyner va servis salomatlik tekshiruvi (uptime bilan) | `200 OK` |
| `GET` | `/info` | Servis versiyasi, muhiti va muallif ma'lumoti | `200 OK` |

---

## 🚀 Ishga Tushirish (Quick Start)

### 1. Avtomatlashtirish skripti orqali (Tavsiya etiladi):
```bash
# Barcha servis va obrazlarni yig'ish va ishga tushirish:
./scripts/devops-ctl.sh build
./scripts/devops-ctl.sh up

# Salomatlikni tekshirish:
./scripts/devops-ctl.sh health

# Testlarni yurgizish:
./scripts/devops-ctl.sh test

# Konteynerlarni to'xtatish:
./scripts/devops-ctl.sh down
```

### 2. Qo'lda Docker Compose orqali:
```bash
docker compose up -d --build
docker compose ps
curl http://localhost/health
```

---

## 🔄 CI/CD Konveyeri (Pipeline)

1. **Testlash Bosqichi:** Har bir `push`da Pytest orqali unit testlar avtomatik tekshiriladi.
2. **Qurilish Bosqichi (Build & Push):** Testlar muvaffaqiyatli yakunlansa, Docker image yig'ilib Docker Hub'ga jo'natiladi.
3. **Deploy Bosqichi:** Yangilangan versiya server muhitiga yetkaziladi.

---
**Muallif:** Sanjar Oktamov
