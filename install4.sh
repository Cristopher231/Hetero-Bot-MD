#!/bin/bash

# Función para manejo de errores
handle_error() {
    echo "❌ Error: $1"
    exit 1
}

# Función para limpiar archivos temporales
cleanup() {
    if [ -f "node_modules.tar.gz" ]; then
        rm -f node_modules.tar.gz
    fi
}

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${NC}"
echo -e "${GREEN}┃ INICIANDO HETERO-BOT-MD... ▣${NC}"
echo -e "${GREEN}┃ Creador: cristopher231${NC}"
echo -e "${GREEN}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${NC}"

# Actualizar paquetes de termux
echo "🔄 Actualizando paquetes..."
pkg update -y && pkg upgrade -y

# Instalar dependencias necesarias
echo "📦 Instalando dependencias del sistema..."
pkg install -y nodejs git ffmpeg imagemagick python yarn

# Limpiar caché de npm
echo "🧹 Limpiando caché de npm..."
npm cache clean -f

# Actualizar npm
echo "⬆️ Actualizando npm..."
npm install -g npm@latest

# Eliminar instalaciones previas
if [ -d "node_modules" ]; then
    echo "🗑️ Eliminando instalación anterior..."
    rm -rf node_modules
    rm -f package-lock.json
    rm -f yarn.lock
fi

# Instalar dependencias usando yarn
echo "📥 Instalando dependencias con yarn..."
yarn install --ignore-scripts --network-timeout 100000

# Si yarn falla, intentar con npm
if [ $? -ne 0 ]; then
    echo "⚠️ Yarn falló, intentando con npm..."
    npm install --force --legacy-peer-deps

    # Instalar dependencias específicas que pueden causar problemas
    npm install --force @whiskeysockets/baileys
    npm install --force sharp
    npm install --force @adiwajshing/baileys
    npm install --force cfonts
    npm install --force libvips
fi

# Instalar dependencias globales necesarias
echo "🔧 Instalando dependencias globales..."
npm install -g pm2 typescript ts-node

echo -e "${GREEN}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${NC}"
echo -e "${GREEN}┃ 🚀 INICIANDO HETERO-BOT-MD...${NC}"
echo -e "${GREEN}┃ By cristopher231${NC}"
echo -e "${GREEN}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${NC}"

# Iniciar el bot
if ! npm start; then
    handle_error "No se pudo iniciar Hetero-Bot-MD. Por favor, revisa los logs anteriores."
fi
