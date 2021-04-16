awful = require "awful"
gears = require "gears"
wibox = require "wibox"
xres = require "beautiful.xresources"
dpi = xres.apply_dpi

helper = require "utils.helper"
colors = require "theme.colors"
default_apps = require "apps"
calendar = require "widgets.calendar"
volume = require "components.volume"
fortune = require "components.fortune"

mainWidget = wibox {
  visible: false
  ontop: true
  width: 400
  type: "dock"
  bg: colors.black
}
awful.placement.maximize_vertically mainWidget

-- exibe/esconde a barra lateral
local sidebar_grabber
sidebar_hide = ->
  awful.keygrabber.stop sidebar_grabber
  mainWidget.visible = false

export sidebar_show = ->
  sidebar_grabber = awful.keygrabber.run (_,key, event) ->
    if event == "release" return

    if key == "Escape" or key == "q" or key == "x" or key == "m"
      sidebar_hide!

  mainWidget.visible = true

-- Pastas pessoais
userHome = os.getenv "HOME"
userDirs =
  music: userHome.."/Música" --, label: "Música"
  pictures:userHome.."/Imagens"--, label: "Imagens"
  documents:userHome.."/Documentos"--, label: "Documentos"
  videos: userHome.."/Vídeos"--, label: "Vídeos"
  downloads:userHome.."/Downloads"--, label: "Downloads"

create_dir_button = (dir,text) ->
  button_text = wibox.widget{
    markup: text
    forced_height: dpi 20
    font: "NotoSansMono Nerd Font 18"
    widget: wibox.widget.textbox
  }

  a_button = wibox.widget {
    {
      {
        button_text
        layout: wibox.layout.align.horizontal
      }
      margins: 8
      widget: wibox.container.margin
    }
    bg: colors.background
    --forced_height: dpi 30
    shape: helper.rrect 5
    visible: true
    widget: wibox.container.background
  }

  build_a_button = wibox.widget {
    layout: wibox.layout.fixed.horizontal
    spacing: dpi 5
    a_button
  }

  with build_a_button
    \connect_signal "button::release", ->
      awful.spawn "thunar "..dir
      sidebar_hide!
    \connect_signal "mouse::enter", ->
      button_text.markup = helper.colorize_text text, colors.indigo
    \connect_signal "mouse::leave", ->
      button_text.markup = helper.colorize_text text, colors.foreground

  build_a_button

dir_buttons =
  home: create_dir_button userHome, "Home"
  downloads: create_dir_button userDirs.downloads, "Downloads"
  videos: create_dir_button userDirs.videos, "Vídeos"
  pictures: create_dir_button userDirs.pictures, "Imagens"
  documents: create_dir_button userDirs.documents, "Documentos"
  music: create_dir_button userDirs.music, "Música"

dirs_grid = wibox.widget {
  dir_buttons.home
  dir_buttons.downloads
  dir_buttons.videos
  dir_buttons.pictures
  dir_buttons.documents
  dir_buttons.music
  forced_num_cols: 2
  forced_num_rows: 2
  spacing: 5
  horizontal_homogeneous: true
  expand: true
  layout:wibox.layout.grid
}

dirsContainer = wibox.widget {
  nil
  dirs_grid
  expand: "none"
  layout: wibox.layout.align.horizontal
}

-- Botões
button_size = dpi 60
icon_font = "NotoSansMono Nerd Font 22"

build_button = (icon, name, bg_color, hover_color) ->
  a_button = wibox.widget {
    {
      {
        forced_height: button_size
        forced_width: button_size
        text: icon
        font: icon_font
        align: "center"
        valign: "center"
        widget: wibox.widget.textbox
      }
      layout: wibox.layout.align.horizontal
    }
    forced_width: button_size
    forced_height: button_size
    visible: true
    bg: bg_color
    shape: helper.rrect dpi 8
    widget: wibox.container.background
  }

  build_a_button = wibox.widget {
    layout: wibox.layout.fixed.horizontal
    spacing: dpi 5
    a_button
  }

  build_a_button\connect_signal "mouse::enter", ->
    a_button.bg = hover_color
  build_a_button\connect_signal "mouse::leave", ->
    a_button.bg = bg_color

  build_a_button


searchIcon = ""
search = build_button searchIcon, "Procurar", colors.green, colors.light_green

configIcon = ""
config = build_button configIcon, "Configurações", colors.blue, colors.light_blue

restartIcon = ""
restart = build_button restartIcon, "Reiniciar", colors.yellow, colors.light_yellow

--events
mainWidget\buttons gears.table.join(
  awful.button {}, 3, -> sidebar_hide!
)
search\connect_signal "button::release", ->
  awful.spawn "rofi -show drun"
  sidebar_hide!
config\connect_signal "button::release", ->
  awful.spawn.with_shell default_apps.apps.config
  sidebar_hide!
restart\connect_signal "button::release", ->
  awesome.restart!

mainWidget\connect_signal "property::visible", ->
  if mainWidget.visible
    calendar.cal_widget.date = os.date('*t')

mainWidget\setup {
  {
    calendar.cal_widget
    {
      dirsContainer
      nil
      volume.volume_bar
      fortune.fortune
      spacing: dpi 35
      layout: wibox.layout.fixed.vertical
    }
    {
      nil
      {
        search
        config
        restart
        spacing: dpi 10
        layout: wibox.layout.fixed.horizontal
      }
      expand: 'none'
      layout: wibox.layout.align.horizontal
    }
    expand: "none"
    layout: wibox.layout.align.vertical
  }
  margins: 10
  widget: wibox.container.margin
}
