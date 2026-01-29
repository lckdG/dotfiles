local wezterm = require 'wezterm'

local colors = require 'colors'
local term_config = require 'config'
local utils = require 'utils'
local components = require 'components'

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
        description = {
            backgrounds = {
                left = colors.tab_bg,
                main = background,
                right = colors.tab_bg,
            },
            border_side = BorderSide.Left,
        },
        text_configs = {
            {
                foreground = foreground,
                text = " " .. tab.tab_index + 1 .. " ",
            },
        }
    }
end)

local function create_left_status_info(window, pane)
    local tabs = term_config.tabs
    local workspaces_component = components.create_workspace(tabs.tab_a)
    local cwd_component = components.create_cwd(pane, tabs.tab_b)

    local result = {}
    utils.merge_tables(result, workspaces_component, cwd_component)

    return result
end

local function create_right_status_info(window, pane)
    local tabs = term_config.tabs
    local git_component = components.create_git(pane, false, tabs.tab_z)

    local keymods_component = components.create_keymod(window, tabs.tab_y)

    local datetime_component = components.create_time(tabs.tab_x)

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

