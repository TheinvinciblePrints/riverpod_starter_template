#!/bin/bash

# Quick setup script for Flutter Riverpod Starter Template
# This script creates the required environment files from the template

echo "🚀 Setting up Flutter Riverpod Starter Template..."
echo ""

# Check if template exists
if [ ! -f ".env.template" ]; then
    echo "❌ Error: .env.template not found!"
    echo "Please make sure you're in the project root directory."
    exit 1
fi

# Create environment files
echo "📝 Creating environment files..."

# Copy template to each environment
cp .env.template .env.dev
cp .env.template .env.staging
cp .env.template .env.prod

echo "✅ Created .env.dev"
echo "✅ Created .env.staging"
echo "✅ Created .env.prod"
echo ""

# Install dependencies
echo "📦 Installing Flutter dependencies..."
flutter pub get

echo ""
echo "🔧 Running code generation..."
dart run build_runner build --delete-conflicting-outputs

echo ""
echo "🎉 Setup complete!"
echo ""
echo "⚠️  IMPORTANT: Don't forget to:"
echo "   1. Get your News API key from: https://newsapi.org/register"
echo "   2. Replace 'your_news_api_key_here' in all .env files with your actual key"
echo ""
echo "🧪 Test credentials for authentication:"
echo "   Username: emilys"
echo "   Password: emilyspassword"
echo ""
echo "🚀 Run the app with:"
echo "   flutter run --flavor dev -t lib/main.dart"
echo ""
