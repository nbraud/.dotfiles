{ config, pkgs, ... }:

{

  programs.emacs.enable = true;
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableScDaemon = true;
    enableSshSupport = true;
    defaultCacheTtl = 30 * 60;
  };

	home.packages = with pkgs; [
		direnv
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
