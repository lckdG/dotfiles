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

---@return string?
function M.get_cwd(pane)
    local cwd = pane:get_current_working_dir()
    if cwd == nil then
        return nil
    end

    return M.is_windows() and cwd.file_path:sub(2) or cwd.file_path
end

function M.get_short_cwd(pane)
    local cwd = M.get_cwd(pane)
    if cwd == nil then
        return nil
    end

    ---@cast cwd string

    local sep = M.is_windows() and "\\" or "/"

    local _, parent_count = cwd:gsub("/", "")
    if parent_count > 3 then
        local _, _, dir1, dir2, dir3 = string.find(cwd, ".*/(.+)/(.+)/(.+)$")

        return ".." .. sep .. dir1 .. sep .. dir2 .. sep .. dir3
    else
        cwd = cwd:gsub("/", sep)
    end

    return cwd
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
    local git_dir = M.get_cwd(pane)
    local success, stdout, stderr = wezterm.run_child_process { "git", "-C", git_dir,  "status", "-vbs" }
    if not success or stdout == nil then
        return nil
    else
        local _, addCount = string.gsub(stdout, "\n%?%?", "")
        local _, stagedAddCount = string.gsub(stdout, "\nA[%w%s]", "")
        local _, changeCount = string.gsub(stdout, "\n[%w%s]M", "")
        local _, stagedChangeCount = string.gsub(stdout, "\nM[%w%s]", "")
        local _, delCount = string.gsub(stdout, "\n[%w%s]D", "")
        local _, stagedDelCount = string.gsub(stdout, "\nD[%w%s]", "")
        local _, renameCount = string.gsub(stdout, "\nR[%w%s]", "")

        local localBranch, upstreamBranch = M.get_branch_names(stdout)
        local aheadCount, behindCount = M.get_commit_diff(stdout)

        return {
            localBranch = localBranch,
            upstreamBranch = upstreamBranch,
            addCount = addCount,
            stagedAddCount = stagedAddCount,
            changeCount = changeCount,
            stagedChangeCount = stagedChangeCount,
            delCount = delCount,
            stagedDelCount = stagedDelCount,
            renameCount = renameCount,
            aheadCount = aheadCount,
            behindCount = behindCount,
        }
    end
end

function M.get_branch_names(status_string)
    local _, _, branchNames = string.find(status_string, "##%s([%w%./%-_]+)[%s\n]")

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

function M.get_commit_diff(status_string)
    local _, _, aheadCount = string.find(status_string, "##%s.*%[ahead (%d+).*%]")
    local _, _, behindCount = string.find(status_string, "##%s.*%[.*behind (%d+)%]")

    aheadCount = aheadCount ~= nil and tonumber(aheadCount) or 0
    behindCount = behindCount ~= nil and tonumber(behindCount) or 0

    return aheadCount, behindCount
end

function M.merge_tables(...)
    local result = {}
    for _, t in ipairs({...}) do
        for _, v in ipairs(t) do
            table.insert(result, v)
        end
    end

    return result
end

function M.get_key_mods(window)
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

    local key_table = window:active_key_table() or "Default"
    return key_table .. "  " ..  filtered_mods
end

return M
