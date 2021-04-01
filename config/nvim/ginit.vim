" call GuiClipboard()
if exists('g:GtkGuiLoaded')
  call rpcnotify(1, "Gui", "Font", "DejaVu Sans Mono 12")
  let g:GuiInteralClipboard = 1
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
