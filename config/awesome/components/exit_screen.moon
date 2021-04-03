awful = require "awful"
gears = require "gears"
wibox = require "wibox"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

colors = require "theme.colors"
helper = require "helper"


button_size = dpi 120
-- Icon text
icons =
  poweroff: ""
  reboot: ""
  lock: ""
  exit: ""
  font: "NotoSansMono Nerd Font 45"

lock_screen = ->
  awful.spawn "i3lock-fancy"

commands =
  poweroff_command: ->
    awful.spawn.with_shell "poweroff"
  reboot_command: ->
    awful.spawn.with_shell "reboot"
  lock_command: ->
    lock_screen!
  exit_command: ->
    awesome.quit!

create_button = (symbol, hover_color, text, command) ->
  icon = wibox.widget {
    forced_height: button_size,
    forced_width: button_size,
    align: "center",
    valign: "center",
    font: icons.font,
    text: symbol,
    widget: wibox.widget.textbox
  }

  button = wibox.widget {
    {
      icon,
      expand: "none",
      layout: wibox.layout.align.horizontal
    },
    forced_height: button_size,
    forced_width: button_size,
    --border_width: dpi 8,
    --border_color: colors.black,
    shape: gears.shape.rounded_rect,
    bg: colors.grey .. "AA",
    widget: wibox.container.background
  }

  -- Bind left click to run the command
  button\buttons(gears.table.join(
    awful.button({ }, 1, -> command!)
  ))

  -- Change color on hover
  button\connect_signal "mouse::enter", ->
    icon.markup = helper.colorize_text text, hover_color
    --button.border_color = hover_color
  button\connect_signal "mouse::leave", ->
    icon.markup = helper.colorize_text text, colors.foreground
    --button.border_color = colors.grey

  button


poweroff = create_button icons.poweroff, colors.red, icons.poweroff, commands.poweroff_command
reboot = create_button icons.reboot, colors.yellow, icons.reboot, commands.reboot_command
exit = create_button icons.exit, colors.teal, icons.exit, commands.exit_command
lock = create_button icons.lock, colors.indigo, icons.lock, commands.lock_command

exit_screen = wibox {
  visible: false
  ontop: true
  type: "splash"
  bg: colors.black .. "0A"
}
awful.placement.maximize exit_screen

export exit_screen_show = ->
  exit_screen.visible = true

exit_screen_hide = ->
  exit_screen.visible = false

exit_screen\buttons gears.table.join(
  awful.button({}, 1, exit_screen_hide)
  awful.button({}, 3, exit_screen_hide)
)

exit_screen\setup {
  nil
  -- {
  --   nil
  --   {
  --     markup: "<span foreground='#000000'>Encerrar Sessão</span>"
  --     font: icons.font
  --     widget: wibox.widget.textbox
  --   }
  --   expand: "none"
  --   layout: wibox.layout.align.horizontal
  -- }
  {
    nil
    {
      poweroff
      reboot
      exit
      lock
      spacing: dpi 20
      layout: wibox.layout.fixed.horizontal
    }
    expand: "none"
    layout: wibox.layout.align.horizontal
  }
  expand: "none"
  layout: wibox.layout.align.vertical
}

button_icon = wibox.widget {
  markup: "<span foreground='"..colors.foreground.."'>"..icons.poweroff.."</span>"
  forced_width: dpi 20
  forced_height: dpi 20
  font: "NotoSansMono Nerd Font 12"
  widget: wibox.widget.textbox
}

menu_button = wibox.widget{
  {
    {
      button_icon
      expand: "none"
      layout: wibox.layout.align.horizontal
    }
    margins: 5
    widget: wibox.container.margin
  }
  --bg: colors.grey .. "00"
  widget: wibox.container.background
}

with menu_button
  \buttons gears.table.join(
    awful.button({},1, exit_screen_show)
  )

  \connect_signal "mouse::enter", ->
    --.bg = colors.black
    button_icon.markup = helper.colorize_text icons.poweroff, colors.red
  \connect_signal "mouse::leave", ->
    --.bg = colors.grey
    button_icon.markup = helper.colorize_text icons.poweroff, colors.foreground


{:menu_button, :exit_screen_show}
