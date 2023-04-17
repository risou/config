local wezterm = require 'wezterm'

return {
  default_prog = { '/opt/homebrew/bin/fish', '-l' },
--  color_scheme = 'TokyoNight (Gogh)',
  color_scheme = 'PaperColorLight (Gogh)',
--  color_scheme = 'iceberg-dark',
  font = wezterm.font "Cica",
  use_ime = true,
--  font_size = 21.0, -- 14.0 * 1.5
  font_size = 18.0, -- 14.0 * 1.3
--  font_size = 14.0,
  initial_cols = 160,
  initial_rows = 48,
  tab_bar_at_bottom = true,

  -- like tmux's "ctrl+t"
  leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 },

  -- split window
  keys = {
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
  },
}
