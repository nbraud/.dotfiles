{ config, pkgs, ... }:

{
	imports = [
		./gpg.nix
		./gui.nix
	];

	programs.emacs.enable = true;
	services.emacs = {
		enable = true;
		socketActivation.enable = true;
	};

	programs.direnv.enable = true;
	programs.direnv.enableNixDirenvIntegration = true;

	home.packages = with pkgs; [
		gitAndTools.delta
		gitAndTools.gh
		httpie
		ipcalc
		jq
		libqalculate
		mosh
		mtr
		nix-prefetch
		ripgrep
		stow
		tig
		tree
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
