rofi_command = "rofi -show drun"

with {}
  .apps = {
    terminal: "env alacritty"
    rofi: rofi_command
    lock: "i3lock-fancy"
    browser: "env firefox"
    editor: "nvim-qt"
    files: "thunar"
    config: "nvim-qt +'CocCommand explorer ~/Documentos/dots'"
  }
  .run_on_startup = {
    "picom",
    "numlockx on",
    "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &"
  }
