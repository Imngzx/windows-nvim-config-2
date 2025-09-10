return {
  {
    "saghen/blink.cmp",
    event = "LazyFile",
    dependencies = {
      "rapan931/colorful-menu.nvim",
    },
    opts = {
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          draw = {
            -- custom column layout
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
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
  },
}
