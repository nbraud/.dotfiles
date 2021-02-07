{ pkgs, ... }:
{
	programs.gpg.enable = true;
	services.gpg-agent = {
		enable = true;
		enableScDaemon = true;
		enableSshSupport = true;
		defaultCacheTtl = 30 * 60;
	};

	home.packages = with pkgs; [
    pinentry-gtk2
		yubikey-manager
	];
}
