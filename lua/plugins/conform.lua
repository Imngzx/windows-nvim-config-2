local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },

  -- Instead of `config`, use `opts` to extend conform's setup
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      rust = { "rustfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      scheme = { "schemat" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      toml = { "taplo" },
      cmake = { "cmake_format" },
      json = { "jq" },
      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
    },
    formatters = {
      schemat = {
        command = "schemat",
        stdin = true,
        exit_codes = { 0 },
        inherit = true,
      },
    },
    -- LazyVim already handles format-on-save, so no need to manually set `format_after_save`
  },
}

-- Keep your FormatDisable / FormatEnable user commands
M.init = function()
  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      vim.b.disable_autoformat = true
      print("Disable format on save for this buffer")
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = false,
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    print("Re-enable format on save for this buffer")
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

return M
