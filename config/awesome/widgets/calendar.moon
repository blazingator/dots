awful = require "awful"
gears = require "gears"
wibox = require "wibox"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

colors = require "theme.colors"
helper = require "utils.helper"

styles = {}
with styles
  .month = {
    padding: 20
    fg_color: colors.pink
    bg_color: colors.background .. "00"
    border_width: 0
  }
  .normal = {shape: helper.rrect 5}
  .focus = {
    fg_color: colors.pink
    bg_color: colors.purple .. "00"
    markup: (t) -> "<b>" .. t .. "</b>"
  }
  .header = {
    fg_color: colors.cyan
    bg_color: colors.pink .. "00"
    markup: (t) -> "<span font_desc='NotoSansMono Nerd Font 22'>" .. t .. "</span>"
  }
  .weekday = {
    bg_color: colors.pink .. "00"
    --padding: 3
    markup: (t) -> "<b>" .. t .. "</b>"
  }
-- TODO arrumar a exibição da sábado nos dias da semana
decorate_cell = (widget, flag, date) ->
  if flag == "monthheader" and not styles.monthheader
    flag = "header"

  props = styles[flag] or {}

  if props.markup and widget.get_text and widget.set_markup
    widget\set_markup(props.markup widget\get_text!)

  d =
    year: date.year
    month: (date.month or 1)
    day: (date.day or 1)
  weekday = tonumber(os.date '%w', os.time(d))

  default_fg = (weekday==0 or weekday==6) and colors.indigo or colors.foreground
  default_bg = colors.background.."00"

  ret = wibox.widget{
    {
      widget,
      margins: (props.padding or 2) + (props.border_width or 0)
      widget: wibox.container.margin
    }
    --shape: props.shape
    --shape_border_color: props.border_color or colors.background
    --shape_border_width: props.border_width or 0
    fg: props.fg_color or default_fg
    --bg: props.bg_color or default_bg
    widget: wibox.container.background
  }

  ret


cal_widget = wibox.widget{
  date: os.date("*t")
  font: "NotoSansMono Nerd Font 13"
  long_weekdays: false
  start_sunday: true
  spacing: dpi 3
  fn_embed: decorate_cell
  widget: wibox.widget.calendar.month
}

{:cal_widget}
