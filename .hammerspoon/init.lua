-- Helpers
function chain_bind(mods, key, configure)
  modal = hs.hotkey.modal.new(mods, key)
  function modal:entered()
    hs.timer.doAfter(3, function() modal:exit() end)
  end
  modal:bind('', 'escape', function() modal:exit() end)

  return configure(modal, exit)
end

local window_chord = {"cmd", "shift", "ctrl"}


-- Maximise
hs.hotkey.bind(window_chord, "M", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen_f = win:screen():frame()

  f.x = screen_f.x
  f.y = screen_f.y
  f.h = screen_f.h
  f.w = screen_f.w
  win:setFrame(f)
end)

-- Left half
hs.hotkey.bind(window_chord, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h
  f.w = max.w / 2
  win:setFrame(f)
end)

-- Right half
hs.hotkey.bind(window_chord, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x * 2

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.h = max.h
  f.w = max.w / 2
  win:setFrame(f)
end)

-- Top half
hs.hotkey.bind(window_chord, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h / 2
  f.w = max.w
  win:setFrame(f)
end)

-- Bottom half
hs.hotkey.bind(window_chord, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  f.w = max.w
  win:setFrame(f)
end)

-- Top left half
hs.hotkey.bind(window_chord, "Y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

-- Top Right half
hs.hotkey.bind(window_chord, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

-- Bottom left half
hs.hotkey.bind(window_chord, "B", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

-- Bottom right half
hs.hotkey.bind(window_chord, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)


-- Move window between screens
chain_bind(window_chord, 'D', function(modal)
  function bind_send_to_screen(key, screen)
    modal:bind('', key, nil, function()
      if screen
      then
        local win = hs.window.focusedWindow()
        win:moveToScreen(screen)
      end
      modal:exit()
    end)
  end

  local screen = hs.window.focusedWindow():screen()
  bind_send_to_screen('H', screen:toWest())
  bind_send_to_screen('J', screen:toSouth())
  bind_send_to_screen('K', screen:toNorth())
  bind_send_to_screen('L', screen:toEast())
end)


-- Reload config for testing
hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Hammerspoon config reloaded")
