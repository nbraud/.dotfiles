{ pkgs, ... }:
{
	# My IDEs of choice
	programs.emacs.enable = true;
	services.emacs = {
		enable = true;
		socketActivation.enable = true;
	};

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
#      matklad.rust-analyzer
#      ocamllabs.ocaml-platform
#      tamasfe.even-better-toml
    ];
  };

	# Utilities to set environments up per-directory
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	# Various CLI tools I use in development
	home.packages = with pkgs; [
    asciinema
		gitAndTools.delta
		gitAndTools.gh
		httpie
		jq
    manpages
		nix-prefetch
		ripgrep
    swaks
		tig
	];
}
