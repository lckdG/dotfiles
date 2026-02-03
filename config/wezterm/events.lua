local wezterm = require 'wezterm'

local definitions = require 'definitions'
local components = require 'components'
local utils = require 'utils'

wezterm.on("format-tab-title", function(tab, tabs, _, _, _, _)
    if #tabs == 1 then
        return { }
    end

    local pad = string.rep(" ", definitions.tab_padding)
    local tabs_def = definitions.tabs
    local tab_def = tab.is_active and tabs_def.mux_tab_active or tabs_def.mux_tab_inactive

    local tab_formats = components.create_tab {
        description = tab_def.description,
        text_configs = {
            {
                foreground = tab_def.text_color.main,
                text = pad .. tab.tab_index + 1 .. pad,
            },
        }
    }

    local padding = {}
    if  tab.tab_index == 0 then
        local padding_def = definitions.mux_tab_padding
        table.insert(padding, { Background = padding_def.Background })
        table.insert(padding, { Foreground = padding_def.Foreground })
        table.insert(padding, { Text = string.rep(" ", 3) })
    end

    return utils.merge_tables(padding, tab_formats)
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

