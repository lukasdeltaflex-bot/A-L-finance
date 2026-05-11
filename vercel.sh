#!/bin/bash

# Script para build do Flutter no Vercel
echo "Instalando o Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="`pwd`/flutter/bin:$PATH"

echo "Diagnósticos..."
flutter --version
flutter doctor

echo "Rodando pub get..."
flutter pub get

echo "Fazendo o build para web sem otimização (-O0) para garantir que nada quebre..."
flutter build web --release -O 0
