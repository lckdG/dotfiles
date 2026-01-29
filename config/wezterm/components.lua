local wezterm = require 'wezterm'
local utils = require 'utils'
local term_config = require 'config'

------------------ Useful Symbols ------------------

local nerdfonts = wezterm.nerdfonts
local BORDER = {
    Left = {
        Left = nerdfonts.ple_upper_right_triangle,
        Right = nerdfonts.ple_lower_left_triangle
    },
    Right = {
        Left = nerdfonts.ple_lower_right_triangle,
        Right = nerdfonts.ple_upper_left_triangle
    }
}

local TIME_ICON = nerdfonts.fa_clock_o
local KEY_ICON = nerdfonts.md_keyboard_outline
local WORKSPACE_ICON = nerdfonts.md_card_multiple
local DIRECTORY_ICON = nerdfonts.md_folder_open

local GIT_ICON = nerdfonts.dev_git
local UNKNOWN_ICON = nerdfonts.md_dog

local AHEAD_ICON = nerdfonts.oct_arrow_up
local BEHIND_ICON = nerdfonts.oct_arrow_down
local UP_TO_DATE_ICON = nerdfonts.cod_check_all

local ADD_ICON = nerdfonts.cod_diff_added
local CHANGED_ICON = nerdfonts.cod_diff_modified
local REMOVED_ICON = nerdfonts.cod_diff_removed

----------------------------------------------------

local M = {}

---@param config TabConfig
---@return table
function M.create_tab(config)
    local description = config.description
    local text_configs = config.text_configs

    local backgrounds = description.backgrounds
    local left_background = backgrounds.left or term_config.default_color
    local right_background = backgrounds.right or term_config.default_color
    local main_background = backgrounds.main

    local side = description.border_side or BorderSide.Left
    local border = BORDER[side]

    local status_format = {}

    table.insert(status_format, { Background = { Color = left_background } })
    table.insert(status_format, { Foreground = { Color = main_background } })
    table.insert(status_format, { Text = border.Left })

    table.insert(status_format, { Background = { Color = main_background } })
    local texts = M.create_text(text_configs)
    for _, v in ipairs(texts) do
        table.insert(status_format, v)
    end

    table.insert(status_format, { Background = { Color = right_background } })
    table.insert(status_format, { Foreground = { Color = main_background } })
    table.insert(status_format, { Text = border.Right })

    return status_format
end

---@private
---@param configs FormatText[]
---@return table
function M.create_text(configs)
    local result = {}

    for _, v in ipairs(configs) do
        if v.icon or v.text then
            table.insert(result, { Foreground = { Color = v.foreground } })

            if v.icon then
                table.insert(result, { Text = " " .. v.icon .. " " })
            end

            if v.text then
                local has_attr = v.attributes ~= nil
                if has_attr then
                    ---@type FormatTextAttributes
                    local attr = v.attributes

                    if attr.underline ~= nil then
                        table.insert(result, { Attribute = { Underline = attr.underline } })
                    end

                    if attr.italic ~= nil then
                        table.insert(result, { Attribute = { Italic = attr.italic } })
                    end

                    if attr.intensity ~= nil then
                        table.insert(result, { Attribute = { Intensity = attr.intensity } })
                    end
                end

                table.insert(result, { Text = tostring(v.text) })

                if has_attr then
                    table.insert(result, "ResetAttributes")
                end
            end
        end
    end

    return result
end

---@param component PredefinedComponent
---@return table
function M.create_workspace(component)
    local text_color = component.text_color

    local description = component.description
    local backgrounds = description.backgrounds

    local left = backgrounds.left
    local main = backgrounds.main
    local sub = backgrounds.sub or backgrounds.main
    local right = backgrounds.right

    local workspaces = utils.get_workspace_carousel()

    local workspace_icon_component = M.create_tab {
        description = {
            backgrounds = {
                left = left,
                main = sub,
                right = workspaces.left ~= nil and sub or main,
            },
            border_side = description.border_side,
        },
        text_configs = {
            {
                foreground = text_color.icon,
                icon = WORKSPACE_ICON,
                text = "",
            },
        }
    }

    local has_left_workspace = workspaces.left ~= nil
    local has_right_workspace = workspaces.right ~= nil

    local left_workspace_component = {}
    local right_workspace_component = {}

    if has_left_workspace then
        left_workspace_component = M.create_tab {
            description = {
                backgrounds = {
                    left = left,
                    main = sub,
                    right = main,
                },
                border_side = description.border_side,
            },

            text_configs = {
                {
                    foreground = text_color.sub or text_color.main,
                    text = workspaces.left .. " ",
                },
            }
        }
    end

    local active_workspace_component = M.create_tab {
        description = {
            backgrounds = {
                left = main,
                main = main,
                right = workspaces.right ~= nil and sub or right,
            },
            border_side = description.border_side,
        },
        text_configs = {
            {
                foreground = text_color.main,
                text = workspaces.active .. " ",
                attributes = {
                    intensity = Intensity.Bold
                }
            },
        }
    }

    if has_right_workspace then
        right_workspace_component = M.create_tab {
            description = {
                backgrounds = {
                    left = sub,
                    main = sub,
                    right = right,
                },
                border_side = description.border_side,
            },
            text_configs = {
                {
                    foreground = text_color.sub or text_color.main,
                    text = workspaces.right .. " "
                },
            }
        }
    end

    local result = {}
    utils.merge_tables(result, workspace_icon_component, left_workspace_component, active_workspace_component, right_workspace_component)

    return result
end

---@param pane unknown
---@param component PredefinedComponent
---@return table
function M.create_cwd(pane, component)
    local text_color = component.text_color
    local short_cwd = utils.get_short_cwd(pane) or "..."
    return M.create_tab {
        description = component.description,
        text_configs = {
            {
                foreground = text_color.icon,
                text = DIRECTORY_ICON .. " ",
            },
            {
                foreground = text_color.main,
                text = " " .. short_cwd .. " ",
            }
        }
    }
end

---@private
---@param pane unknown
---@param show_upstream? boolean
---@param text_color PredefinedTextColor
function M.create_git_texts(pane, show_upstream, text_color)
    show_upstream = show_upstream or false
    local git_colors = term_config.git_colors
    local git_info = utils.get_git_status(pane)

    local config = {}

    if git_info ~= nil then
        table.insert(config, { foreground = text_color.icon, icon = GIT_ICON, text = "" })
        table.insert(config, { foreground = text_color.main, text = git_info.localBranch })

        if show_upstream and git_info.upstreamBranch ~= nil and git_info.upstreamBranch ~= "" then
            table.insert(config, { foreground = text_color.main, text = " -> " .. git_info.upstreamBranch })
        end

        if git_info.aheadCount > 0 then
            table.insert(config, { foreground = git_colors.commit_diff, icon = AHEAD_ICON, text = git_info.aheadCount })
        end

        if git_info.behindCount > 0 then
            table.insert(config, { foreground = git_colors.commit_diff, icon = BEHIND_ICON, text = git_info.behindCount })
        end

        if git_info.aheadCount == 0 and git_info.behindCount == 0 then
            table.insert(config, { foreground = git_colors.commit_diff, icon = UP_TO_DATE_ICON, text = "" })
        end

        table.insert(config, { foreground = git_colors.add_count, icon = ADD_ICON, text = git_info.addCount })
        table.insert(config, { foreground = git_colors.change_count, icon = CHANGED_ICON, text = git_info.changeCount })
        table.insert(config, { foreground = git_colors.remove_count, icon = REMOVED_ICON, text = git_info.delCount })
    else
        table.insert(config, { foreground = text_color.icon, icon = UNKNOWN_ICON, text = "" })
        table.insert(config, { foreground = text_color.main, text = " Woof" })
    end

    return config
end

---@param component PredefinedComponent
---@return table
function M.create_time(component)
    local text_color = component.text_color

    return M.create_tab {
        description = component.description,
        text_configs = {
            {
                foreground = text_color.icon,
                icon = TIME_ICON,
            },
            {
                foreground = text_color.main,
                text = wezterm.strftime "%H:%M"
            }
        }
    }
end

---@param window unknown
---@param component PredefinedComponent
---@return table
function M.create_keymod(window, component)
    local mods = utils.get_key_mods(window)
    local text_color = component.text_color
    return M.create_tab {
        description = component.description,
        text_configs = {
            {
                foreground = text_color.icon,
                icon = KEY_ICON,
            },
            {
                foreground = text_color.main,
                text = mods,
            }
        }
    }
end

---@param pane unknown
---@param show_upstream? boolean
---@param component PredefinedComponent
---@return table
function M.create_git(pane, show_upstream, component)
    local text_color = component.text_color
    local texts = M.create_git_texts(pane, show_upstream, text_color)
    return M.create_tab {
        description = component.description,
        text_configs = texts,
    }
end

return M

