return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
      },
      on_colors = function(colors)
        -- Map default color slots to classic Gruvbox palette
        colors.bg       = "#282828" -- dark0
        colors.bg_dark  = "#1d2021" -- dark0_hard
        colors.bg_float = "#1d2021"
        colors.fg       = "#ebdbb2" -- light1
        colors.fg_dark  = "#a89984" -- light4
        colors.comment  = "#928374" -- gray

        colors.red      = "#fb4934" -- bright_red
        colors.green    = "#b8bb26" -- bright_green
        colors.yellow   = "#fabd2f" -- bright_yellow
        colors.blue     = "#83a598" -- bright_blue
        colors.purple   = "#d3869b" -- bright_purple / magenta
        colors.cyan     = "#8ec07c" -- bright_aqua
        colors.orange   = "#fe8019" -- bright_orange
      end,
      on_highlights = function(hl)
        -- Gruvbox Syntax Palette Mapping
        local g                     = {
          bg0    = "#282828",
          fg1    = "#ebdbb2",
          red    = "#fb4934",
          green  = "#adda78",
          yellow = "#fabd2f",
          blue   = "#83a598",
          purple = "#d3869b",
          aqua   = "#8ec07c",
          orange = "#fe8019",
          gray   = "#928374",
        }

        -- Standard Syntax Highlighting (Gruvbox Standard)
        hl.Comment                  = { fg = g.gray, italic = true }
        hl.Constant                 = { fg = g.purple }
        hl.String                   = { fg = g.green }
        hl.Character                = { fg = g.green }
        hl.Number                   = { fg = g.purple }
        hl.Boolean                  = { fg = g.purple }
        hl.Identifier               = { fg = g.blue }
        hl.Statement                = { fg = g.red }
        hl.Conditional              = { fg = g.red }
        hl.Repeat                   = { fg = g.red }
        hl.Keyword                  = { fg = g.red }
        hl.Operator                 = { fg = g.fg1 }
        hl.Type                     = { fg = g.yellow }
        hl.StorageClass             = { fg = g.orange }
        hl.Structure                = { fg = g.aqua }
        hl.Special                  = { fg = g.orange }

        -- Treesitter Syntax Overrides
        hl["@variable"]             = { fg = g.fg1 }
        hl["@variable.builtin"]     = { fg = g.orange }
        hl["@keyword"]              = { fg = g.red }
        hl["@keyword.function"]     = { fg = g.red }
        hl["@string"]               = { fg = g.green }
        hl["@number"]               = { fg = g.purple }
        hl["@boolean"]              = { fg = g.purple }
        hl["@constant"]             = { fg = g.purple }
        hl["@constant.builtin"]     = { fg = g.purple }
        hl["@type"]                 = { fg = g.yellow }
        hl["@type.builtin"]         = { fg = g.yellow }
        hl["@property"]             = { fg = g.aqua }
        hl["@field"]                = { fg = g.aqua }
        hl["@parameter"]            = { fg = g.blue }
        hl["@comment"]              = { fg = g.gray, italic = true }
        hl["@tag"]                  = { fg = g.aqua }
        hl["@tag.attribute"]        = { fg = g.green }

        -- Forced Blue Highlight Rules (Functions, Calls, Built-ins & Brackets)
        hl.Function                 = { fg = "#00bfff" }
        hl["@function"]             = { fg = "#00bfff" }
        hl["@function.builtin"]     = { fg = "#00bfff" } -- e.g. len(), make()
        hl["@function.call"]        = { fg = "#00bfff" } -- e.g. fn()
        hl["@function.method"]      = { fg = "#00bfff" }
        hl["@function.method.call"] = { fg = "#00bfff" } -- e.g. s.call()
        hl["@method"]               = { fg = "#00bfff" }
        hl["@method.call"]          = { fg = "#00bfff" }

        -- Parentheses () -> Blue
        hl["@punctuation.bracket"]  = { fg = "#ff3e96" }

        -- LSP Semantic Overrides
        hl["@lsp.type.function"]    = { fg = g.blue, bold = true }
        hl["@lsp.type.method"]      = { fg = g.blue }
        hl["@lsp.type.builtin"]     = { fg = g.blue }
        hl["@lsp.type.class"]       = { fg = g.yellow }
        hl["@lsp.type.struct"]      = { fg = g.aqua }
        hl["@lsp.type.variable"]    = { fg = g.fg1 }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
