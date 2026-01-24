local M = {}

local wezterm = require 'wezterm'

function M.basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

function M.get_tab_title(tab)
    local process_name = tab.active_pane.foreground_process_name
    local full_name = (process_name ~= nil and process_name ~= "") and process_name or tab.active_pane.title

    return M.basename(full_name)
end

function M.indexOf(value, array)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end

    return -1
end

function M.get_workspace_carousel()
    local all_workspaces = wezterm.mux.get_workspace_names()
    local active_workspace = wezterm.mux.get_active_workspace()

    if #all_workspaces == 1 then
        return {
            active = active_workspace,
            left = nil,
            right = nil
        }
    elseif #all_workspaces == 2 then
        local index = M.indexOf(active_workspace, all_workspaces)
        if index == 2 then
            return {
                active = active_workspace,
                left = all_workspaces[1],
                right = nil
            }
        end

        return {
            active = active_workspace,
            left = nil,
            right = all_workspaces[2]
        }
    else
        local index = M.indexOf(active_workspace, all_workspaces)
        local leftIndex = index - 1
        local rightIndex = index + 1

        if index == 1 then
            leftIndex = #all_workspaces
        elseif index == #all_workspaces then
            rightIndex = 1
        end

        return {
            active = active_workspace,
            left = all_workspaces[leftIndex],
            right = all_workspaces[rightIndex]
        }
    end
end

return M
