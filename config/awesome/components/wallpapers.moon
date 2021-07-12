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

-- Wallpaper tool --- sets the wallpaper based on symbolic link
wallpapers_dir = '/home/vinicius/Imagens/awesome-wallpapers/'
wallpapers_images = {
  "1.png"
  "2.png"
  "3.png"
  "4.png"
  "5.png"
  "6.png"
  "7.png"
  "8.jpg"
  "9.png"
  "10.jpg"
  "11.png"
  "12.png"
  "13.png"
}
for i=1,13
  wallpapers_images[i] = wallpapers_dir..wallpapers_images[i]

create_img_container = (img) ->
  container = wibox.widget {
    image: img
    forced_height: dpi 100
    forced_width: dpi 200
    widget: wibox.widget.imagebox
  }

  helper.add_hover_cursor container, "hand1"

  container\connect_signal "button::release", () ->
    helper.set_wallpaper_symlink img

  container

img_containers = {}
for i=1,13
  table.insert img_containers, create_img_container(wallpapers_images[i])

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
    homogeneous: true
    forced_num_cols: 4
    layout: wibox.layout.grid
  }
  margins: dpi 10
  forced_width: dpi 900
  widget: wibox.container.margin
}

current_wallpaper = wibox.widget {
  -- {
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
  -- }
  -- spacing: dpi 10
  -- layout: wibox.layout.fixed.vertical
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
    nil
    wallpapers_list 
    
    expand: 'none'
    layout: wibox.layout.align.horizontal
  }
  margins: 20
  widget: wibox.container.margin
}
