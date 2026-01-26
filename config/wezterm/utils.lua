local M = {}

local wezterm = require 'wezterm'

function M.is_windows()
    return wezterm.target_triple == "x86_64-pc-windows-msvc"
end

function M.is_linux()
    return wezterm.target_triple == "x86_64-unknown-linux-gnu"
end

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

function M.get_git_status(pane)
    local cwd = pane:get_current_working_dir()
    if cwd == nil then
        return nil
    end

    local git_dir = M.is_windows() and cwd.file_path:sub(2) or cwd.file_path
    local success, stdout, stderr = wezterm.run_child_process { "git", "-C", git_dir,  "status", "-v", "-b", "-s" }
    if not success then
        return nil
    else
        local _, changeCount = string.gsub(stdout, "\n%sM", "")
        local _, addCount = string.gsub(stdout, "\n%?%?", "")
        local _, delCount = string.gsub(stdout, "\n%sD", "")

        local localBranch, upstreamBranch = M.get_branch_names(stdout)

        return {
            localBranch = localBranch,
            upstreamBranch = upstreamBranch,
            addCount = addCount,
            changeCount = changeCount,
            delCount = delCount,
        }
    end
end

function M.get_branch_names(status_string)
    local _, _, branchNames = string.find(status_string, "##%s([%w/%.]+)[%s\n]")

    local localBranch = ""
    local upstreamBranch = ""

    local delimiterPos = string.find(branchNames, "%.%.%.")
    if delimiterPos ~= nil then
        localBranch = string.sub(branchNames, 1, delimiterPos - 1)
        upstreamBranch = string.sub(branchNames, delimiterPos + 3)
    else
        localBranch = branchNames
    end

    return localBranch, upstreamBranch
end

return M
