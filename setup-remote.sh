#!/bin/sh
set -e

# Create zellij config
mkdir -p ~/.config/zellij
cat > ~/.config/zellij/config.kdl << 'EOF'
default_shell "fish"
copy_on_select false
theme "solarized-dark"
EOF
echo "Created ~/.config/zellij/config.kdl"

# Add auto-launch to ~/.bashrc if not already present
if grep -q "ZELLIJ" ~/.bashrc 2>/dev/null; then
    echo "Zellij auto-launch already present in ~/.bashrc, skipping"
else
    cat >> ~/.bashrc << 'EOF'

if [ -n "$SSH_CONNECTION" ] && [ -z "$ZELLIJ" ] && command -v zellij >/dev/null 2>&1; then
    _theme="${TERM_THEME:-dark}"
    _config="$HOME/.config/zellij/config.kdl"
    sed -i "s/theme \"solarized-[a-z]*\"/theme \"solarized-${_theme}\"/" "$_config"
    touch "$_config"
    exec zellij attach --create main
fi
EOF
    echo "Added zellij auto-launch to ~/.bashrc"
fi

# Configure sshd to accept env vars forwarded by Ghostty
SSHD_CONF_DIR="/etc/ssh/sshd_config.d"
SSHD_CONF="$SSHD_CONF_DIR/ghostty-accept-env.conf"

if [ -f "$SSHD_CONF" ]; then
    echo "sshd config already exists at $SSHD_CONF, skipping"
else
    if [ ! -d "$SSHD_CONF_DIR" ]; then
        echo "Warning: $SSHD_CONF_DIR does not exist — check that your sshd_config includes 'Include /etc/ssh/sshd_config.d/*.conf'"
        echo "Skipping sshd config"
        exit 0
    fi
    echo "AcceptEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION TERM_THEME" | sudo tee "$SSHD_CONF" > /dev/null
    echo "Created $SSHD_CONF"
    sudo systemctl restart ssh
    echo "Restarted sshd"
fi
