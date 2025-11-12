local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- config.window_decorations = "RESIZE | TITLE"
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.0
config.win32_system_backdrop = "Mica"

config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
}

config.animation_fps = 30
config.inactive_pane_hsb = {
    brightness = 0.7,
}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 13

config.color_scheme = 'Orangish (terminal.sexy)'

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

config.default_prog = { 'powershell.exe', '-NoLogo' }

return config

