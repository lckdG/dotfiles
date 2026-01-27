local wezterm = require 'wezterm'
local colors = require('colors')
local utils = require('utils')
local components = require('components')

--------------- Useful Symbols ---------------

local TIME_ICON = wezterm.nerdfonts.fa_clock_o
local KEY_ICON = wezterm.nerdfonts.md_keyboard_outline
local WORKSPACE_ICON = wezterm.nerdfonts.md_folder_open

local GIT_ICON = wezterm.nerdfonts.dev_git
local UNKNOWN_ICON = wezterm.nerdfonts.md_dog

local AHEAD_ICON = wezterm.nerdfonts.oct_arrow_up
local BEHIND_ICON = wezterm.nerdfonts.oct_arrow_down
local UP_TO_DATE_ICON = wezterm.nerdfonts.cod_check_all

local ADD_ICON = wezterm.nerdfonts.cod_diff_added
local CHANGED_ICON = wezterm.nerdfonts.cod_diff_modified
local REMOVED_ICON = wezterm.nerdfonts.cod_diff_removed

----------------------------------------------

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
    if #tabs == 1 then
        return { }
    end

    local background = colors.black_4
    local foreground = colors.gray_2

    if tab.is_active then
        background = colors.yellow_1
        foreground = colors.white_1
    elseif hover then
        foreground = colors.black_4
    end

    return components.create_tab {
        left_background = colors.tab_bg,
        right_background = colors.tab_bg,
        main_background = background,
        text_configs = {
            {
                foreground = foreground,
                text = " " .. tab.tab_index + 1 .. " ",
            },
        }
    }
end)

local function create_left_status_info(window, pane)
    local workspaces = utils.get_workspace_carousel()

    local workspace_icon_component = components.create_tab {
        left_background = colors.black_1,
        right_background = workspaces.left ~= nil and colors.black_1 or colors.aqua_1,
        main_background = colors.black_1,
        text_configs = {
            {
                foreground = colors.aqua_1,
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
        left_workspace_component = components.create_tab {
            left_background = colors.black_1,
            right_background = colors.aqua_1,
            main_background = colors.black_1,
            text_configs = {
                {
                    foreground = colors.gray_2,
                    text = workspaces.left .. " ",
                },
            }
        }
    end

    local active_workspace_component = components.create_tab {
        left_background = colors.aqua_1,
        right_background = has_right_workspace and colors.black_1 or colors.tab_bg,
        main_background = colors.aqua_1,
        text_configs = {
            {
                foreground = colors.white_2,
                text = workspaces.active .. " "
            },
        }
    }

    if has_right_workspace then
        right_workspace_component = components.create_tab {
            left_background = colors.black_1,
            right_background = colors.tab_bg,
            main_background = colors.black_1,
            text_configs = {
                {
                    foreground = colors.gray_2,
                    text = workspaces.right .. " "
                },
            }
        }
    end

    local result = {}
    utils.merge_tables(result, workspace_icon_component, left_workspace_component, active_workspace_component, right_workspace_component)

    return result
end

local function get_key_mods(window)
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

    return filtered_mods
end

local function create_git_texts(pane, show_upstream)
    show_upstream = show_upstream or false
    local git_info = utils.get_git_status(pane)

    local config = {}

    if git_info ~= nil then
        table.insert(config, { foreground = colors.orange_2, icon = GIT_ICON, text = "" })
        table.insert(config, { foreground = colors.gray_1, text = git_info.localBranch })

        if show_upstream and git_info.upstreamBranch ~= nil and git_info.upstreamBranch ~= "" then
            table.insert(config, { foreground = colors.gray_1, text = " -> " .. git_info.upstreamBranch })
        end

        if git_info.aheadCount > 0 then
            table.insert(config, { foreground = colors.purple_2, icon = AHEAD_ICON, text = git_info.aheadCount })
        end

        if git_info.behindCount > 0 then
            table.insert(config, { foreground = colors.purple_2, icon = BEHIND_ICON, text = git_info.behindCount })
        end

        if git_info.aheadCount == 0 and git_info.behindCount == 0 then
            table.insert(config, { foreground = colors.purple_2, icon = UP_TO_DATE_ICON, text = "" })
        end

        table.insert(config, { foreground = colors.green_1, icon = ADD_ICON, text = git_info.addCount })
        table.insert(config, { foreground = colors.yellow_1, icon = CHANGED_ICON, text = git_info.changeCount })
        table.insert(config, { foreground = colors.red_1, icon = REMOVED_ICON, text = git_info.delCount })
    else
        table.insert(config, { foreground = colors.orange_2, icon = UNKNOWN_ICON, text = "" })
        table.insert(config, { foreground = colors.gray_1, text = " Woof" })
    end

    return config
end

local function create_right_status_info(window, pane)
    local git_texts = create_git_texts(pane, false)
    local git_component = components.create_tab {
        left_background = colors.tab_bg,
        right_background = colors.black_1,
        main_background = colors.black_1,
        text_configs = git_texts
    }

    local mods = get_key_mods(window)
    local keymods_component = components.create_tab {
        left_background = colors.black_1,
        right_background = colors.blue_2,
        main_background = colors.blue_2,
        text_configs = {
            {
                foreground = colors.black_2,
                icon = KEY_ICON,
                text = mods
            },
        }
    }

    local datetime_component = components.create_tab {
        left_background = colors.blue_2,
        right_background = colors.blue_1,
        main_background = colors.blue_1,
        text_configs = {
            {
                foreground = colors.white_1,
                icon = TIME_ICON,
                text = wezterm.strftime "%H:%M"
            },
        }
    }

    local result = {}
    utils.merge_tables(result, git_component, keymods_component, datetime_component)
    return result
end

wezterm.on("update-status", function(window, pane)
    local left_status = create_left_status_info(window, pane)
    window:set_left_status(wezterm.format(left_status))

    local right_status = create_right_status_info(window, pane)
    window:set_right_status(wezterm.format(right_status))
end)

