{ config, lib, pkgs, ... }:

{
  accounts.email.accounts = {
    "mur.at" = {
      realName = "Nico Braud-Santoni";
      address = "nicoo@mur.at";
      aliases = [ "nicoo@realraum.at" "fluff@realraum.at" ];
      primary = true;

      userName = "nicoo";
      passwordCommand = "pass mur.at";
      smtp = {
        host = "smtp.mur.at";
        tls.enable = true;
      };

      msmtp.enable = true;
      neomutt = {
        enable = true;
        sendMailCommand = "${pkgs.msmtp}/bin/sendmail";
      };
    };

    "braud-santoni.eu" = {
      realName = "Nico Braud-Santoni";
      address = "nicolas@braud-santoni.eu";
      aliases = [];

      userName = "nicolas";
      passwordCommand = "pass smtp.braud-santoni.eu";
      smtp = {
        host = "antartica.braud-santoni.eu";
        tls.enable = true;
      };

      msmtp.enable = true;
    };
  };

  programs.astroid.enable = true;
  programs.msmtp = {
    enable = true;
    extraAccounts =
      let primary = builtins.head (lib.filter (a: a.primary) (lib.attrValues config.accounts.email.accounts)); in
      "account default : ${primary.name}";
  };
  programs.neomutt.enable = true;
}
