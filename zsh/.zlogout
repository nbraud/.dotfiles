if sudo etckeeper unclean; then
	cat <<-EOF
	Some config changes were not commited:
	$(sudo etckeeper vcs status)

	Last connections are:
	$(last -5)
	EOF
fi
