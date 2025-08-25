#!/bin/bash
set -e

echo "🚀 Deploying EduCraft AI..."

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Check if Firebase is configured
if [ ! -f "firebase.json" ]; then
    echo "❌ Firebase not configured. Please run 'firebase init' first."
    exit 1
fi

# Get the current Firebase project
project=$(firebase use | grep "currently using project" | awk '{print $4}' || echo "")
if [ -z "$project" ]; then
    echo "❌ No Firebase project selected. Run 'firebase use --add' first."
    exit 1
fi

echo "🔥 Deploying to Firebase project: $project"

# Build frontend
echo "🏗️  Building frontend..."
cd frontend
npm run build
cd ..

# Build functions
echo "⚙️  Building functions..."
cd functions
npm run build
cd ..

# Run tests (optional, comment out if no tests)
echo "🧪 Running tests..."
if npm run test:frontend -- --watchAll=false --passWithNoTests; then
    echo "✅ Frontend tests passed"
else
    echo "⚠️  Frontend tests failed, continuing anyway..."
fi

if npm run test:functions -- --passWithNoTests; then
    echo "✅ Function tests passed"
else
    echo "⚠️  Function tests failed, continuing anyway..."
fi

# Deploy to Firebase
echo "🚀 Deploying to Firebase..."
firebase deploy

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "Your EduCraft AI is now live at:"
echo "https://$project.firebaseapp.com"
echo ""
echo "Firebase Console:"
echo "https://console.firebase.google.com/project/$project"
echo ""

# Optional: Deploy to other platforms based on config files

if [ -f "netlify.toml" ] && command -v netlify &> /dev/null; then
    read -p "🌐 Deploy to Netlify as well? (y/n): " deploy_netlify
    if [ "$deploy_netlify" = "y" ]; then
        echo "🌐 Deploying to Netlify..."
        netlify deploy --prod
    fi
fi

if [ -f "vercel.json" ] && command -v vercel &> /dev/null; then
    read -p "▲ Deploy to Vercel as well? (y/n): " deploy_vercel
    if [ "$deploy_vercel" = "y" ]; then
        echo "▲ Deploying to Vercel..."
        vercel --prod
    fi
fi

echo "✅ All deployments complete!"
