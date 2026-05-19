#!/bin/bash
# Option Media Pause - 安装脚本
# 按住左 Option 键暂停媒体 + 启用语音输入，松开恢复

set -e

echo "==> 安装 Option Media Pause"

# 1. 检查 Hammerspoon
if [ ! -d "/Applications/Hammerspoon.app" ]; then
    echo "安装 Hammerspoon..."
    brew install --cask hammerspoon
fi

# 2. 编译 check_alt
echo "编译 check_alt..."
cc -O2 -o /opt/homebrew/bin/check_alt check_alt.c -framework CoreGraphics
echo "✓ check_alt → /opt/homebrew/bin/check_alt"

# 3. 复制 Hammerspoon 配置
mkdir -p ~/.hammerspoon
cp init.lua ~/.hammerspoon/init.lua
echo "✓ init.lua → ~/.hammerspoon/init.lua"

# 4. 重新加载 Hammerspoon
open -g hammerspoon://reload 2>/dev/null || true
echo "✓ Hammerspoon 已重新加载"

echo ""
echo "✅ 安装完成！"
echo "   按住左 Option → 暂停媒体 + 启用语音输入"
echo "   松开左 Option → 恢复媒体播放"
