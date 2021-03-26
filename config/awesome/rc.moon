gears = require "gears"
awful = require "awful"
beautiful = require "beautiful"
naughty = require "naughty"
menubar = require "menubar"

awful.rules = require "awful.rules"

require "awful.autofocus"

require "auto-start"
require "components.titlebar"
keys = require "keys"
widgets = require "widgets"
apps = require "apps"

if awesome.startup_errors
  naughty.notify
    preset: naughty.config.presets.critical
    title: "Oops, there were errors during startup!"
    text: awesome.startup_errors

do
  in_error = false
  awesome.connect_signal "debug::error", (err) ->
    return if in_error
    in_error = true

    naughty.notify
      preset: naughty.config.presets.critical
      title: "Oops, an error happened!",
      text: tostring err

    in_error = false

beautiful.init require "theme.theme"

with awful.layout.suit
  awful.layout.layouts = {
    .tile,
    .max,
    .floating
  }

tags = for _ = 1, screen.count!
  awful.tag {"", "", "", "", ""},
    s, awful.layout.suit.tile

mainmenu = awful.menu
  items: {
    {"rofi menu", apps.apps.rofi}
    {"edit config", apps.apps.config}
    {"restart", awesome.restart}
    {"quit", -> awesome.quit!}
  }

-- mouse bindings
root.buttons gears.table.join(
  awful.button({}, 3, -> mainmenu\toggle!)
  awful.button({}, 4, awful.tag.viewnext)
  awful.button({}, 5, awful.tag.viewprev)
)

root.keys keys.globalkeys

clientbuttons = gears.table.join(
  awful.button({}, 1, (c) ->
    client.focus = c
    c\raise!)
  awful.button({modkey}, 1, awful.mouse.client.move)
  awful.button({modkey}, 3, awful.mouse.client.resize)
)

awful.screen.connect_for_each_screen =>
  widgets.at_screen_connect @

awful.rules.rules = {
  { rule: {}
    properties:
      border_width: beautiful.border_width
      border_color: beautiful.border_normal
      focus: awful.client.focus.filter
      raise: true
      keys: keys.clientkeys
      screen: awful.screen.preferred
      buttons: clientbuttons
      titlebars_enabled: true
  }
}


client.connect_signal "manage", (c) ->
  with c.size_hints
    if awesome.startup and not .user_position and not .program_position
      awful.placement.no_offscreen c

client.connect_signal "mouse::enter", (c) ->
  test = (awful.layout.get c.screen) ~= awful.layout.suit.magnifier
  test and= awful.client.focus.filter c
  client.focus = c if test

client.connect_signal "focus", (c) ->
  c.border_color = beautiful.border_focus

client.connect_signal "unfocus", (c) ->
  c.border_color = beautiful.border_normal
