#!/bin/bash
set -e

echo "🚀 Setting up EduCraft AI..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ and try again."
    echo "   Download from: https://nodejs.org/"
    exit 1
fi

# Check Node.js version
node_version=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$node_version" -lt 18 ]; then
    echo "❌ Node.js version 18+ is required. Current version: $(node -v)"
    echo "   Please update Node.js: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js $(node -v) detected"

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Install function dependencies
echo "📦 Installing function dependencies..."
cd functions
npm install
cd ..

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "🔥 Installing Firebase CLI..."
    npm install -g firebase-tools
fi

echo "✅ Firebase CLI ready"

# Check if user is logged into Firebase
if ! firebase projects:list &> /dev/null; then
    echo "🔐 Please login to Firebase:"
    firebase login
fi

# Create environment files if they don't exist
if [ ! -f "frontend/.env.local" ]; then
    echo "📝 Creating frontend environment file..."
    cat > frontend/.env.local << EOF
# Firebase Configuration
REACT_APP_FIREBASE_API_KEY=your_api_key_here
REACT_APP_FIREBASE_AUTH_DOMAIN=your_project_id.firebaseapp.com
REACT_APP_FIREBASE_PROJECT_ID=your_project_id
REACT_APP_FIREBASE_STORAGE_BUCKET=your_project_id.appspot.com
REACT_APP_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
REACT_APP_FIREBASE_APP_ID=your_app_id

# OpenAI Configuration (for content generation)
REACT_APP_OPENAI_API_KEY=your_openai_key_here
EOF
    echo "⚠️  Please update frontend/.env.local with your Firebase and OpenAI credentials"
fi

if [ ! -f "functions/.env" ]; then
    echo "📝 Creating functions environment file..."
    cat > functions/.env << EOF
# OpenAI API Key for content generation
OPENAI_API_KEY=your_openai_key_here

# Optional: Anthropic Claude API Key
ANTHROPIC_API_KEY=your_claude_key_here
EOF
    echo "⚠️  Please update functions/.env with your API credentials"
fi

echo ""
echo "🎉 Setup complete! Next steps:"
echo ""
echo "1. Update your environment files:"
echo "   📁 frontend/.env.local - Add your Firebase config"
echo "   📁 functions/.env - Add your OpenAI API key"
echo ""
echo "2. Initialize Firebase project:"
echo "   firebase use --add"
echo ""
echo "3. Start development:"
echo "   npm run dev"
echo ""
echo "4. Or deploy to production:"
echo "   ./scripts/deploy.sh"
echo ""
