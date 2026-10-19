# 🚀 CloudFX Panel - 1-Klick Installer

Offizieller 1-Klick Installer für das **Nevermind CloudFX FiveM Server Panel**.

## 💻 Installation

Führe einfach folgenden Befehl auf deinem Linux Server (Ubuntu/Debian) als `root` aus:

```bash
curl -sSL https://tx.nevermind-roleplay.de/install.sh | bash
```

### Features des Installers:
- 📦 Lädt automatisch das neueste CloudFX Client-Release
- ⚙️ Installiert und prüft Node.js & PM2
- 🌐 Automatische Webserver-Konfiguration (Apache2 / Nginx Reverse-Proxy)
- 🎮 Bereitstellung der `panel_resmon` Ingame-Ressource
- 🧹 Bereinigt Altlasten (`webpack` & `monitor`)
- 🚀 Automatischer Start als Hintergrunddienst via PM2 (`custom-panel`)
