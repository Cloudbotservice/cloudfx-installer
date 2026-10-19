#!/bin/bash
set -e

echo "========================================="
echo "🚀 CloudFX Panel - 1-Klick Installer"
echo "========================================="

# 1. Zielverzeichnis vorbereiten
TARGET_DIR="/var/www/html"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 2. Neuestes Master-Paket herunterladen & entpacken
echo "📦 Lade neueste Panel-Dateien herunter..."
curl -sSL https://tx.nevermind-roleplay.de/releases/cloudfx_client_latest.tar.gz | tar -xz

# 3. Node.js & PM2 sicherstellen
if ! command -v node &> /dev/null; then
    echo "⚙️ Installiere Node.js..."
    apt-get update -y >/dev/null 2>&1 || true
    apt-get install -y nodejs npm >/dev/null 2>&1 || true
fi

if ! command -v pm2 &> /dev/null; then
    echo "⚙️ Installiere PM2..."
    npm install -g pm2 >/dev/null 2>&1 || true
fi

# 4. Automatische Webserver-Konfiguration (Apache2 / Nginx / Direct)
if command -v apache2 &> /dev/null && [ -d "/etc/apache2" ]; then
    echo "🌐 Apache2 erkannt: Richte Port-Weiterleitung automatisch ein..."
    a2enmod proxy proxy_http >/dev/null 2>&1 || true
    cat << 'APACHE_EOF' > /etc/apache2/conf-available/cloudfx-panel.conf
ProxyPreserveHost On
ProxyPass / http://127.0.0.1:3000/ retry=1 acquire=3000 timeout=60
ProxyPassReverse / http://127.0.0.1:3000/
APACHE_EOF
    a2enconf cloudfx-panel >/dev/null 2>&1 || true
    systemctl reload apache2 >/dev/null 2>&1 || systemctl restart apache2 >/dev/null 2>&1 || true
elif command -v nginx &> /dev/null && [ -d "/etc/nginx" ]; then
    echo "🌐 Nginx erkannt."
fi

# 5. Initialisiere installierte Version synchron zum Master
mkdir -p "$TARGET_DIR/dist"
TARGET_VER="v2.5.9"
if [ -f "$TARGET_DIR/dist/latest_release.json" ]; then
    DETECTED_VER=$(grep -o '"version": *"[^"]*"' "$TARGET_DIR/dist/latest_release.json" | head -n1 | cut -d'"' -f4)
    if [ -n "$DETECTED_VER" ]; then
        TARGET_VER="$DETECTED_VER"
    fi
fi

if [ ! -f "$TARGET_DIR/dist/settings.json" ]; then
    RAND_ID="#GER-$((1000 + RANDOM % 9000))"
    cat << SETT_EOF > "$TARGET_DIR/dist/settings.json"
{
  "serverName": "FiveM CloudFX Server",
  "instanceId": "$RAND_ID",
  "installedVersion": "$TARGET_VER",
  "isMasterServer": false,
  "setupCompleted": false
}
SETT_EOF
else
    # Update installedVersion im bestehenden File
    sed -i "s/\"installedVersion\": *\"[^\"]*\"/\"installedVersion\": \"$TARGET_VER\"/" "$TARGET_DIR/dist/settings.json"
fi

# 6. FiveM Ingame System-Ressource panel_resmon bereitstellen & Altlasten bereinigen
FIVEM_SYS_DIR="/home/FiveM/server/alpine/opt/cfx-server/citizen/system_resources"
if [ -d "$FIVEM_SYS_DIR" ]; then
    echo "🎮 FiveM System-Ressourcen erkannt: Bereite panel_resmon vor..."
    mkdir -p "$FIVEM_SYS_DIR"
    curl -sSL https://tx.nevermind-roleplay.de/releases/panel_resmon.tar.gz | tar -xz -C "$FIVEM_SYS_DIR" >/dev/null 2>&1 || true

    # Webpack- & Monitor-Ordner (Altlasten/txAdmin) restlos löschen
    rm -rf "$FIVEM_SYS_DIR/webpack" >/dev/null 2>&1 || true
    rm -rf "$FIVEM_SYS_DIR/monitor" >/dev/null 2>&1 || true
    rm -rf /home/FiveM/server/alpine/opt/cfx-server/citizen/system_resources/webpack >/dev/null 2>&1 || true
    rm -rf /home/FiveM/server/alpine/opt/cfx-server/citizen/system_resources/monitor >/dev/null 2>&1 || true
    echo "🧹 Altlasten (webpack & monitor) erfolgreich bereinigt."
fi

# 7. Panel als Dienst starten
pm2 delete custom-panel >/dev/null 2>&1 || true
pm2 start server.js --name "custom-panel"
pm2 save >/dev/null 2>&1 || true

echo "========================================="
echo "✅ CloudFX Panel erfolgreich installiert & gestartet!"
echo "🌐 Aufrufbar direkt über die Server-IP im Browser!"
echo "========================================="
