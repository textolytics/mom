#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Detect OS
OS="$(uname -s)"

echo -e "${BLUE}🎵 Music Player Setup Script${NC}\n"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check Node.js
echo -e "${YELLOW}Checking requirements...${NC}"
if command_exists node; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✓${NC} Node.js installed: $NODE_VERSION"
else
    echo -e "${RED}✗${NC} Node.js not found. Please install Node.js 16+"
    exit 1
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm -v)
    echo -e "${GREEN}✓${NC} npm installed: $NPM_VERSION"
else
    echo -e "${RED}✗${NC} npm not found"
    exit 1
fi

# Check Flutter
if command_exists flutter; then
    FLUTTER_VERSION=$(flutter --version | head -n 1)
    echo -e "${GREEN}✓${NC} Flutter installed: $FLUTTER_VERSION"
else
    echo -e "${RED}✗${NC} Flutter not found. Please install Flutter SDK"
    exit 1
fi

echo ""
echo -e "${BLUE}📦 Installing dependencies...${NC}\n"

# Install server dependencies
echo -e "${YELLOW}→${NC} Installing server dependencies..."
cd server || exit
npm install
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Server dependencies installed"
else
    echo -e "${RED}✗${NC} Failed to install server dependencies"
    exit 1
fi
cd ..

echo ""
echo -e "${YELLOW}→${NC} Installing Flutter dependencies..."
flutter pub get
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Flutter dependencies installed"
else
    echo -e "${RED}✗${NC} Failed to install Flutter dependencies"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}\n"

echo -e "${BLUE}📝 Next steps:${NC}\n"
echo -e "1. ${YELLOW}Start the server:${NC}"
echo "   cd server"
echo "   npm run dev"
echo ""
echo -e "2. ${YELLOW}In a new terminal, run the Flutter app:${NC}"
echo "   flutter run"
echo ""
echo -e "3. ${YELLOW}Access the server:${NC}"
echo "   http://localhost:3000/api/health"
echo ""
echo -e "${BLUE}📚 For more information:${NC}"
echo "   See SETUP_GUIDE.md"
echo ""
echo -e "${GREEN}Happy listening! 🎶${NC}"
