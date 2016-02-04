-----------------------------------------------
-- Set up
-----------------------------------------------

local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local hyper = {"shift", "cmd", "alt", "ctrl"}
local mash = {"ctrl", "cmd"}

hs.window.animationDuration = 0


-----------------------------------------------
-- auto-tile commands
-----------------------------------------------

hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
hotkey.bind(mash, "space", function() tiling.promote() end)
hotkey.bind(mash, "f", function() tiling.goToLayout("fullscreen") end)
hotkey.bind(mash, "f", function() tiling.goToLayout("fullscreen") end)
hotkey.bind(mash, "r", function() tiling.goToLayout("main-vertical") end)
hotkey.bind(mash, "c", function() tiling.goToLayout("columns") end)

-----------------------------------------------
-- hyper d for left one half window
-----------------------------------------------

hs.hotkey.bind(hyper, 'd', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper g for right one half window
-----------------------------------------------

hs.hotkey.bind(hyper, 'g', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper f for fullscreen
-----------------------------------------------

hs.hotkey.bind(hyper, 'f', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper e for top left one quarter window
-----------------------------------------------

hs.hotkey.bind(hyper, 'e', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper r for top half window
-----------------------------------------------

hs.hotkey.bind(hyper, 'r', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper t for top right one quarter window
-----------------------------------------------

hs.hotkey.bind(hyper, 't', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper b for bottom left one quarter window
-----------------------------------------------

hs.hotkey.bind(hyper, 'b', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y + (max.h / 2)
        f.w = max.w / 2
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper v for bottom right one quarter window
-----------------------------------------------

hs.hotkey.bind(hyper, 'v', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y + (max.h / 2)
        f.w = max.w
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- hyper c for bottom right one quarter window
-----------------------------------------------

hs.hotkey.bind(hyper, 'c', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.x
        f.y = max.y + (max.h / 2)
        f.w = max.w / 2
        f.h = max.h / 2
        win:setFrame(f)
    else
        hs.alert.show("No active window")
    end
end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

-----------------------------------------------
-- Hyper i to show window hints
-----------------------------------------------

hs.hotkey.bind(hyper, 'i', function()
    hs.hints.windowHints()
end)

----------------------------------------------
-- Shortcuts to common applications
----------------------------------------------
local appShortcuts = {
    ['a'] = 'Slack',
    ['q'] = 'Rubymine',
}
for shortcut, appName in pairs(appShortcuts) do
    hs.hotkey.bind({'alt', 'cmd'}, shortcut, function() hs.application.launchOrFocus(appName) end)
end
