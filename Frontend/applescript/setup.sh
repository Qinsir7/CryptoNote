#!/bin/bash

# CryptoNote Setup Script
# This script sets up the CryptoNote application by:
# 1. Creating necessary directories
# 2. Setting up logging
# 3. Creating a LaunchAgent for automatic execution
# 4. Running the script for the first time

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}CryptoNote Setup${NC}"
echo "======================="

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/cryptonote.scpt"

# Create log directory
echo -e "${YELLOW}Setting up logging...${NC}"
mkdir -p ~/Library/Logs/CryptoNote
touch ~/Library/Logs/CryptoNote/output.log
touch ~/Library/Logs/CryptoNote/error.log
chmod 755 ~/Library/Logs/CryptoNote/output.log
chmod 755 ~/Library/Logs/CryptoNote/error.log

# Set script permissions
echo -e "${YELLOW}Setting script permissions...${NC}"
chmod +x "$SCRIPT_PATH"

# Create LaunchAgent
echo -e "${YELLOW}Creating LaunchAgent for automatic execution...${NC}"
mkdir -p ~/Library/LaunchAgents

# Get current user
CURRENT_USER=$(whoami)

cat > ~/Library/LaunchAgents/com.cryptonote.agent.plist << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.cryptonote.agent</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/osascript</string>
        <string>${SCRIPT_PATH}</string>
    </array>
    <key>StartInterval</key>
    <integer>60</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>${HOME}/Library/Logs/CryptoNote/output.log</string>
    <key>StandardErrorPath</key>
    <string>${HOME}/Library/Logs/CryptoNote/error.log</string>
    <key>UserName</key>
    <string>${CURRENT_USER}</string>
</dict>
</plist>
EOL

# Create run script for manual execution
echo -e "${YELLOW}Creating run script...${NC}"
cat > "$SCRIPT_DIR/run.sh" << EOL
#!/bin/bash
osascript "$SCRIPT_PATH"
echo "CryptoNote script executed. Check your Notes app for results."
EOL
chmod +x "$SCRIPT_DIR/run.sh"

# Create a permission request script
echo -e "${YELLOW}Creating permission request script...${NC}"
cat > "$SCRIPT_DIR/request-permission.scpt" << EOL
tell application "Notes"
    -- Simply get the list of notes to trigger permission request
    try
        get name of every note
        display dialog "Permission to access Notes has been granted." buttons {"OK"} default button "OK"
    on error
        display dialog "Please grant permission for the script to access Notes." buttons {"OK"} default button "OK"
    end try
end tell
EOL

# Run the permission request script
echo -e "${YELLOW}Requesting Notes permission...${NC}"
osascript "$SCRIPT_DIR/request-permission.scpt"

# Load LaunchAgent
echo -e "${YELLOW}Loading LaunchAgent...${NC}"
launchctl unload ~/Library/LaunchAgents/com.cryptonote.agent.plist 2>/dev/null
launchctl load ~/Library/LaunchAgents/com.cryptonote.agent.plist

echo -e "${GREEN}Setup complete!${NC}"
echo "CryptoNote will now:"
echo "1. Run automatically every 1 minute"
echo "2. Process notes in the 'CryptoNote' folder"
echo "3. Log activities to ~/Library/Logs/CryptoNote/output.log and error.log"
echo ""
echo "You can run it manually with: $SCRIPT_DIR/run.sh"
echo ""
echo -e "${YELLOW}Note:${NC} You may need to grant permission for the script to access Notes"
echo "when it runs for the first time."

# Ask if user wants to run now
read -p "Run CryptoNote now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${YELLOW}Running CryptoNote...${NC}"
    "$SCRIPT_DIR/run.sh"
fi
