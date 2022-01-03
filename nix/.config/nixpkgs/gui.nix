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
            grimshot = mode: "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save ${mode} - | ${pkgs.swappy} -f -";
				in pkgs.lib.mkOptionDefault {
          "${modifier}+x" = "layout default";
					"${modifier}+f" = "exec flatpak run org.mozilla.firefox";
					"${modifier}+e" = "exec emacsclient -cn";
          "Print" = grimshot "output";
          "Ctrl+Print" = grimshot "area";
          "Shift+Print" = grimshot "screen";
          "Mod4+Print" = grimshot "active";
          "Ctrl+Mod4+Print" = grimshot "window";
				};
			fonts = {
				names = [ font.sans.name ];
				size = 9.;
			};
			bars = [{
				command = "${pkgs.waybar}/bin/waybar";
			}];
		};
	};

	programs.mako = {
		enable = true;
		font = "${font.sans.name} 9";
	};


	gtk = {
    enable = true;
		font = font.sans;
		theme = {
			package = pkgs.solarc-gtk-theme;
			name = "SolArc";
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
		dillo             # Basic browser for local stuff
    feh
		font.mono.package
		font.sans.package
		grim              # Notifications
		llpp              # PDF reader
		mat2              # Metadata Anonymization Toolkit
		noisetorch
		pavucontrol
		swayidle
		swaylock
    unzip             # Not GUI, but I only use it on GUI environments
		wl-clipboard
		wdisplays
		wofi              # Launcher menu
		youtube-dl
	];
}
