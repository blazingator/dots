awful = require "awful"
wibox = require "wibox"

colors = require "theme.colors"
helper = require "utils.helper"

-- local volume_level
volume_icon = wibox.widget {
  text: " "
  font: "NotoSansMono Bold 10"
  valign: "center"
  align: "center"
  widget: wibox.widget.textbox
}
volume_level = wibox.widget {
  text: "0%"
  font: "NotoSansMono Bold 10"
  align: "center"
  valign: "center"
  widget: wibox.widget.textbox
}

volume_bar = wibox.widget {
  {
    volume_icon
    volume_level
    layout: wibox.layout.align.horizontal
  }
  {
    id: "volume_slider"
    bar_color: colors.grey
    bar_height: 5
    handle_color: colors.light_blue
    handle_width: 5
    forced_height: 10
    value: 100
    maximum: 100
    widget: wibox.widget.slider
  }
  spacing: 5
  layout: wibox.layout.fixed.horizontal
}

volume_slider = volume_bar.volume_slider

-- TODO melhorar a chamada do set_value
awesome.connect_signal "evil::volume", (volume) ->
  volume_slider\set_value volume
  volume_level.text = tostring volume.."%"

volume_slider\connect_signal "property::value", () ->
  volume = volume_slider\get_value!

  helper.set_volume volume
  awesome.emit_signal "evil::volume", volume

{:volume_bar}
