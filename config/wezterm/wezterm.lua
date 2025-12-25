local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function get_process(tab)
    local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$") or tab.active_pane.foreground_process_name:match("([^/\\]+)$")

    return process_name
end

local function tab_title(tab_info)
    local process = get_process(tab_info)
    return process
end

-- local RIGHT_BORDER = ""
local RIGHT_BORDER = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
    local active_background = "fbf1c7"
    local active_foreground = "d79921"

    local hover_background = "928374"
    local hover_foreground = "ebdbb2"

    local default_background = "282828"
    local default_foreground = "a89984"

    local background = default_background
    local foreground = default_foreground

    if tab.is_active then
        background = active_background
        foreground = active_foreground
    elseif hover then
        background = hover_background
        foreground = hover_foreground
    end

    local title = tab_title(tab)
    title = wezterm.truncate_right(title, max_width - 2)

    return {
        -- Left Border
        { Background = { Color = tab.is_active and active_background or default_background } },
        { Foreground = { Color = default_background } },
        { Text = (tab.is_active and tab.tab_index ~= 0) and RIGHT_BORDER or " " },

        -- Tab title
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = " " .. title .. " " },

        -- Right Border
        { Background = { Color = default_background } },
        { Foreground = { Color = tab.is_active and active_background or default_background } },
        { Text = tab.is_active and RIGHT_BORDER or " " },
    }
end)

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByPage(-0.25),
        alt_screen = false,
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByPage(0.25),
        alt_screen = false,
    }
}

config.front_end = "OpenGL"
config.animation_fps = 60

config.initial_cols = 140
config.initial_rows = 30

-- config.window_decorations = "RESIZE | TITLE"
config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 4,
    right = 4,
    top = 8,
    bottom = 0,
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50
config.tab_and_split_indices_are_zero_based = true

config.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 13

config.color_scheme = 'Gruvbox dark, hard (base16)'

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.scrollback_lines = 5000

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
    config.window_background_opacity = 0.0
    config.win32_system_backdrop = "Mica"
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    -- HACK: workaround to render on scaled displays
    config.dpi = 96
    config.default_prog = { "/usr/bin/fish" }
    -- config.window_background_opacity = 0.95
    -- config.kde_window_background_blur = true
end

return config

