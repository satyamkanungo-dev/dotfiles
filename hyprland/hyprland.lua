hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 3,
    gaps_out = 8,
    border_size = 2,

    -- Change to niri-like side-scrolling layout.
    layout = "scrolling",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- Use round window corners.
    rounding = 8,
    -- active_opacity = 0.85,
    -- inactive_opacity = 0.93,

    -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
    -- dim_inactive = true,
    -- dim_strength = 0.15,
    --
  },
})

-- 1. Turn blur off for every window
hl.window_rule({
    name    = "no-blur-everything",
    match   = { class = ".*" },
    no_blur = true,
})

hl.window_rule({
    name    = "transparent-apps",
    opacity = "0.79 0.83",
    no_blur = false,
    match   = { class = "^(Spotify|kitty|chrome-claude.ai__new-Default|TUI.tile|TUI.float|org.omarchy.btop|org.omarchy.about|org.omarchy.terminal)$" },
})

hl.window_rule({
    name    = "transparent-web-apps",
    opacity = "0.85 0.89",
    no_blur = false,
    match   = { class = "^(chrome-web.whatsapp.com__-Default|org.telegram.desktop|chrome-x.com__-Default)$" },
})



hl.config({
  general = {
    --border_size = 0,
    col = {
      active_border = "#ede8d5",
      -- active_border = "0x890a0a0a",
      -- inactive_border = "0x890a0a0a",
    },
  },

  decoration = {
    shadow = {
       enabled = true,
       range = 28,
       render_power = 3,
       color = "0x890a0a0a",
     },

    blur = {
        enabled = true,
        brightness = 1.2,
        contrast = 1.2,
        size = 6,
        passes = 2,
        ignore_opacity = true,
    	  new_optimizations = true,
    	  special = false,
    	  popups = true,
    	  xray = false,
        vibrancy = 0.1696,
        vibrancy_darkness = 0.35,
    }
  },
})


