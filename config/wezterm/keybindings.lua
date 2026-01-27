local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

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

---@param config table
function M.setup_keys(config)
    config.disable_default_key_bindings = true

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
        { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "n", mods = "LEADER", action = act.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" } },

        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },
        { key = "LeftArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Left", 5 } },
        { key = "DownArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Down", 5 } },
        { key = "UpArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Up", 5 } },
        { key = "RightArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize { "Right", 5 } },

        { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(-1) },
        { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(1) },

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
end

return M

