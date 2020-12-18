{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
		direnv
		emacs
		gnupg
		httpie
		ipcalc
		jq
		kitty
		libqalculate
		mako
		mosh
		mtr
		ripgrep
		stow
		sway
		swayidle
		swaylock
		tig
		wl-clipboard
		wofi
		zsh
	];

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "nicoo";
	home.homeDirectory = "/home/nicoo";

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "21.03";
}
