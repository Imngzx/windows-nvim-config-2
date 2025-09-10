return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "modern",
        transparent_bg = false,

        use_icons_from_diagnostic = true,

        -- Set the arrow icon to the same color as the first diagnostic severity
        set_arrow_to_diag_color = true,
        transparent_cursorline = true,
        hi = {
          -- Highlight group for error messages
          error = "DiagnosticError",

          -- Highlight group for warning messages
          warn = "DiagnosticWarn",

          -- Highlight group for informational messages
          info = "DiagnosticInfo",

          -- Highlight group for hint or suggestion messages
          hint = "DiagnosticHint",

          -- Highlight group for diagnostic arrows
          arrow = "NonText",

          -- Background color for diagnostics
          -- Can be a highlight group or a hexadecimal color (#RRGGBB)
          background = "CursorLine",

          -- Color blending option for the diagnostic background
          -- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
          -- Default is "Normal" in the source code
          mixing_color = "Normal",
        },

        options = {
          -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
          show_source = {
            enabled = true,
            -- Show source only when multiple sources exist for the same diagnostic
            if_many = true,
          },
        },

        virt_texts = {
          -- Priority for virtual text display (higher values appear on top)
          -- Increase if other plugins (like GitBlame) override diagnostics
          priority = 2048,
        },
        break_line = {
          -- Enable breaking messages after a specific length
          enabled = true,

          -- Number of characters after which to break the line
          after = 30,
        },
        -- severity = {
        --   vim.diagnostic.severity.ERROR,
        --   vim.diagnostic.severity.WARN,
        --   vim.diagnostic.severity.INFO,
        --   vim.diagnostic.severity.HINT,
        -- },

        multilines = {
          -- Enable multiline diagnostic messages
          enabled = true,

          -- Always show messages on all lines for multiline diagnostics
          always_show = true,

        },
        overflow = {
          mode = "wrap",

        },
        show_all_diags_on_cursorline = true,
        overwrite_events = nil,



      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end
  }


}
