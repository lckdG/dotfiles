local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local utils = require('utils')

require('status')

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
config.show_new_tab_button_in_tab_bar = false

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
    -- HACK: workaround to render on scaled displays
    config.dpi = 96
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

--------------- Key Bindings ---------------

config.disable_default_key_bindings = true
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

config.leader = { key = "b", mods = "CTRL", timeout_milisecond = 2000 }
config.keys = {
    { key = "b", mods = "LEADER|CTRL", action = act.SendString "\x02" },
    { key = "r", mods = "LEADER", action = act.ReloadConfiguration },
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo "Clipboard" },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom "Clipboard" },

    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "+", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },

    { key = "]", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1) },
    { key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
    { key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
    { key = "]", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(1)},
    { key = "[", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(-1)},

    { key = "l", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
    { key = "f", mods = "CTRL|SHIFT", action = act.Search { CaseSensitiveString="" }},

    { key = "-", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "|", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "n", mods = "LEADER", action = act.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" } },

    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },
    { key = "LeftArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Left", 5 } },
    { key = "DownArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Down", 5 } },
    { key = "UpArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Up", 5 } },
    { key = "RightArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Right", 5 } },

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "f", mods = "LEADER", action = act.ToggleFullScreen },

    { key = "d", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
    { key = "x", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },

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

