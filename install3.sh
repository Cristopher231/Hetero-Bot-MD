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
NC='\033[0m'

echo -e "${GREEN}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${NC}"
echo -e "${GREEN}┃ INICIANDO HETERO-BOT-MD... ▣${NC}"
echo -e "${GREEN}┃ Creador: cristopher231${NC}"
echo -e "${GREEN}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${NC}"

# Verificar si npm está instalado
if ! command -v npm &> /dev/null; then
    handle_error "npm no está instalado. Por favor, instale Node.js y npm primero."
fi

# Verificar si existe package.json
if [ ! -f "package.json" ]; then
    handle_error "No se encuentra package.json. Asegúrate de estar en el directorio correcto."
fi

# Verificar y crear dirección del directorio temporal
if [ ! -d "./HeteroJadiBot" ]; then
    mkdir -p "./HeteroJadiBot"
fi

# Verificar si existe la carpeta node_modules
if [ ! -d "node_modules" ]; then
    echo "📦 Descargando módulos necesarios..."
    
    # Intentar npm install primero
    if ! npm install --no-audit; then
        echo "⚠️ Error en npm install, intentando método alternativo..."
        
        # Si falla npm install, intentar con el archivo comprimido
        echo "📥 Descargando node_modules.tar.gz..."
        if ! curl -L -o node_modules.tar.gz https://github.com/cristopher231/Hetero-Bot-MD/releases/download/v1.0.0/node_modules.tar.gz; then
            handle_error "No se pudo descargar node_modules.tar.gz"
        fi

        echo "📂 Extrayendo node_modules..."
        if ! tar -xzf node_modules.tar.gz; then
            cleanup
            handle_error "No se pudo extraer node_modules.tar.gz"
        fi
        
        cleanup
    fi
fi

# Instalar dependencias específicas necesarias
echo "🔧 Verificando dependencias adicionales..."
npm install ffmpeg --no-audit || echo "⚠️ Advertencia: No se pudo instalar ffmpeg"
npm install imagemagick --no-audit || echo "⚠️ Advertencia: No se pudo instalar imagemagick"

# Verificar y eliminar archivo package-lock.json si existe
if [ -f "package-lock.json" ]; then
    rm -f package-lock.json
fi

echo -e "${GREEN}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${NC}"
echo -e "${GREEN}┃ 🚀 INICIANDO HETERO-BOT-MD...${NC}"
echo -e "${GREEN}┃ By cristopher231${NC}"
echo -e "${GREEN}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${NC}"

# Iniciar el bot
if ! npm start; then
    handle_error "No se pudo iniciar Hetero-Bot-MD. Por favor, revisa los logs anteriores."
fi
