{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tor-arm
    torsocks
  ];

  # AvoidDiskWrites 1
  # ControlPort unix:$XDG_RUNTIME_DIR/tor/control
  # SocksPort unix:$XDG_RUNTIME_DIR/tor/socks
  # CacheDirectort $XDG_SOMETHING/tor
  # DataDirectory $XDG_OTHER/tor
  # Log info syslog
  # NoExec 1
  # Sandbox 1
  # SafeSocks 1
  # 
}
