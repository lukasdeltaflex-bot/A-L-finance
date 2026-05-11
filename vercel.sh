#!/bin/bash

# Script para build do Flutter no Vercel
echo "Instalando o Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"

echo "Rodando pub get..."
flutter pub get

echo "Fazendo o build para web..."
flutter build web --release --web-renderer html
