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

# Función para verificar dependencias del sistema
check_system_deps() {
    local deps=("ffmpeg" "imagemagick" "git")
    local missing_deps=()

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "⚠️ Dependencias del sistema faltantes: ${missing_deps[*]}"
        echo "Por favor, instale las dependencias usando su gestor de paquetes:"
        echo "Por ejemplo: pkg install ${missing_deps[*]}"
        exit 1
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

# Verificar dependencias del sistema
check_system_deps

# Verificar si npm está instalado
if ! command -v npm &> /dev/null; then
    handle_error "npm no está instalado. Por favor, instale Node.js y npm primero."
fi

# Verificar si existe package.json
if [ ! -f "package.json" ]; then
    handle_error "No se encuentra package.json. Asegúrate de estar en el directorio correcto."
fi

# Verificar y crear directorio temporal
if [ ! -d "./HeteroJadiBot" ]; then
    mkdir -p "./HeteroJadiBot"
fi

# Limpiar instalación anterior
if [ -d "node_modules" ]; then
    echo "🗑️ Limpiando instalación anterior..."
    rm -rf node_modules
    rm -f package-lock.json
fi

# Instalar dependencias
echo "📦 Instalando dependencias..."
if ! npm install --no-audit --legacy-peer-deps; then
    echo "⚠️ Error en npm install, intentando instalación manual de dependencias..."
    
    # Instalar dependencias críticas manualmente
    npm install @adiwajshing/baileys@latest
    npm install @whiskeysockets/baileys@latest
    npm install chalk@4.1.2
    npm install ffmpeg
    npm install imagemagick
    npm install cfonts
    
    # Verificar si la instalación manual fue exitosa
    if [ $? -ne 0 ]; then
        handle_error "No se pudieron instalar las dependencias necesarias."
    fi
fi

echo -e "${GREEN}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${NC}"
echo -e "${GREEN}┃ 🚀 INICIANDO HETERO-BOT-MD...${NC}"
echo -e "${GREEN}┃ By cristopher231${NC}"
echo -e "${GREEN}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${NC}"

# Iniciar el bot
if ! npm start; then
    handle_error "No se pudo iniciar Hetero-Bot-MD. Por favor, revisa los logs anteriores."
fi
