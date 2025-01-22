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

  -- cwd
  local uri = pane:get_current_working_dir()
  if uri then
    local cwd_uri = uri:sub(8)
    local slash = cwd_uri:find('/')
    if slash then
      local host = cwd_uri:sub(1, slash - 1)
      local dot = host:find '[.]'

      table.insert(elements, { Foreground = { Color = '#75b1a9' }})
      table.insert(elements, { Background = { Color = '#333333' }})
      table.insert(elements, { Text = '' .. ' ' })
      table.insert(elements, { Foreground = { Color = '#9a9eab' }})
      table.insert(elements, { Background = { Color = '#333333' }})
      table.insert(elements, { Text = (dot and host:sub(1, dot - 1) or host) .. '   ' })

      table.insert(elements, { Foreground = { Color = '#92aac7' }})
      table.insert(elements, { Background = { Color = '#333333' }})
      table.insert(elements, { Text = '' .. ' ' })
      table.insert(elements, { Foreground = { Color = '#9a9eab' }})
      table.insert(elements, { Background = { Color = '#333333' }})
      table.insert(elements, { Text = cwd_uri:sub(slash) .. '   ' })
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
}

return config


