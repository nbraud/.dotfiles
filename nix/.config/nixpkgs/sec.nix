{ pkgs, ... }:
{
	# Various security work tools
	home.packages = with pkgs; [
		python39.shodan
	];
}
