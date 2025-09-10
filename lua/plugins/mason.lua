return {
  {

    "mason-org/mason.nvim",
    event = "VeryLazy",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ui = {
        icons = {
          package_installed = "✓", -- Icon for installed packages
          package_pending = "➜", -- Icon for packages in progress
          package_uninstalled = "✗" -- Icon for uninstalled packages
        },
      },
      ensure_installed = {
        "stylua",
        "shfmt",
        "clangd",
        "clang-format",
        "basedpyright",
        "black",
        "codelldb",
        "debugpy",
        "marksman",
        "cpplint",
        "markdownlint-cli2",
        "pylint",
        "markdown-toc",
        "ruff",
        "cmakelang",
        "cmakelint",
      },
    },

    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
