awful = require "awful"
gears = require "gears"

hotkeys_popup = require "awful.hotkeys_popup"


export modkey = "Mod4"
export altkey = "Mod1"

default_apps = {
  apps:
    terminal: "env alacritty"
    rofi: "rofi -show drun"
    lock: "i3lock-fancy"
    browser: "env firefox"
    editor: "nvim-qt"
    files: "thunar"
    config: "nvim-qt +'CocCommand explorer .config/awesome'"

  run_on_startup:{"picom", "numlockx on","/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &"}
}

export clientkeys = gears.table.join(
  awful.key({modkey}, "f", (c) -> with c
    .fullscreen = not .fullscreen
    \raise!,
    {description: "Toggle fullscreen", group: "client"})
  awful.key({modkey, "Shift"}, "s", (c) -> with c
    .floating = not .floating
    \raise!,
    {description: "toggle floating", group: "client"})
  awful.key({modkey, "Shift"}, "q", (c) -> c\kill!,
  {description: "kill client", group: "client"})
  awful.key({modkey}, "m", (c) -> with c
    .maximized = not .maximized
    c\raise!,
    {description: "toggle maximized client", group: "client"})
)

export globalkeys = gears.table.join(
  awful.key({modkey}, "F1", hotkeys_popup.show_help, {description: "show help", group: "awesome"})
  awful.key({modkey, "Control"}, "r", _G.awesome.restart, {description: "restart awesome", group: "awesome"})
  awful.key({modkey, "Control"}, "q", _G.awesome.quit, {description: "quit awesome", group: "awesome"})
  awful.key({modkey}, "s", awful.tag.viewprev, {description: "view previous", group: "tag"})
  awful.key({modkey}, "w", awful.tag.viewprev, {description: "view next", group: "tag"})
  awful.key({altkey, "Control"}, "Left", awful.tag.viewprev, {description: "view previous", group: "tag"})
  awful.key({altkey, "Control"}, "Right", awful.tag.viewnext,  {description: "view next", group: "tag"})
  awful.key({modkey}, "Escape", awful.tag.history.restore, {description: "go back", group: "tag"})
  awful.key({modkey}, "d", -> awful.client.focus.byidx 1, {description: "view next", group: "tag"})
  awful.key({modkey}, "a", -> awful.client.focus.byidx -1, {description: "view previous", group: "tag"})
  awful.key({modkey}, "r", -> awful.spawn default_apps.apps.rofi, {description: "show rofi menu", group: "awesome"})
  awful.key({modkey}, "u", awful.client.urgent.jumpto, {description:'jump to urgent client', group: 'client'})
  awful.key({modkey}, "Tab", ->
    awful.client.focus.byidx 1
    if client.focus
      client.focus\raise!, {description: "switch to next window", group: "client"})
  awful.key({modkey, "Shift"}, "Tab", -> 
    awful.client.focus.byidx -1
    if client.focus
      client.focus\raise!, {description: "switch to previous window", group: "client"})
  awful.key({modkey}, "l", -> awful.spawn default_apps.apps.lock, {description: "lock screen", group: "awesome"})
  awful.key({modkey}, "c", -> awful.spawn default_apps.apps.editor, {description: "open text editor", group: "launcher"})
  awful.key({modkey}, "b", -> awful.spawn.with_shell default_apps.apps.browser, {description: "open web browser", group: "launcher"})
  awful.key({modkey}, "p", -> awful.spawn.with_shell "vimb", {description: "open vimBrowser", group: "launcher"})
  awful.key({modkey}, "Return", -> awful.spawn.with_shell default_apps.apps.terminal, {description: "open a terminal", group: "launcher"})
  awful.key({altkey, 'Shift'}, 'Right', -> awful.tag.incmwfact(0.05),{description: 'increase master width factor', group: 'layout'})
  awful.key({altkey, 'Shift'}, 'Left', -> awful.tag.incmwfact(-0.05), {description: 'decrease master width factor', group: 'layout'})
  awful.key({altkey, 'Shift'}, 'Down', -> awful.client.incwfact(0.05), {description: 'decrease master height factor', group: 'layout'})
  awful.key({altkey, 'Shift'}, 'Up', -> awful.client.incwfact(-0.05), {description: 'increase master height factor', group: 'layout'})
  awful.key({modkey, 'Shift'}, 'Left', -> awful.tag.incnmaster(1, nil, true), {description: 'increase the number of master clients', group: 'layout'})
  awful.key({modkey, 'Shift'}, 'Right', -> awful.tag.incnmaster(-1, nil, true), {description: 'decrease the number of master clients', group: 'layout'})
  awful.key({modkey, 'Control'}, 'Left', -> awful.tag.incncol(1, nil, true), {description: 'increase the number of columns', group: 'layout'
  })
  awful.key({modkey, 'Control'}, 'Right', -> awful.tag.incncol(-1, nil, true), {description: 'decrease the number of columns', group: 'layout'})
  awful.key({modkey}, 'space', -> awful.layout.inc(1), {description: 'select next', group: 'layout'})
  awful.key({modkey, 'Shift'}, 'space', -> awful.layout.inc(-1), {description: 'select previous', group: 'layout'})
  awful.key({modkey, 'Control'}, 'n', ->
    c = awful.client.restore
    -- Focus restored client
    if c 
      _G.client.focus = c
      c\raise!, {description:'restore minimized', group: 'client'})
  awful.key({'Control', 'Shift'}, 'Escape', ->
  awful.util.spawn.with_shell 'alacritty -e bpytop',{description: 'Open system monitor', group: 'hotkeys'})
)

for i = 1, 9
  local desc_view, desc_toggle, desc_move, descr_toggle_focus
  if i == 1 or i == 9
    desc_view = {description: "view tag #",group: "tag"}
    desc_toggle = {description: "toggle tag #",group: "tag"}
    desc_move = {description: "move focused client to tag #",group: "tag"}
    desc_toggle_focus = {description: "toggle focused client on tag #", group: "tag"}

  globalkeys = gears.table.join(globalkeys,
    awful.key({modkey}, '#' .. i + 9, ->
      screen = awful.screen.focused!
      tag = screen.tags[i]
      tag\view_only! if tag,
      desc_view)
    awful.key({modkey, "Control"}, "#" .. i + 9, -> 
      screen = awful.screen.focused!
      tag = screen.tags[i]
      awful.tag.viewtoggle tag if tag, desc_toggle)
    awful.key({modkey, "Shift"}, "#" .. i + 9, -> 
      if client.focus
        tag = client.focus.screen.tags[i]
        client.focus\move_to_tag tag if tag, desc_move)
    awful.key({modkey, "Control", "Shift"}, '#' .. i + 9, ->
      if client.focus
        tag = client.focus.screen.tags[i]
        client.focus\toggle_tag tag if tag, desc_toggle_focus)
)

{:globalkeys, :clientkeys}
