{ config, pkgs, ... }:

let
	font.mono = {
		name = "Source Code Pro";
		package = pkgs.source-code-pro;
	};
	font.sans = {
		name = "Source Sans Pro";
		package = pkgs.source-sans-pro;
	};

in
{
	wayland.windowManager.sway = {
		enable = true;
		config = {
			terminal = "termite";
			modifier = "Mod4"; # Logo key
			keybindings =
				let modifier = config.wayland.windowManager.sway.config.modifier;
				in pkgs.lib.mkOptionDefault {
					"${modifier}+f" = "exec flatpak run org.mozilla.FirefoxNightly";
					"${modifier}+e" = "exec emacsclient -cn";
				};
			fonts = [ "${font.sans.name} 9" ];
		};
	};

	programs.mako = {
		enable = true;
		font = "${font.sans.name} 9";
	};


	gtk = {
		font = font.sans;
		theme = {
			package = pkgs.nordic;
			name = "Nordic";
		};
		gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
	};


	services.gammastep = {
		enable = true;
		latitude = "47.06667";
		longitude = "15.43333";
	};

	programs.mpv = {
		enable = true;
		config.audio-display = false;
		#defaultProfiles = [ "gpu-hq" ];
	};

	programs.termite = {
		enable = true;
		font = "${font.mono.name}, Medium 9";
		optionsExtra = "client_side_decoration = 0";

		backgroundColor = "#002b36";
		cursorColor = "#93a1a1";
		foregroundColor = "#839496";
		foregroundBoldColor = "#eee8d5";
		colorsExtra = ''
		color0 = #073642
		color1 = #dc322f
		color2 = #859900
		color3 = #b58900
		color4 = #268bd2
		color5 = #d33682
		color6 = #2aa198
		color7 = #eee8d5
		color8 = #002b36
		color9 = #cb4b16
		color10 = #586e75
		color11 = #657b83
		color12 = #839496
		color13 = #6c71c4
		color14 = #93a1a1
		color15 = #fdf6e3
		'';
	};

	home.packages = with pkgs; [
		font.mono.package
		font.sans.package
		grim
		pavucontrol
		swayidle
		swaylock
		wl-clipboard
		wofi
	];
}
