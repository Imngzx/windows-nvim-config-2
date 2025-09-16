return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rapan931/colorful-menu.nvim",
  },
  opts = {
    sources = {
      default = { "lazydev", "lsp", "path", "buffer", "snippets" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    completion = {
      menu = {
        scrollbar = true,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        draw = {
          -- add the new "menu" column
          columns = { { "kind_icon" }, { "label", gap = 1 }, { "menu", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            -- new menu component
            menu = {
              text = function(ctx)
                local menu_labels = {
                  lsp = "[LSP]",
                  buffer = "[Buffer]",
                  snippets = "[LuaSnip]",
                  path = "[Path]",
                  lazydev = "[LazyDev]",
                }
                return menu_labels[ctx.source_name] or ("[" .. ctx.source_name .. "]")
              end,
              highlight = "Comment", -- you can change to match your theme
            },
          },
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
