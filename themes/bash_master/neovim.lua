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
        colors.blue     = "#00bfff" -- bright_blue
        colors.purple   = "#d3869b" -- bright_purple / magenta
        colors.cyan     = "#8ec07c" -- bright_aqua
        colors.orange   = "#fe8019" -- bright_orange
      end,
      on_highlights = function(hl)
        -- Gruvbox Syntax Palette Mapping
        local g = {
          bg0    = "#282828",
          fg1    = "#ebdbb2",
          red    = "#fb4934",
          green  = "#adda78",
          yellow = "#fabd2f",
          blue   = "#00bfff",
          purple = "#9966cc",
          aqua   = "#8ec07c",
          orange = "#fe8019",
          gray   = "#928374",
          wheat  = "#ffdead",
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

        -- Line numbers (relative numbers above/below the cursor + current line)
        hl.LineNr                   = { fg = g.wheat }
        hl.LineNrAbove              = { fg = g.wheat }
        hl.LineNrBelow              = { fg = g.wheat }
        hl.CursorLineNr             = { fg = g.orange, bold = true }

        -- Treesitter Syntax Overrides
        hl["@variable"]             = { fg = g.fg1 }
        hl["@variable.builtin"]     = { fg = g.orange }
        hl["@keyword"]              = { fg = g.red }
        hl["@keyword.function"]     = { fg = g.red }
        hl["@string"]               = { fg = g.green }
        hl["@number"]               = { fg = g.wheat }
        hl["@boolean"]              = { fg = g.wheat }
        hl["@constant"]             = { fg = g.wheat }
        hl["@constant.builtin"]     = { fg = g.wheat }
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

        -- Brackets () [] {} -> pink
        hl["@punctuation.bracket"]  = { fg = "#ff3e96" }

        -- Data types (error, string, int, ...) and chan -> red
        hl["@type.builtin"]                    = { fg = g.red }
        hl["@keyword.type"]                    = { fg = g.red } -- chan, map, struct, interface
        hl["@lsp.typemod.type.defaultLibrary"] = { fg = g.red } -- gopls: error, string, etc.

        -- Packages -> purple
        hl["@module"]                      = { fg = g.purple } -- context.Context, errgroup.WithContext
        hl["@lsp.type.namespace"]          = { fg = g.purple } -- gopls package names
        hl["@string.special.url"]          = { fg = g.purple } -- import paths
        hl["@string.special.path"]         = { fg = g.purple }

        -- LSP Semantic Overrides
        hl["@lsp.type.function"]    = { fg = g.blue, bold = true }
        hl["@lsp.type.method"]      = { fg = g.blue }
        hl["@lsp.type.builtin"]     = { fg = g.blue }
        hl["@lsp.type.class"]       = { fg = g.yellow }
        hl["@lsp.type.struct"]      = { fg = g.aqua }
        hl["@lsp.type.variable"]    = { fg = g.fg1 }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)

      -- Safety net: re-apply line number colors whenever the colorscheme loads,
      -- in case a plugin (statuscolumn, etc.) overrides them afterwards.
      local function fix_linenr()
        local set = vim.api.nvim_set_hl
        set(0, "LineNr",       { fg = "#928374" })
        set(0, "LineNrAbove",  { fg = "#928374" })
        set(0, "LineNrBelow",  { fg = "#928374" })
        set(0, "CursorLineNr", { fg = "#fe8019", bold = true })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "tokyonight*",
        callback = fix_linenr,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
