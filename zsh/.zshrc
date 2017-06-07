#!/bin/zsh

# Grml stuff
export GRML_NO_APT_ALIASES=1
export GRML_NO_SMALL_ALIASES=1

fpath=("${_GRML_ROOT}/usr_share_grml/zsh/" $fpath)
source "${_GRML_ROOT}/etc/zsh/zshrc"


# Aliases
alias tuerctl='ssh -i ${HOME}/.ssh/keys/realraum/id_door tuerctl@torwaechter.mgmt.realraum.at'

if command -v sm &>/dev/null; then
    alias fp='echo "Nicolas Braud-Santoni\n<nicolas@braud-santoni>\n\n772B 11B4 F2DC 80E1 212B\n3F41 B073 9AAD 91B7 CDC0\n\n5494 011A F573 2B89 AEA4\n5E54 3D03 120B C39B 56AB" | sm -'
    alias sm='sm -n "Source Sans Pro"'
fi

alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'

if [[ -r /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi


# Antigen
source "${_ZSH_ROOT}/antigen/antigen.zsh"

## Antigen bundles
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle joel-porquet/zsh-dircolors-solarized
antigen bundle zlsun/solarized-man


## Prompt
setopt PROMPT_SUBST
antigen theme https://gist.github.com/agnoster/3712874 agnoster

antigen apply


# Local custom functions
compdef _r3pass r3pass
function r3pass() {
    PASSWORD_STORE_DIR="${HOME}"/perso/r3/noc-pass pass $@
}
function _r3pass() {
    PASSWORD_STORE_DIR="${HOME}"/perso/r3/noc-pass _pass
}

function jam() {
    if [ "$#" -eq 0 ]; then
	echo "Usage: $0 file1.pdf [file2.pdf ...]" >&2
	return
    fi
    for file in "$@"; do
        if ! [ -f "$file" ] || ! [ ${${file}##*.} = "pdf" ]; then
        	echo "'$file' is not a PDF file" >&2
        	return
        fi
        
        local base="$(basename "$file" .pdf)"
        local temp="$(mktemp -u "${base}.XXXXXX.pdf")"
        
        pdfjam --outfile "$temp" --paper a4paper "$file"
        gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true -dPDFSETTINGS=/prepress \
           -dSubsetFonts=false -dCompatibilityLevel=1.4 -dNOPLATFONTS                       \
           -sOutputFile="${base}.a4.pdf" "$temp"
        rm -f "$temp"
    done
}

function gpg-recv-signers() {
    local IFS=':'
    local KEYS=()
    for id in "$@"; do
	gpg --list-sigs --with-colons "$id" | \
	    while read sig _ _ _ keyid _ _ _ _ name _; do
		[[ "$sig" == "sig" ]] && [[ "$name" == '[User ID not found]' ]] \
		    || continue
		KEYS+=("$keyid")
	    done
    done
    sort -u <<< ${KEYS[@]} | xargs gpg --recv-keys
}
