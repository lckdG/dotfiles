local M = {}

-- Color from the gruvbox material scheme: https://github.com/morhetz/gruvbox
M.red_1 = "cc241d"
M.red_2 = "fb4934"

M.green_1 = "98971a"
M.green_2 = "b8bb26"
M.green_3 = "79740e"

M.yellow_1 = "d79921"
M.yellow_2 = "fabd2f"

M.blue_1 = "458588"
M.blue_2 = "83a598"

M.purple_1 = "b16286"
M.purple_2 = "d3869b"

M.aqua_1 = "689d6a"
M.aqua_2 = "8ec07c"
M.aqua_3 = "427b58"

M.orange_1 = "d65d0e"
M.orange_2 = "fe8019"

M.black_1 = "1d2021"
M.black_2 = "282828"
M.black_3 = "3c3836"
M.black_4 = "504945"

M.gray_1 = "a89984"
M.gray_2 = "928374"

M.white_1 = "fbf1c7"
M.white_2 = "ebdbb2"

M.tab_bg = "333333"

M.predefined = {
    tab_a = {
        backgrounds = {
            left = M.black_3,
            main = M.aqua_3,
            sub = M.black_3,
            right = M.aqua_1,
        },
        foreground = {
            icon = M.aqua_1,
            main = M.white_1,
            sub = M.gray_1,
        }
    },
    tab_b = {
        backgrounds = {
            left = M.aqua_1,
            main = M.aqua_1,
            sub = M.black_3,
            right = M.tab_bg,
        },
        foreground = {
            icon = M.black_1,
            main = M.black_2,
        }
    },
    tab_x = {
        backgrounds = {
            left = M.blue_2,
            main = M.blue_1,
            sub = M.black_3,
            right = M.blue_1,
        },
        foreground = {
            icon = M.white_1,
            main = M.white_1,
        }
    },
    tab_y = {
        backgrounds = {
            left = M.black_1,
            main = M.blue_2,
            sub = M.black_3,
            right = M.blue_2,
        },
        foregorund = {
            icon = M.black_2,
            main = M.black_2,
        }
    },
    tab_z = {
        backgrounds = {
            left = M.tab_bg,
            main = M.black_1,
            sub = M.black_3,
            right = M.black_1,
        },
        foreground = {
            icon = M.orange_2,
            main = M.gray_1,
        }
    }
}

M.git_colors = {
    commit_diff = M.purple_2,
    add_count = M.green_1,
    change_count = M.yellow_1,
    remove_count = M.red_1,
}

return M
