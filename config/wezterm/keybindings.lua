local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.configure(config_table)
    M.setup_mouse(config_table)
    M.setup_keys(config_table)
end

---@private
---@param config table
function M.setup_mouse(config)
    config.mouse_bindings = {
        {
            event = { Down = { streak = 1, button = { WheelUp = 1 } } },
            mods = "NONE",
            action = act.ScrollByPage(-0.25),
            alt_screen = false,
        },
        {
            event = { Down = { streak = 1, button = { WheelDown = 1 } } },
            mods = "NONE",
            action = act.ScrollByPage(0.25),
            alt_screen = false,
        }
    }
end

---@private
---@param config table
function M.setup_keys(config)
    config.disable_default_key_bindings = true

    config.leader = { key = "b", mods = "CTRL", timeout_milisecond = 2000 }
    config.keys = {
        { key = "F11", action = act.ToggleFullScreen },
        { key = "m", mods = "LEADER", action = act.EmitEvent "toggle-maximize-window" },

        { key = "b", mods = "LEADER|CTRL", action = act.SendString "\x02" },
        { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

        -- Key tables
        { key = "Escape", mods = "LEADER", action = act.ClearKeyTableStack },
        { key = "p", mods = "LEADER", action = act.ActivateKeyTable { name = "Managing", one_shot = false, prevent_fallback = true } },
        { key = "f", mods = "LEADER", action = act.ActivateKeyTable { name = "Font", one_shot = false, prevent_fallback = true } },

        { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo "Clipboard" },
        { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom "Clipboard" },

        { key = "}", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
        { key = "{", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
        { key = "]", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(1)},
        { key = "[", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(-1)},

        { key = "t", mods = "LEADER", action = wezterm.action_callback(function(window, pane)
            local tab, new_pane, _ = window:mux_window():spawn_tab {}
            window:perform_action(
                act.PromptInputLine {
                    description = wezterm.format {
                        { Attribute = { Intensity = "Bold" } },
                        { Text = "Enter name for new tab" },
                    },
                    action = wezterm.action_callback(function(win, _, line)
                        if line and line ~= "" then
                            tab:set_title(line)
                        end
                    end),
                },
                new_pane
            )
        end) },

        { key = ",", mods = "LEADER", action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = "Bold" } },
                { Text = "Enter new name for tab" },
            },
            action = wezterm.action_callback(function(win, pane, line)
                if line then
                    win:active_tab():set_title(line)
                end
            end),
        }},

        { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
        { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
        { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
        { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
        { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
        { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
        { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
        { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
        { key = "9", mods = "LEADER", action = act.ActivateTab(8) },

        { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
        { key = "l", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
        { key = "f", mods = "CTRL|SHIFT", action = act.Search { CaseSensitiveString="" }},

        { key = "n", mods = "LEADER", action = act.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" } },

        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },
        { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(-1) },
        { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(1) },

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

    config.key_tables = {
        Managing = {
            { key = "z", action = act.TogglePaneZoomState },

            { key = "c", action = act.RotatePanes "Clockwise" },
            { key = "C", action = act.RotatePanes "CounterClockwise" },

            { key = "h", action = act.ActivatePaneDirection "Left" },
            { key = "j", action = act.ActivatePaneDirection "Down" },
            { key = "k", action = act.ActivatePaneDirection "Up" },
            { key = "l", action = act.ActivatePaneDirection "Right" },

            { key = "LeftArrow", action = act.AdjustPaneSize { "Left", 2 } },
            { key = "DownArrow", action = act.AdjustPaneSize { "Down", 2 } },
            { key = "UpArrow", action = act.AdjustPaneSize { "Up", 2 } },
            { key = "RightArrow", action = act.AdjustPaneSize { "Right", 2 } },

            { key = "-", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
            { key = "|", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
            { key = "|", mods = "SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },

            { key = "D", action = act.CloseCurrentPane { confirm = true } },
            { key = "d", action = act.CloseCurrentTab { confirm = true } },

            { key = "Escape", action = act.PopKeyTable },
        },
        Font = {
            { key = "-", action = act.DecreaseFontSize },
            { key = "=", action = act.IncreaseFontSize },
            { key = "0", action = act.ResetFontSize },

            { key = "Escape", action = act.PopKeyTable },
        },
    }
end

return M

