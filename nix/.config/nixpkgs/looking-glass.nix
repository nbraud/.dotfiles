{ config, pkgs, ... }:
{
	# Packages for doing VM shenanigans
	home.packages = with pkgs; [
		looking-glass-client
		#scream
	];

	# SHM files; used for shared-memory audio and graphics w/ the guest
	systemd.user.tmpfiles.rules = [
		"f %t/looking-glass 0660 %u qemu-libvirtd -"
	];

	#systemd.user.services.scream-ivshmem = {
  #  Unit = {
  #    Description = "Scream IVSHMEM";
	#	  WantedBy = [ "multi-user.target" ];
	#	  Requires = [ "pulseaudio.service" ];
  #  };
	#	Service = {
	#		#ExecStart = "dd if=/dev/zero of=%t/scream count=???";
	#		ExecStart = "${pkgs.scream}/bin/scream-ivshmem-alsa %t/scream";
	#		Restart = "always";
	#	};
	#};
}
