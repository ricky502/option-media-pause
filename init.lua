-- 按住左 Option → 发一次 F8 暂停媒体
-- 松开左 Option → 发一次 F8 恢复媒体
-- 同时启用微信语音输入
-- 轮询检测，不拦截按键
-- 需要: brew install --cask hammerspoon

require('hs.ipc')

-- 禁止 Apple Music 启动（F8 可能意外激活它）
killMusicTimer = hs.timer.new(2, function()
    local music = hs.application.get("Music")
    if music then music:kill() end
end)
killMusicTimer:start()

local wasHeld = false

local function isOptionHeld()
    local out = hs.execute("/opt/homebrew/bin/check_alt")
    return tonumber(out) == 1
end

local function pressMediaKey()
    hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
    hs.eventtap.event.newSystemKeyEvent("PLAY", false):post()
end

-- 全局变量持有 timer，防止被 Lua GC 回收
optionTimer = hs.timer.new(0.1, function()
    local nowHeld = isOptionHeld()
    if nowHeld and not wasHeld then
        pressMediaKey()
    elseif not nowHeld and wasHeld then
        pressMediaKey()
    end
    wasHeld = nowHeld
end)
optionTimer:start()

hs.alert.show("✅", 1)
