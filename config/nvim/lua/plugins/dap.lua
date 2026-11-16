return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "nvim-neotest/nvim-nio"
            }
        },
    },
    keys = {
        --- Equivalent: Ctrl + F5
        { "<F29>", function () require("dap").continue() end, desc = "DAP: Continue/Start" },
        --- Equivalent: Ctrl + F10
        { "<F34>", function () require("dap").step_over() end, desc = "DAP: Step Over" },
        --- Equivalent: Ctrl + F11
        { "<F35>", function () require("dap").step_into() end, desc = "DAP: Step Into" },
        --- Equivalent: Ctrl + F12
        { "<F36>", function () require("dap").step_out() end, desc = "DAP: Step Out" },
        { "<leader>b", function () require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
        { "<leader>B", function () require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP: Conditional Breakpoint" },
        { "<leader>dr", function () require("dap").repl.toggle() end, desc = "DAP: REPL" },
        { "<leader>dl", function () require("dap").run_last() end, desc = "DAP: Run Last" },
        { "<leader>dt", function () require("dap").terminate() end, desc = "DAP: Terminate" },
        { "<leader>du", function () require("dapui").toggle() end, desc = "DAP: Toggle UI" },
    },
    config = function ()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized.dapui = function() dapui.open() end
        dap.listeners.on_session.dapui = function(_, new)
            if not new then
                dapui.close()
            end
        end

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" }
            },
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
            {
                name = "Attach to process",
                type = "codelldb",
                request = "attach",
                pid = require("dap.utils").pick_process,
            }
        }
        dap.configurations.c = dap.configurations.cpp

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
    end,
}
