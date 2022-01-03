{ config, pkgs, ... }:

{
	imports = [
		./dev.nix
		./gpg.nix
		./gui.nix
		./looking-glass.nix
		./mail.nix
		./tor.nix
	];

	home.packages = with pkgs; [
		cfssl
		ffsend
		file
		ipcalc
		libqalculate
		magic-wormhole
		mosh
		mtr
		sshfs
		stow
		tree
		wget
		whois
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
