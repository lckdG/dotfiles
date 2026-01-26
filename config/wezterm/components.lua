---@class (exact) TabConfig
---@field left_background? string
---@field right_background? string
---@field main_background string
---@field text_configs FormatText[]

---@class (exact) FormatText
---@field foreground string
---@field icon? string
---@field text string

local wezterm = require 'wezterm'
local colors = require('colors')

local RIGHT_BORDER = wezterm.nerdfonts.ple_upper_left_triangle
local LEFT_BORDER = wezterm.nerdfonts.ple_lower_right_triangle

local M = {}

---@param tab_config TabConfig
---@return table
function M.create_tab(tab_config)
    local left_background = tab_config.left_background or colors.black_1
    local right_background = tab_config.right_background or colors.black_1
    local main_background = tab_config.main_background

    local status_format = {}

    table.insert(status_format, { Background = { Color = left_background } })
    table.insert(status_format, { Foreground = { Color = main_background } })
    table.insert(status_format, { Text = LEFT_BORDER })

    table.insert(status_format, { Background = { Color = main_background } })
    local texts = M.create_text(tab_config.text_configs)
    for _, v in ipairs(texts) do
        table.insert(status_format, v)
    end

    table.insert(status_format, { Background = { Color = right_background } })
    table.insert(status_format, { Foreground = { Color = main_background } })
    table.insert(status_format, { Text = RIGHT_BORDER })

    return status_format
end

---@param configs FormatText[]
---@return table
function M.create_text(configs)
    local result = {}

    for _, v in ipairs(configs) do
        local foreground = v.foreground
        local text = v.text

        table.insert(result, { Foreground = { Color = foreground } })

        if v.icon then
            table.insert(result, { Text = " " .. v.icon .. " " })
        end

        table.insert(result, { Text = tostring(text) })
    end

    return result
end

return M

