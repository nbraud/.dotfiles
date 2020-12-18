{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
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
    };
  };
}
