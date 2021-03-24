awful = require "awful"
apps = require "apps"

run_once = (cmd) ->
  findme = cmd
  firstspace = cmd\find(' ')
  if firstspace
    findme = cmd\sub 0, firstspace - 1

  awful.spawn.with_shell(string.format "prgrep -u $USER -x".. findme.. " >> /dev/null || ("..cmd..")")


for _, app in ipairs apps.run_on_startup
  run_once app

