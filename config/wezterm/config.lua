local colors = require 'colors'

local M = {}

M.tab_bar_color = colors.tab_bg
M.default_color = colors.black_4

M.tabs = {
    ---@type PredefinedComponent
    tab_a = {
        description = {
            backgrounds = {
                left = colors.black_3,
                main = colors.aqua_3,
                sub = colors.black_3,
                right = colors.aqua_1,
            },
            border_side = BorderSide.Left,
        },
        text_color = {
            icon = colors.aqua_1,
            main = colors.white_1,
            sub = colors.gray_1,
        }
    },
    ---@type PredefinedComponent
    tab_b = {
        description = {
            backgrounds = {
                left = colors.aqua_1,
                main = colors.aqua_1,
                sub = colors.black_3,
                right = colors.tab_bg,
            },
            border_side = BorderSide.Left,
        },
        text_color = {
            icon = colors.black_1,
            main = colors.black_2,
        }
    },
    ---@type PredefinedComponent
    tab_x = {
        description = {
            backgrounds = {
                left = colors.blue_2,
                main = colors.blue_1,
                sub = colors.black_3,
                right = colors.blue_1,
            },
            border_side = BorderSide.Right,
        },
        text_color = {
            icon = colors.white_1,
            main = colors.white_1,
        }
    },
    ---@type PredefinedComponent
    tab_y = {
        description = {
            backgrounds = {
                left = colors.black_1,
                main = colors.blue_2,
                sub = colors.black_3,
                right = colors.blue_2,
            },
            border_side = BorderSide.Right,
        },
        text_color = {
            icon = colors.black_2,
            main = colors.black_2,
        }
    },
    ---@type PredefinedComponent
    tab_z = {
        description = {
            backgrounds = {
                left = colors.tab_bg,
                main = colors.black_1,
                sub = colors.black_3,
                right = colors.black_1,
            },
            border_side = BorderSide.Right,
        },
        text_color = {
            icon = colors.orange_2,
            main = colors.gray_1,
        }
    },
}

M.git_colors = {
    commit_diff = colors.purple_2,
    add_count = colors.green_1,
    change_count = colors.yellow_1,
    remove_count = colors.red_1,
    rename_count = colors.orange_1,
}

return M

