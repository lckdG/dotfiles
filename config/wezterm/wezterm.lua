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
local RIGHT_BORDER = wezterm.nerdfonts.ple_upper_left_triangle
local LEFT_BORDER = wezterm.nerdfonts.ple_lower_right_triangle

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
    local active_background = "689d6a"
    local active_foreground = "282828"

    local hover_foreground = "504945"

    local default_background = "8ec07c"
    local default_foreground = "fbf1c7"

    local background = default_background
    local foreground = default_foreground

    if tab.is_active then
        background = active_background
        foreground = active_foreground
    elseif hover then
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
        { Attribute = { Intensity = (tab.is_active or hover) and "Bold" or "Normal" } },
        { Attribute = { Underline = hover and "Double" or "None" } },
        { Text = " " .. title .. " " },
        "ResetAttributes",

        -- Right Border
        { Background = { Color = (tab.tab_index < #tabs - 1) and default_background or "333333" } },
        { Foreground = { Color = tab.is_active and active_background or default_background } },
        { Text = RIGHT_BORDER },
    }
end)

wezterm.on("update-status", function(window, pane)
    local mods, leds = window:keyboard_modifiers()
    local all_mods = window:leader_is_active() and "LEADER" or mods

    local filtered_mods = "NONE"
    for match in string.gmatch(all_mods, "([^|]+)") do
        if not string.find(match, "_") then
            if filtered_mods == "NONE" then
                filtered_mods = match
            else
                filtered_mods = match .. "|" .. filtered_mods
            end
        end
    end

    local bg_color1 = "#458588"
    local bg_color2 = "#83a598"
    local bg_color3 = "#282828"
    local fg_color1 = "#fbf1c7"
    local fg_color2 = "#1d2021"
    local fg_color3 = "#a89984"

    window:set_right_status(wezterm.format({
        -- Current date time
        { Foreground = { Color = bg_color3 } },
        { Text = " " .. LEFT_BORDER },
        { Foreground = { Color = fg_color3 } },
        { Background = { Color = bg_color3 } },
        { Text = " " .. wezterm.strftime "%H:%M %d-%m-%Y" },

        -- Key mods
        { Foreground = { Color = bg_color2 } },
        { Text = " " .. LEFT_BORDER },
        { Foreground = { Color = fg_color2 } },
        { Background = { Color = bg_color2 } },
        { Text = " " .. filtered_mods },

        -- Active workspace
        { Foreground = { Color = bg_color1 } },
        { Text = " " .. LEFT_BORDER },
        { Background = { Color = bg_color1 } },
        { Foreground = { Color = fg_color1 } },
        { Attribute = { Intensity = "Bold" } },
        { Text = " " .. wezterm.nerdfonts.md_folder_open .. " " .. window:active_workspace() .. "  " },
    }))
end)

config.term = "wezterm"
config.default_workspace = "home"

config.front_end = "OpenGL"
config.animation_fps = 60
config.max_fps = 180

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
    saturation = 1.0,
    brightness = 1.0,
}

config.font_size = 13
config.unicode_version = 14

config.color_scheme = 'Gruvbox dark, hard (base16)'

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
        { family = "LilexNerdFont", weight = "Medium", italic = false },
        "GoMonoNerdFont",
        "SymbolsNerdFont",
    }
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
    config.window_background_opacity = 0.0
    config.win32_system_backdrop = "Mica"
    config.font = wezterm.font_with_fallback(fonts_mapping["win"])
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    -- HACK: workaround to render on scaled displays
    config.dpi = 96
    config.default_prog = { "/usr/bin/fish" }
    config.font = wezterm.font_with_fallback(fonts_mapping["linux"])
    -- config.window_background_opacity = 0.95
    -- config.kde_window_background_blur = true
end

--------------- Key Bindings ---------------

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

local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milisecond = 1000 }
config.keys = {
    { key = "b", mods = "LEADER|CTRL", action = act({ SendString = "\x02" })},
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

    { key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "|", mods = "LEADER|SHIFT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
    { key = "n", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },

    { key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
    { key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
    { key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
    { key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
    { key = "LeftArrow", mods = "LEADER|CTRL", action = act({ AdjustPaneSize = { "Left", 5 } }) },
    { key = "DownArrow", mods = "LEADER|CTRL", action = act({ AdjustPaneSize = { "Down", 5 } }) },
    { key = "UpArrow", mods = "LEADER|CTRL", action = act({ AdjustPaneSize = { "Up", 5 } }) },
    { key = "RightArrow", mods = "LEADER|CTRL", action = act({ AdjustPaneSize = { "Right", 5 } }) },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "f", mods = "LEADER", action = act.ToggleFullScreen },

    { key = "d", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
    { key = "x", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },

    { key = "n", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(1)},
    { key = "p", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(-1)},

    { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    { key = "w", mods = "LEADER|SHIFT", action = act.PromptInputLine {
        description = wezterm.format {
            { Attribute = { Intensity = "Bold" } },
            { Text = "Enter name for target workspace" },
        },
        action = wezterm.action_callback(function(window, pane, line)
            if line then
                window:perform_action(
                    act.SwitchToWorkspace { name = line },
                    pane
                )
            end
        end)
    }}
}

--------------------------------------------

return config

