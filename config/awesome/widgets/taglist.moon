awful = require "awful"
gears = require "gears"
wibox = require "wibox"

require "keys"

tagbuttons = gears.table.join(
  awful.button({}, 1, awful.tag.viewonly)
  awful.button({modkey}, 1, awful.client.movetotag)
  awful.button({}, 3, awful.tag.viewtoggle)
)

-- update_list = (self, tag, index) ->

create_tag_list = (s) ->
  taglist = awful.widget.taglist{
    screen: s
    filter: awful.widget.taglist.filter.all
    style:
      shape: gears.shape.powerline
    layout: {
      spacing: 0
      -- spacing_widget:
      -- color: "#dddddd"
      -- shape: gears.shape.powerline
      -- widget: wibox.widget.separator
      layout: wibox.layout.fixed.horizontal
    },
    widget_template: {
      {
        {
          {
            id: "text_role"
            widget: wibox.widget.textbox
          }
          layout: wibox.layout.fixed.horizontal
        },
        left: 18
        right: 18
        widget: wibox.container.margin
      },
      id: "background_role"
      widget: wibox.container.background
    },
    buttons: tagbuttons
  }

  taglist

{:create_tag_list}
