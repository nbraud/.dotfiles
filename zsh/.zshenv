#!/bin/zsh
local _ZSH_ROOT="${HOME}/.local/share/zsh"
local _GRML_ROOT="${_ZSH_ROOT}/grml-etc-core"
source "${_GRML_ROOT}/etc/zsh/zshenv"

function has() {
    command -v "$1" >/dev/null
}

# Locales
export LANGUAGE=C.UTF-8
export LANG=C.UTF-8
#export LC_MEASUREMENT=1 # Use SI units
export LC_MONETARY=fr_FR.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8
export LC_COLLATE=C


# Kinda usual
path=("${HOME}/.local/bin" $path)
export ADOTDIR="${HOME}/.cache/antigen"
export EDITOR=emacsclient

! has clang   || export  CC=clang
! has clang++ || export CXX=clang++

# Using GnuPG as a SSH agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Debian
export DEBFULLNAME="nicoo"
export DEBEMAIL="nicoo@debian.org"

# Sway
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=intl

# pkg-config
export PKG_CONFIG_PATH="${HOME}/.local/lib/pkgconfig"

# XDG/systemd crap
if [ -d /run/user ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

# Aquaria
export AQUARIA_DATA_PATH="${HOME}/.local/aquaria"

# Don't warn on empty globs while processing .zshenv
setopt nullglob

# Support manipulating LD_LIBRARY_PATH through an array
typeset -T LD_LIBRARY_PATH ld_library_path
ld_library_path+=("${HOME}/.local/lib")

# Golang crap
if has go; then
    typeset -T GOPATH gopath
    gopath=("$HOME/.cache/gocode/" "/usr/share/gocode")
    ! [ -d ~/.cache/gocode/bin ] || path+=("${HOME}/.cache/gocode/bin")
fi

# OCaml
! has opam || eval $(opam env)
! has ocamlfind ||
    ld_library_path=("$(ocamlfind printconf destdir)/stublibs" $ld_library_path)

# Racket stuff
! has racket || path+=( ~/.racket/*/bin(/) )

# Ruby crap
! has gem || path+=( ~/.gem/ruby/*/bin(/) )

# Rust
! { has cargo  || [ -d ~/.cargo/bin ] } || path=( ~/.cargo/bin $path )

if has git; then
    function git_is_clean() {
        local repo="${1:-$PWD}"
        local st
        st="$(git -C ${repo} status --porcelain)" && [ -z "$st" ]
    }
fi

# Unset nullglob
unsetopt nullglob
