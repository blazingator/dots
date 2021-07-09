xres = require "beautiful.xresources"
wibox = require "wibox"
awful = require "awful"
naughty = require "naughty"
dpi = xres.apply_dpi

colors = require "theme.colors"
theme = require "theme.theme"
helper = require "utils.helper"

Split = (s, delimiter) ->
  result = {}
  for match in (s..delimiter)\gmatch("(.-)"..delimiter)
    table.insert(result, match)
    
  result

-- Wallpaper tool
wallpapers_dir = '/home/vinicius/Imagens/awesome-wallpapers/'
cmd = "ls "..wallpapers_dir
wallpapers_images = {
  "1.png"
  "2.png"
  "3.png"
  "4.png"
  "5.png"
  "6.png"
  "7.png"
  "sunrise-landscape.jpg"
  "the-neon-shallows.png"
  "two-in-one-boat.jpg"
  "ugly-dude-black.png"
  "ugly-dude-dark.png"
  "vaporwave.png"
}
-- 
-- awful.spawn.easy_async(cmd, (stdout) ->
--   wallpapers_images = wallpapers_dir .. Split stdout, '\n'
-- )

create_img_container = (img) ->
  container = wibox.widget {
    image: img
    forced_height: dpi 150
    forced_width: dpi 200
    widget: wibox.widget.imagebox
  }

  return container

img_containers = {}
for i=1,13
  table.insert img_containers, create_img_container(wallpapers_dir..wallpapers_images[i])

dummy_textclock = wibox.widget.textclock("%M")
dummy_textclock.visible = false

wallpapers_list = wibox.widget {
  {
    img_containers[1]
    img_containers[2]
    img_containers[3]
    img_containers[4]
    img_containers[5]
    img_containers[6]
    img_containers[7]
    img_containers[8]
    img_containers[9]
    img_containers[10]
    img_containers[11]
    img_containers[12]
    img_containers[13]
    spacing: 5
    expand: true
    forced_num_cols: 4
    layout: wibox.layout.grid
  }
  margins: dpi 10
  layout: wibox.container.margin
}

current_wallpaper = wibox.widget {
  {
    {
      text: "Papel de parede atual"
      font: "sans bold 12"
      valign: "center"
      align: "center"
      widget: wibox.widget.textbox
    }
    {
      image: theme.wallpaper
      forced_height: dpi 200
      forced_width: dpi 200
      widget: wibox.widget.imagebox
    }
    spacing: dpi 5
    layout: wibox.layout.fixed.vertical
  }
  spacing: dpi 10
  layout: wibox.layout.fixed.vertical
}

wrapper = wibox {
  visible: false
  ontop: true
  type: 'splash'
  bg: colors.black .. '99'
}
awful.placement.maximize wrapper

local wallpaper_grabber
export show_container = ->
  wallpaper_grabber = awful.keygrabber.run (_,key, event) ->
    if event == "release" return

    if key == "Escape" or key == "q" or key == "x" or key == "m"
      hide_container!

  wrapper.visible = true

export hide_container = ->
  awful.keygrabber.stop wallpaper_grabber
  wrapper.visible = false

wrapper\setup{
  {
    -- {
      current_wallpaper
      --nil
    --   expand: 'none'
    --   layout: wibox.layout.align.vertical
    -- }
    wallpapers_list 
    
    expand: 'none'
    layout: wibox.layout.align.horizontal
  }
  margins: 20
  widget: wibox.container.margin
}
