import spawn from require "awful"
import widget from require "wibox"
import timer from require "gears"

fortune_cmd = "fortune -n 140 -s"
fortune_update_interval = 3600

fortune = widget  {
  font: "NotoSansMono 10"
  text: "You so poor you don't even have a cookie yet..."
  widget: widget.textbox
}

update_fortune = ->
  spawn.easy_async_with_shell fortune_cmd, (out) ->
    out = out\gsub '^%s*(.-)%s*$', '%1'
    fortune.markup = "<i>"..out.."</i>"


timer {
  autostart: true
  timeout: fortune_update_interval
  single_shot: false
  call_now: true
  callback: update_fortune
}

{:fortune}
