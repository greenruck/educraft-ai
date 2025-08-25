# EduCraft AI Setup Guide

This guide will walk you through setting up EduCraft AI from fork to deployment.

## 🚀 Quick Start (5 minutes)

### Option 1: One-Click Deploy (Recommended)
1. **Fork this repository** to your GitHub account
2. **Click a deploy button** in the main README
3. **Follow the 3-step setup** in your chosen platform
4. **Add your API keys** in the platform's environment variables
5. **Done!** Your EduCraft AI is live

### Option 2: Manual Setup

#### Prerequisites
- Node.js 18+ ([Download here](https://nodejs.org/))
- Git ([Download here](https://git-scm.com/))
- A code editor (VS Code recommended)

#### Step 1: Clone and Setup
```bash
git clone https://github.com/yourusername/educraft-ai.git
cd educraft-ai
./scripts/setup.sh
```

#### Step 2: Configure Environment
Update these files with your credentials:
- `frontend/.env.local` - Firebase configuration
- `functions/.env` - API keys (OpenAI, Claude)

#### Step 3: Initialize Firebase
```bash
firebase login
firebase use --add  # Select your Firebase project
```

#### Step 4: Start Development
```bash
npm run dev
```

Visit `http://localhost:3000` to see your app!

## 🔧 Configuration Details

### Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Enable these services:
   - **Firestore Database** (Start in test mode)
   - **Storage** (Start in test mode) 
   - **Functions** (Upgrade to Blaze plan if needed)
   - **Hosting** (Optional, for Firebase hosting)

### API Keys Required

#### OpenAI (Required for AI content generation)
1. Sign up at [OpenAI](https://platform.openai.com/)
2. Generate an API key
3. Add to `functions/.env`: `OPENAI_API_KEY=sk-...`

#### Anthropic Claude (Optional, alternative AI provider)
1. Sign up at [Anthropic](https://www.anthropic.com/)
2. Generate an API key  
3. Add to `functions/.env`: `ANTHROPIC_API_KEY=sk-ant-...`

### Environment Variables Template

**Frontend (.env.local):**
```env
# Firebase Configuration
REACT_APP_FIREBASE_API_KEY=AIzaSyB...
REACT_APP_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
REACT_APP_FIREBASE_PROJECT_ID=your-project
REACT_APP_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
REACT_APP_FIREBASE_MESSAGING_SENDER_ID=123456789
REACT_APP_FIREBASE_APP_ID=1:123456789:web:abc123def456

# Optional: Direct API access (not recommended for production)
REACT_APP_OPENAI_API_KEY=sk-...
```

**Functions (.env):**
```env
# Required: OpenAI API Key
OPENAI_API_KEY=sk-proj-...

# Optional: Anthropic Claude
ANTHROPIC_API_KEY=sk-ant-...

# Optional: Custom configurations
MAX_TOKENS=2000
TEMPERATURE=0.7
```

## 📱 Platform-Specific Setup

### Netlify
1. Connect your GitHub repository
2. Build settings:
   - Base directory: `frontend/`
   - Build command: `npm run build`
   - Publish directory: `build/`
3. Add environment variables in Netlify dashboard
4. Deploy automatically on git push

### Vercel
1. Import your GitHub repository
2. Framework preset: `Create React App`
3. Add environment variables in Vercel dashboard
4. Deploy automatically on git push

### Railway
1. Connect your GitHub repository
2. Select `Node.js` template
3. Add environment variables in Railway dashboard
4. Deploy automatically on git push

### Heroku
1. Create new Heroku app
2. Connect to GitHub repository
3. Add these buildpacks:
   - `heroku/nodejs`
4. Add environment variables (Config Vars)
5. Enable automatic deploys

## 🧪 Testing Your Setup

### Local Testing
```bash
# Run all tests
npm test

# Test specific components
npm run test:frontend
npm run test:functions

# Test with coverage
npm run test -- --coverage
```

### Production Testing
1. Generate sample content with different user roles
2. Test file downloads (PDF, DOCX, PPTX)
3. Verify state standards alignment works
4. Check responsive design on mobile

## 🚨 Troubleshooting

### Common Issues

**"Firebase project not found"**
```bash
firebase use --add
# Select your project from the list
```

**"OpenAI API key invalid"**
- Verify the key starts with `sk-proj-` (new format) or `sk-` (legacy)
- Check billing is enabled in OpenAI dashboard
- Ensure key has sufficient credits

**"Build fails on deployment"**
- Check Node.js version is 18+
- Clear node_modules and reinstall: `rm -rf node_modules && npm install`
- Check for environment variable typos

**"Content generation not working"**
- Verify API keys are set correctly
- Check browser console for error messages
- Ensure Firebase Functions are deployed

**"Files won't download"**
- Check Firebase Storage rules allow read access
- Verify file generation functions are working
- Check browser popup blockers

### Getting Help
- 📚 [Documentation](../docs/)
- 🐛 [Report Issues](https://github.com/yourusername/educraft-ai/issues)
- 💬 [Discord Community](https://discord.gg/educraft)
- 📧 Email: support@educraft.ai

## 📈 Performance Optimization

### Firebase Optimization
- Use Firebase emulator for local development
- Enable Firebase Performance Monitoring
- Optimize Firestore queries with indexes
- Use Firebase Storage for large files

### Frontend Optimization  
- Enable React production build
- Use code splitting for large components
- Optimize images and assets
- Enable service worker for caching

### Function Optimization
- Set appropriate memory limits
- Use connection pooling for external APIs
- Implement proper error handling
- Monitor function execution time

## 🔐 Security Best Practices

### API Key Security
- Never commit API keys to version control
- Use environment variables for all secrets
- Rotate API keys regularly
- Monitor API key usage

### Firebase Security
- Configure Firestore security rules
- Enable Firebase App Check
- Use Firebase Authentication for user management
- Monitor security events in Firebase Console

### Content Security
- Validate all user inputs
- Sanitize generated content
- Implement rate limiting
- Monitor for abuse patterns
