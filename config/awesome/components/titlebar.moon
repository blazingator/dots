awful = require "awful"
wibox = require "wibox"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

client.connect_signal "request::titlebars", (c) ->
  titlebar = awful.titlebar c, {
    size: dpi 22
  }

  with awful.titlebar
    titlebar\setup {
      nil,
      nil,
      {
        wibox.layout.margin .widget.minimizebutton c, dpi 4, dpi 5, dpi 5, dpi 5
        wibox.layout.margin .widget.maximizedbutton c, dpi 4, dpi 5, dpi 5, dpi 5
        wibox.layout.margin .widget.closebutton c, dpi 11, dpi 5, dpi 5, dpi 5
        layout: wibox.layout.fixed.horizontal
      }
      layout: wibox.layout.align.horizontal
    }
