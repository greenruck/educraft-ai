#!/bin/bash
set -e

echo "🧪 Running EduCraft AI tests..."

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Run frontend tests
echo "🎨 Running frontend tests..."
cd frontend
npm test -- --watchAll=false --coverage
cd ..

# Run function tests
echo "⚙️  Running function tests..."
cd functions
npm test -- --coverage
cd ..

# Run linting
echo "🔍 Running linter..."
npm run lint || echo "⚠️  Linting failed"

# Security audit
echo "🔐 Running security audit..."
npm audit --audit-level moderate || echo "⚠️  Security issues found"

echo ""
echo "✅ All tests completed!"
echo ""
echo "📊 Coverage reports:"
echo "   Frontend: frontend/coverage/lcov-report/index.html"
echo "   Functions: functions/coverage/lcov-report/index.html"
echo ""
