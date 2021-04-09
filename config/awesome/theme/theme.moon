gears = require "gears"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

colors = require "theme.colors"

with {}
  .themedir =   "/home/vinicius/.config/awesome/theme"
  .wallpaper = .themedir .. "/wall.jpg"
  .font = "Noto Sans Mono 11"
  .menu_bg_normal = "#000000"
  .menu_bg_focus = "#000000"
  .bg_normal = colors.grey
  .bg_focus = colors.black
  .bg_urgent = colors.black
  .fg_normal = "#aaaaaa"
  .fg_focus = "#a96fff"
  .fg_urgent = colors.red
  .fg_minimize = colors.white
  .border_width = dpi 0
  .border_normal = "#1c2022"
  .border_focus = "#606060"
  .border_marked = "#3ca4d8"
  .menu_border_width = 0
  .menu_width = dpi 130
  .menu_fg_normal = "#aaaaaa"
  .menu_fg_focus = colors.deep_purple
  .menu_bg_normal = colors.grey
  .menu_bg_focus = colors.grey
  .wibar_bg = colors.grey .. "AA"
  .taglist_bg_focus = colors.grey .. "AA"
  .taglist_squares_sel = .themedir .. "/icons/square_a.png"
  .taglist_squares_unsel = .themedir .. "/icons/square_b.png"

  .tasklist_plain_task_name = true
  .tasklist_disable_icon = true
  .tasklist_bg_normal = colors.grey .. "0A"
  .tasklist_bg_focus = colors.black .. "AA"
  .useless_gap = dpi 4
  -- layouts
  .layout_tile = .themedir .. "/icons/tile.svg"
  .layout_max = .themedir .. "/icons/max.svg"
  .layout_floating = .themedir .. "/icons/floating.svg"
  -- titlebar
  --.titlebars_enabled = true
  .titlebar_bg_focus = .bg_focus .. "aa"
  .titlebar_bg_normal = .bg_normal .. "dd"
  .titlebar_fg_focus = .fg_focus .. "aa"
  .titlebar_fg_normal = .fg_normal .. "dd"
  .titlebar_close_button_normal = .themedir .. "/icons/titlebar/normal.svg"
  .titlebar_close_button_focus = .themedir .. "/icons/titlebar/close.svg"
  .titlebar_close_button_normal_hover = .themedir .. "/icons/titlebar/close_hover.svg"
  .titlebar_close_button_focus_hover = .themedir .. "/icons/titlebar/close_hover.svg"

  .titlebar_minimize_button_normal = .themedir .. "/icons/titlebar/normal.svg"
  .titlebar_minimize_button_focus = .themedir .. "/icons/titlebar/minimize.svg"
  .titlebar_minimize_button_normal_hover = .themedir .. "/icons/titlebar/minimize_hover.svg"
  .titlebar_minimize_button_focus_hover = .themedir .. "/icons/titlebar/minimize_hover.svg"

  .titlebar_maximized_button_normal_inactive = .themedir .. "/icons/titlebar/normal.svg"
  .titlebar_maximized_button_focus_inactive = .themedir .. "/icons/titlebar/maximized_focus.svg"
  .titlebar_maximized_button_normal_inactive_hover = .themedir .. "/icons/titlebar/maximized_hover.svg"
  .titlebar_maximized_button_focus_inactive_hover = .themedir .. "/icons/titlebar/maximized_hover.svg"

  .titlebar_maximized_button_normal_active = .themedir .. "/icons/titlebar/normal.svg"
  .titlebar_maximized_button_focus_active = .themedir .. "/icons/titlebar/maximized.svg"
  .titlebar_maximized_button_normal_active_hover = .themedir .. "/icons/titlebar/maximized_hover.svg"
  .titlebar_maximized_button_focus_active_hover = .themedir .. "/icons/titlebar/maximized_hover.svg"
