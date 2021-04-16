import spawn from require "awful"

volume_old = -1
muted_old = -1

emit_volume_info = ->
  -- awful.spawn.easy_async_with_shell(
  --   "amixer -D pulse sget Master | grep 'Right:' | awk -F '[][]' '{print $2}' | sed 's/[^0-9]//g'",
  --   (stdout) ->
  --     volume_int = tonumber stdout
  --     awesome.emit_signal "evil::volume", volume_int
  -- )
  spawn.easy_async("pacmd list-sinks | awk '/\\* index: /{nr[NR+7];nr[NR+11]}; NR in nr'", (stdout) ->
    volume = stdout\match '(%d+)%% /'
    is_muted = stdout\match 'Mute:(%s+)[yes]' and 1 or 0
    volume_int = tonumber volume

    if volume_int ~= volume_old or is_muted ~= muted_old
      awesome.emit_signal "evil::volume", volume_int
      volume_old = volume_int
      muted_old = is_muted
  )

emit_volume_info!

volume_script = [[
  bash -c '
  pactl subscribe 2>/dev/null | grep --line-buffered "destino"
  '
  ]]

spawn.easy_async_with_shell "pgrep -x pactl | xargs kill", () ->
  spawn.with_line_callback(volume_script, {
    stdout: (line) ->
      emit_volume_info!
  })
