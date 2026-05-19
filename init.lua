require('hs.ipc')

local wasHeld = false

local function killMusic()
    os.execute("killall -9 Music 2>/dev/null")
end

local function pressMediaKey()
    killMusic()
    hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
    hs.eventtap.event.newSystemKeyEvent("PLAY", false):post()
    killMusic()
    hs.timer.doAfter(0.05, killMusic)
    hs.timer.doAfter(0.15, killMusic)
    hs.timer.doAfter(0.3, killMusic)
end

-- 事件驱动：只在按键状态变化时触发，空闲时零 CPU
optionWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    local nowHeld = flags.alt

    if nowHeld and not wasHeld then
        pressMediaKey()
    elseif not nowHeld and wasHeld then
        pressMediaKey()
    end
    wasHeld = nowHeld
end)
optionWatcher:start()

hs.alert.show("✅", 1)
