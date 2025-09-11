return {
  --NOTE: configure nvim to load your desired colroschme
  {
    "LazyVim/LazyVim",
    event = "VimEnter",
    opts = {
      colorscheme = "tokyonight", -- changing this can change the colorscheme
    },
  },

  --NOTE: folke noice config
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  --NOTE: THIS IS FOR THE TABS
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers", --tabs
        -- separator_style = "slope",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  --NOTE: bottom bar configure
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")

      -- ✅ Add your separators config
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        section_separators = { left = "", right = "" }, --
      })

      -- keep pretty path
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }

      -- show filetype in lualine_x
      opts.sections.lualine_x = {
        {
          "lsp_status",
          icons_enabled = true,
          icon = "󱐌",
        },
      }

      -- show date + 12-hour clock in lualine_z
      opts.sections.lualine_z = {
        function()
          local time = os.date("*t")
          local hour = time.hour
          local suffix = "AM"
          if hour >= 12 then
            suffix = "PM"
            if hour > 12 then
              hour = hour - 12
            end
          elseif hour == 0 then
            hour = 12
          end
          local clock = string.format("%02d:%02d %s", hour, time.min, suffix)
          local date = os.date("%d-%m-%Y") -- format: DD-MM-YYYY
          return date .. " | " .. clock
        end,
      }
    end,
  },

  --NOTE: top right thingy
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local helpers = require 'incline.helpers'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 1 },
        },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and "bold" or "none" },
            modified and { " [+]", guifg = "#ff9e64" } or "",
            ' ',
            guibg = '#44406e',
          }
        end,
      }
    end,
  },

  --NOTE: file, scrolling
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    ---@type snacks.Config
    opts = {

      picker = {
        hidden = true,
        ignored = true,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },

      dim = { enabled = true },
      notifier = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
      scroll = {
        -- your scroll configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 },
          easing = "linear",
          fps = 240,
        },
        animate_repeat = {
          delay = 50, -- delay in ms before using the repeat animation
          duration = { step = 5, total = 150 },
          easing = "linear",
          fps = 240,
        },
      },
    },
  },

  --NOTE: start screen config and also the key to back to dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",

    keys = {
      { "<leader>aa", "<cmd>Alpha<cr>", desc = "Dashboard (Alpha)" },
    },
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
 __         ______     ______     __  __     __   __   __     __    __
/\ \       /\  __ \   /\___  \   /\ \_\ \   /\ \ / /  /\ \   /\ "-./  \
\ \ \____  \ \  __ \  \/_/  /__  \ \____ \  \ \ \'/   \ \ \  \ \ \-./\ \
 \ \_____\  \ \_\ \_\   /\_____\  \/\_____\  \ \__|    \ \_\  \ \_\ \ \_\
  \/_____/   \/_/\/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/
    ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", "<cmd> lua LazyVim.pick()() <cr>"),
        dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
        dashboard.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
        dashboard.button("c", " " .. " Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
