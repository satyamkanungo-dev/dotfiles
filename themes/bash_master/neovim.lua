return {
  {
    "omacom/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#1a1b26",
        dark_bg    = "#14141d",
        darker_bg  = "#0d0e13",
        lighter_bg = "#31323c",

        fg         = "#fbeeda",
        dark_fg    = "#bcb3a4",
        light_fg   = "#fcf1e0",
        bright_fg  = "#fcf2e3",
        muted      = "#f3ede2",

        red        = "#a4373c",
        yellow     = "#e0af68",
        orange     = "#b25559",
        green      = "#9ece6a",
        cyan       = "#449dab",
        blue       = "#00bfff",
        purple     = "#9c3521",
        brown      = "#6b3335",

        bright_red    = "#ff003d",
        bright_yellow = "#ff9e64",
        bright_green  = "#b9f27c",
        bright_cyan   = "#0db9d7",
        bright_blue   = "#7da6ff",
        bright_purple = "#de553a",

        accent               = "#f5d5a4",
        cursor               = "#4d2e1a",
        foreground           = "#fbeeda",
        background           = "#1a1b26",
        selection             = "#31323c",
        selection_foreground = "#fbeeda",
        selection_background = "#31323c",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
