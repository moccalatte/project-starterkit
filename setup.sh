#!/bin/sh
# setup.sh - Simple onboarding script for project-starterkit

echo "🚀 Starting project setup..."

# Create virtual environment for Python (if requirements.txt exists)
if [ -f "requirements.txt" ]; then
    echo "🔹 Setting up Python virtual environment..."
    python3 -m venv venv
    . venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    echo "✅ Python dependencies installed."
fi

# Install Node.js dependencies (if package.json exists)
if [ -f "package.json" ]; then
    echo "🔹 Installing Node.js dependencies..."
    npm install
    echo "✅ Node.js dependencies installed."
fi

# Create logs directory if not exists
if [ ! -d "logs" ]; then
    echo "🔹 Creating logs directory..."
    mkdir logs
fi

# Create .env file if not exists
if [ ! -f ".env" ]; then
    echo "🔹 Creating .env file (edit this for secrets)..."
    echo "# Add your environment variables here" > .env
fi

echo "🔹 Setup complete!"
echo "Next steps:"
echo "1. Edit .env with your secrets and config."
echo "2. Review docs/ for project documentation."
echo "3. Activate Python venv with: source venv/bin/activate (if using Python)."
echo "4. Run your app or start development!"

echo "✅ Done."
