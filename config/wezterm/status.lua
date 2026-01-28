local wezterm = require 'wezterm'

local colors = require 'colors'
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
        left_background = colors.tab_bg,
        right_background = colors.tab_bg,
        main_background = background,
        border_side = BorderSide.Left,
        text_configs = {
            {
                foreground = foreground,
                text = " " .. tab.tab_index + 1 .. " ",
            },
        }
    }
end)

local function create_left_status_info(window, pane)
    local workspaces_component = components.create_workspace_component {
        backgrounds = {
            left = colors.black_3,
            sub = colors.black_3,
            main = colors.aqua_3,
            right = colors.aqua_1
        },
        border_side = BorderSide.Left,
    }

    local cwd_component = components.create_cwd_component(pane, {
        backgrounds = {
            left = colors.aqua_1,
            main = colors.aqua_1,
            right = colors.tab_bg,
        },
        border_side = BorderSide.Left
    })

    local result = {}
    utils.merge_tables(result, workspaces_component, cwd_component)

    return result
end

local function create_right_status_info(window, pane)
    local git_component = components.create_git_component(pane, false, {
        backgrounds = {
            left = colors.tab_bg,
            main = colors.black_1,
            right = colors.black_1,
        },
        border_side = BorderSide.Right,
    })

    local keymods_component = components.create_keymod_component(window, {
        backgrounds = {
            left = colors.black_1,
            main = colors.blue_2,
            right = colors.blue_2,
        },
        border_side = BorderSide.Right,
    })

    local datetime_component = components.create_time_component {
        backgrounds = {
            left = colors.blue_2,
            main = colors.blue_1,
            right = colors.blue_1,
        },
        border_side = BorderSide.Right,
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

