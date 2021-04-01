awful = require "awful"
wibox = require "wibox"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

left_titlebars = (c) ->
  titlebar = awful.titlebar c, {
    size: dpi 30
    position: "left"
  }

  with awful.titlebar
    titlebar\setup {
      {
        {
          wibox.layout.margin .widget.closebutton c, dpi 11, dpi 5, dpi 5, dpi 5
          wibox.layout.margin .widget.maximizedbutton c, dpi 4, dpi 5, dpi 5, dpi 5
          wibox.layout.margin .widget.minimizebutton c, dpi 4, dpi 5, dpi 5, dpi 5
          spacing: dpi 6
          layout: wibox.layout.fixed.vertical
        }
        margins: dpi 5
        widget: wibox.container.margin
      },
      nil
      nil,
      layout: wibox.layout.align.vertical
    }


client.connect_signal "request::titlebars", (c) ->
  left_titlebars c

