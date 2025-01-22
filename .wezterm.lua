local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

-- config.color_scheme = 'TokyoNight (Gogh)'
-- config.color_scheme = 'PaperColorLight (Gogh)'
-- config.color_scheme = 'iceberg-dark'
-- config.color_scheme = 'iceberg-light'
config.color_scheme = 'Palenight (Gogh)'
-- config.color_scheme = 'Selenized White (Gogh)'

-- config.window_background_opacity = 0.7
-- config.text_background_opacity = 0.9

config.font = wezterm.font_with_fallback({
  -- { family = "UDEV Gothic 35NFLG" },
  -- { family = "Monaspace Neon", harfbuzz_features = { "calt", "clig", "liga" } },
  { family = "FiraCode Nerd Font Mono", harfbuzz_features = { "onum", "cv24", "ss07" } },
  { family = "Cica" },
  { family = "Cica", assume_emoji_presentation = true },
  { family = "JetBrains Mono" },
})

local monaspace_features = { "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }

config.font_rules = {
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font {
      family = "Monaspace Radon Var",
      style = "Normal",
      weight = "Regular",
      stretch = "Expanded",
      harfbuzz_features = monaspace_features,
    },
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font {
      family = "Monaspace Krypton Var",
      style = "Italic",
      weight ="Black",
      harfbuzz_features = monaspace_features,
    },
  },
}

-- config.font_size = 21.0 -- 14.0 * 1.5
-- config.font_size = 18.0 -- 14.0 * 1.3
config.font_size = 14.0
-- config.font_size = 12.0

config.use_ime = true

config.initial_cols = 160
config.initial_rows = 48
config.tab_bar_at_bottom = true

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local title = ""
  local index = tab.tab_index + 1
  local cwd = ""
  if pane.current_working_dir ~= nil then
    cwd = basename(pane.current_working_dir.file_path)
  end
  local process = basename(pane.foreground_process_name)
  if string.sub(process, 1, 5) == "fish " then
    title = index .. ": " .. cwd
  else
    title = index .. ": " .. cwd .. " [" .. process .. "]"
  end return {
    { Text = title }
  }
end)

-- wezterm.on('format-window-title', function(tab)
--   return basename(tab.active_pane.foreground_process_name)
-- end)

local function updateLeftStatus(window, pane)
  local elements = {}

  if window:leader_is_active() then
    table.insert(elements, { Foreground = { Color = '#ffffff' }})
    table.insert(elements, { Background = { Color = '#333333' }})
    table.insert(elements, { Text = ' ' .. '' .. ' ' })
  elseif window:composition_status() then table.insert(elements, { Foreground = { Color = '#9a9eab' }})
    table.insert(elements, { Background = { Color = '#333333' }})
    table.insert(elements, { Text = ' ' .. 'あ' .. ' ' })
  else
    table.insert(elements, { Foreground = { Color = '#9a9eab' }})
    table.insert(elements, { Background = { Color = '#333333' }})
    table.insert(elements, { Text = ' ' .. '' .. ' ' })
  end

  window:set_left_status(wezterm.format(elements))
end

local function updateRightStatus(window, pane)
  local elements = {}

  -- font
  local config = window:effective_config()
  local font_size = config.font_size
  local main_font = config.font.font[1] and config.font.font[1].family or "Unknown"
  table.insert(elements, { Text = ' Font ' })
  table.insert(elements, { Attribute = { Intensity = 'Bold' } })
  table.insert(elements, { Text = string.format('%s:%s', main_font, font_size) })

  -- cwd
  local uri = pane:get_current_working_dir()
  if uri then
    if type(uri) == "userdata" then
      if uri.scheme == 'file' then
        local cwd = uri.file_path
        table.insert(elements, { Foreground = { Color = '#92aac7' }})
        table.insert(elements, { Background = { Color = '#333333' }})
        table.insert(elements, { Text = '' .. ' ' })
        table.insert(elements, { Foreground = { Color = '#9a9eab' }})
        table.insert(elements, { Background = { Color = '#333333' }})
        table.insert(elements, { Text = cwd .. '   ' })
      else
        local host = uri:host() or "unknown"
        local path = uri:path() or "/"
        local dot = host:find '[.]'
        table.insert(elements, { Foreground = { Color = '#75b1a9' }})
        table.insert(elements, { Background = { Color = '#333333' }})
        table.insert(elements, { Text = '' .. ' ' })
        table.insert(elements, { Foreground = { Color = '#9a9eab' }})
        table.insert(elements, { Background = { Color = '#333333' }})
        table.insert(elements, { Text = (dot and host:sub(1, dot - 1) or host) .. '   ' })
      end
    end
  end

  -- battery
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(elements, { Foreground = { Color = '#dfe166' }})
    table.insert(elements, { Background = { Color = '#333333' }})
    table.insert(elements, { Text = '' .. ' ' })
    table.insert(elements, { Foreground = { Color = '#9a9eab' }})
    table.insert(elements, { Background = { Color = '#333333' }})
    table.insert(elements, { Text = string.format('%.0f%%', b.state_of_charge * 100) .. '   ' })
  end

  -- date
  table.insert(elements, { Foreground = { Color = '#ffccac' }})
  table.insert(elements, { Background = { Color = '#333333' }})
  table.insert(elements, { Text = '󱪺' .. ' ' })
  table.insert(elements, { Foreground = { Color = '#9a9eab' }})
  table.insert(elements, { Background = { Color = '#333333' }})
  table.insert(elements, { Text = wezterm.strftime('%m/%-d %a') .. '   ' })
 
  -- time
  table.insert(elements, { Foreground = { Color = '#bcbabe' }})
  table.insert(elements, { Background = { Color = '#333333' }})
  table.insert(elements, { Text = '' .. ' ' })
  table.insert(elements, { Foreground = { Color = '#9a9eab' }})
  table.insert(elements, { Background = { Color = '#333333' }})
  table.insert(elements, { Text = wezterm.strftime('%H:%M:%S') .. '   ' })
 

  window:set_right_status(wezterm.format(elements))
end

wezterm.on('update-status', function(window, pane)
  updateLeftStatus(window, pane)
  updateRightStatus(window, pane)
end)

-- local function get_display_info()
--   local handle = io.popen("system_profiler SPDisplaysDataType | grep Resolution")
--   local result = handle:read("*a")
--   handle:close()
--   return result
-- end
-- 
-- wezterm.on('window-resized', function(window)
--   local dimensions = window:get_dimensions()
--   local width = dimensions.pixel_width
--   local display_info = get_display_info()
--   wezterm.log_info('width: ' .. width)
--   wezterm.log_info('display: ' .. display_info)
--   if width >= 2560 then
--     window:set_config_overrides({ font_size = 14 })
--   else
--     window:set_config_overrides({ font_size = 12 })
--   end
-- end)

config.status_update_interval = 1000

config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'F1',
    mods = 'CMD',
    action = wezterm.action_callback(function(window,  pane)
      window:set_config_overrides({
        font_size = 16.0,
      })
    end),
  },
  {
    key = 'F2',
    mods = 'CMD',
    action = wezterm.action_callback(function(window,  pane)
      window:set_config_overrides({
        font_size = 14.0,
      })
    end),
  },
  {
    key = 'F3',
    mods = 'CMD',
    action = wezterm.action_callback(function(window,  pane)
      window:set_config_overrides({
        font_size = 12.0,
      })
    end),
  },
}

return config


