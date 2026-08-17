require 'types'

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local utils = require 'utils'
local definitions = require 'definitions'

require 'keybindings'.configure(config)
require 'events'

-- config.term = "wezterm"
config.default_workspace = "home"

config.front_end = "OpenGL"
config.animation_fps = 60
config.max_fps = 180

config.initial_cols = 140
config.initial_rows = 30
wezterm.GLOBAL.maximize_state = 0

config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 4,
    right = 4,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 50
config.show_new_tab_button_in_tab_bar = false

config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
}

config.font_size = 13
config.unicode_version = 14

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.colors = {
    tab_bar = {
        background = definitions.tab_bar_color,
    }
}

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.scrollback_lines = 5000

local fonts_mapping = {
    win = {
        { family = "Lilex Nerd Font", weight = "Medium", italic = false },
        "GoMono Nerd Font",
        "Symbols Nerd Font",
    },
    linux = {
        { family = "Lilex Nerd Font", weight = "Medium", italic = false },
        "GoMono Nerd Font",
        "Symbols Nerd Font",
    }
}

local launch_menu = {}

if utils.is_windows() then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
    config.window_background_opacity = 0.0
    config.win32_system_backdrop = "Mica"
    config.font = wezterm.font_with_fallback(fonts_mapping["win"])

    table.insert(launch_menu, {
        label = "Powershell",
        args = { "powershell.exe", "-NoLogo" }
    })

elseif utils.is_linux() then
    config.window_decorations = "TITLE | " .. config.window_decorations

    config.default_prog = { "/usr/bin/fish" }
    config.font = wezterm.font_with_fallback(fonts_mapping["linux"])
    -- config.window_background_opacity = 0.95
    -- config.kde_window_background_blur = true

    table.insert(launch_menu, {
        label = "Fish",
        args = { "/bin/fish" }
    })

    table.insert(launch_menu, {
        label = "Bash",
        args = { "/bin/bash" }
    })
end

table.insert(launch_menu, {
    label = "Neovim",
    args = { "nvim" }
})

table.insert(launch_menu, {
    label = "Lazygit",
    args = { "lazygit" }
})

config.launch_menu = launch_menu

return config

