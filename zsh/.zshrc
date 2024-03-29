#!/bin/zsh

# Grml stuff
export GRML_NO_APT_ALIASES=1
export GRML_NO_SMALL_ALIASES=1

fpath=("${_GRML_ROOT}/usr_share_grml/zsh/" "${HOME}/.local/share/zsh/zfuns" $fpath)
source "${_GRML_ROOT}/etc/zsh/zshrc"


# Some options/configuration
## Use natural sorting by default when expanding globs
setopt NUMERIC_GLOB_SORT

# Aliases
alias tuerctl='ssh -i ${HOME}/.ssh/keys/realraum/id_door tuerctl@torwaechter.mgmt.realraum.at'
alias cdtmp='cd "$(mktemp -d)"'

alias zcp='zmv -C'
alias zln='zmv -L'

if has sm; then
    alias fp='echo "Nicolas Braud-Santoni\n<nicolas@braud-santoni>\n\n772B 11B4 F2DC 80E1 212B\n3F41 B073 9AAD 91B7 CDC0\n\n5494 011A F573 2B89 AEA4\n5E54 3D03 120B C39B 56AB" | sm -'
    alias sm='sm -n "Source Sans Pro"'
fi

alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'

# Command Not Found support
# Adapted from a snippet by Zygmunt Krynicki, under GPL license
if has command-not-found; then
    if (( ! ${+functions[command_not_found_handler]} )); then
        local cnf_path="$(command -v command-not-found)"
        function command_not_found_handler {
            [[ -x "${cnf_path}" ]] || return 1
            "${cnf_path}" ${1+"$1"} && :
        }
    fi
fi


# Direnv
if has direnv; then
    eval "$(direnv hook $0)"
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
if has pass; then
    compdef _r3pass r3pass
    function r3pass() {
        PASSWORD_STORE_DIR="${HOME}"/perso/r3/noc-pass pass "$@"
    }
    function _r3pass() {
        PASSWORD_STORE_DIR="${HOME}"/perso/r3/noc-pass _pass "$@"
    }
fi

if has kubectl >/dev/null; then
    source <(kubectl completion zsh)
fi


function jam() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: $0 file1.pdf [file2.pdf ...]" >&2
        return
    fi

    local file
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

    if [ "$#" -eq 0 ]; then
        echo "Are you *sure* you want to import all unknown signers?" >&2
        echo "(return to continue, ^C to abort)"                      >&2
        read _
    fi
    gpg --list-sigs --with-colons "$@" | \
        while read sig _ _ _ keyid _ _ _ _ name _; do
            [[ "$sig" == "sig" ]] && [[ "$name" == '[User ID not found]' ]] \
                || continue
            KEYS+=("$keyid")
        done
    local IFS=' '
    sort -u <<< ${KEYS[@]} | xargs gpg --recv-keys
}

if [ -e ~/codenames.xz ]; then
    function codename() {
        local n=20
        if [ "$#" -eq 1 ] && [[ "$1" = <-> ]]; then
            n="$1"
        elif [ "$#" -ne 0 ]; then
            cat >&2 <<EOF
Usage: $0 [n]
Prints n randomly-sampled codenames, one per line.  n defaults to $n.
EOF
            return 1
        fi

        xzcat ~/codenames.xz | shuf -n "$n"
    }
fi

if has http; then
    function httpager() {
        http --pretty=all --print=hb "$@" | less -R
    }
fi

GUI_SESSION=sway
if has ${GUI_SESSION}; then
    if has vlock; then
	      alias sx="${GUI_SESSION} &; vlock"
    else
	      alias sx="exec ${GUI_SESSION}"
    fi
fi
