local wezterm = require 'wezterm'

return {
	font = wezterm.font_with_fallback({
	  "JetBrainsMono Nerd Font",
	  "Noto Sans Mono CJK KR",
	  "Noto Color Emoji",
	}),
  -- font = wezterm.font_with_fallback({
  --   "Hack Nerd Font",
  --   "Noto Sans CJK KR",
  --   "Noto Color Emoji",
  -- }),
  font_size = 14.0,
}
