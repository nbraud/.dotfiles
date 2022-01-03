{ pkgs, ... }:
{
	programs.gpg = {
		enable = true;
		settings.keyserver = "hkps://keys.openpgp.org";
	};
	services.gpg-agent = {
		enable = true;
		enableScDaemon = true;
		#enableSshSupport = true;
		defaultCacheTtl = 30 * 60;
	};

	home.packages = with pkgs; [
		pinentry-curses
		yubikey-manager
	];

	programs.password-store = {
		enable = true;
	};
}
