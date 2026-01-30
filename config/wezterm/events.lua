local wezterm = require 'wezterm'

local colors = require 'colors'
local definitions = require 'definitions'
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
    local tabs = definitions.tabs
    local tab_tables = {
        a = components.create_workspace(tabs.tab_a),
        b = components.create_cwd(pane, tabs.tab_b)
    }

    return utils.merge_tables(tab_tables.a, tab_tables.b)
end

local function create_right_status_info(window, pane)
    local tabs = definitions.tabs
    local tab_tables = {
        x = components.create_time(tabs.tab_x),
        y = components.create_keymod(window, tabs.tab_y),
        z = components.create_git(pane, false, tabs.tab_z),
    }

    return utils.merge_tables(tab_tables.z, tab_tables.y, tab_tables.x)
end

wezterm.on("update-status", function(window, pane)
    local left_status = create_left_status_info(window, pane)
    window:set_left_status(wezterm.format(left_status))

    local right_status = create_right_status_info(window, pane)
    window:set_right_status(wezterm.format(right_status))
end)

