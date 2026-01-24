local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local utils = require('utils')

--------------- Useful Symbols ---------------

local RIGHT_BORDER = wezterm.nerdfonts.ple_upper_left_triangle
local LEFT_BORDER = wezterm.nerdfonts.ple_lower_right_triangle

local TIME_ICON = wezterm.nerdfonts.fa_clock_o
local KEY_ICON = wezterm.nerdfonts.md_keyboard_outline
local WORKSPACE_ICON = wezterm.nerdfonts.md_folder_open

---------------- Color scheme ----------------

local aqua_1 = "689d6a"
local aqua_2 = "8ec07c"

local blue_1 = "458588"
local blue_2 = "83a598"

local yellow_1 = "d79921"
local yellow_2 = "fabd2f"

local black_1 = "1d2021"
local black_2 = "282828"
local black_3 = "3c3836"
local black_4 = "504945"

local gray_1 = "a89984"
local gray_2 = "928374"

local white_1 = "fbf1c7"
local white_2 = "ebdbb2"

local tab_bg = "333333"
----------------------------------------------

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
    local background = black_4
    local foreground = gray_2

    if tab.is_active then
        background = yellow_1
        foreground = white_1
    elseif hover then
        foreground = black_4
    end

    return {
        -- Left Border
        { Background = { Color = tab_bg } },
        { Foreground = { Color = background } },
        { Text = LEFT_BORDER },

        -- Tab title
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Attribute = { Intensity = (tab.is_active or hover) and "Bold" or "Normal" } },
        { Attribute = { Underline = hover and "Double" or "None" } },
        { Text = " " .. tab.tab_index + 1 .. " " },
        "ResetAttributes",

        -- Right Border
        { Background = { Color = tab_bg } },
        { Foreground = { Color = background } },
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

    local workspaces = utils.get_workspace_carousel()
    local left_status = {}

    table.insert(left_status, { Background = { Color = black_1 } })
    table.insert(left_status, { Foreground = { Color = aqua_1 } })
    table.insert(left_status, { Text = " " .. WORKSPACE_ICON .. " " })
    if workspaces.left ~= nil then
        table.insert(left_status, { Foreground = { Color = gray_2 } })
        table.insert(left_status, { Text = " " .. workspaces.left .. " " })
    end

    table.insert(left_status, { Background = { Color = aqua_1 } })
    table.insert(left_status, { Foreground = { Color = black_1 } })
    table.insert(left_status, { Text = RIGHT_BORDER })
    table.insert(left_status, { Attribute = { Intensity = "Bold" } })
    table.insert(left_status, { Foreground = { Color = white_2 } })
    table.insert(left_status, { Text = " " ..  workspaces.active .. " " })

    if (workspaces.right ~= nil) then
        table.insert(left_status, { Background = { Color = black_1 } })
        table.insert(left_status, { Foreground = { Color = aqua_1 } })
        table.insert(left_status, { Text = RIGHT_BORDER })

        table.insert(left_status, { Foreground = { Color = gray_2 } })
        table.insert(left_status, { Attribute = { Intensity = "Normal" } })
        table.insert(left_status, { Text = " " .. workspaces.right .. " " })
    end

    table.insert(left_status, { Background = { Color = tab_bg } } )
    table.insert(left_status, { Foreground = { Color = workspaces.right ~= nil and black_1 or aqua_1 } })
    table.insert(left_status, { Text = RIGHT_BORDER })

    window:set_left_status(wezterm.format(left_status))

    window:set_right_status(wezterm.format({
        -- Key mods
        { Foreground = { Color = black_4 } },
        { Text = " " .. LEFT_BORDER },
        { Foreground = { Color = gray_1 } },
        { Background = { Color = black_4 } },
        { Text = " " .. KEY_ICON .. " " .. filtered_mods },

        -- Current date time
        { Foreground = { Color = blue_1 } },
        { Text = " " .. LEFT_BORDER },
        { Foreground = { Color = white_1 } },
        { Background = { Color = blue_1 } },
        { Text = " " .. TIME_ICON .. "  " .. wezterm.strftime "%H:%M %d-%m-%Y" .. " " },
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

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
    config.window_background_opacity = 0.0
    config.win32_system_backdrop = "Mica"
    config.font = wezterm.font_with_fallback(fonts_mapping["win"])

    table.insert(launch_menu, {
        label = "Powershell",
        args = { "powershell.exe", "-NoLogo" }
    })

elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
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
    { key = "b", mods = "LEADER|CTRL", action = act({ SendString = "\x02" })},
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

    { key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "|", mods = "LEADER|SHIFT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
    { key = "n", mods = "LEADER", action = act.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" } },

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

