rofi_command = "rofi -show drun"

default_apps = {
	apps: {
		terminal: "env alacritty"
		rofi: rofi_command
		lock: "i3lock-fancy"
		browser: "env firefox"
		editor: "nvim-qt"
		files: "thunar"
		config: "nvim-qt .config/awesome"
	}
	run_on_startup: {
		"picom", 
		"numlockx on",
		"/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &"
	}
}

{:default_apps}
