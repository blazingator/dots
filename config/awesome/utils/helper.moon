import shape from require "gears"

export rrect = (radius) ->
  return (cr, width, height)->
    shape.rounded_rect(cr,width,height, radius)

colorize_text = (text,color) -> 
  return "<span foreground='"..color.."'>"..text.."</span>"


{:colorize_text, :rrect}
