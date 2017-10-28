#!/bin/zsh
local _ZSH_ROOT="${HOME}/.local/share/zsh"
local _GRML_ROOT="${_ZSH_ROOT}/grml-etc-core"
source "${_GRML_ROOT}/etc/zsh/zshenv"

function has() {
    command -v "$1" >/dev/null
}

# Locales
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=C


# Kinda usual
export PATH="${HOME}/.local/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/.local/lib"
export ADOTDIR="${HOME}/.cache/antigen"
export EDITOR=emacsclient

! has clang   || export  CC=clang
! has clang++ || export CXX=clang++


# Using GnuPG as a SSH agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"


# Ruby crap
if [ -d "${HOME}/.gem/ruby" ]; then
    for i in "${HOME}"/.gem/ruby/*; do
	      PATH="${PATH}:${i}/bin"
    done
fi
export PATH

# Golang crap
export PATH="${HOME}/.cache/gocode/bin:${PATH}"
export GOPATH="$HOME/.cache/gocode/:/usr/share/gocode"

# Rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# OCaml
! has opam || eval $(opam config env)
! has ocamlfind || export LD_LIBRARY_PATH="$(ocamlfind printconf destdir)/stublibs:${LD_LIBRARY_PATH}"


# Aquaria
export AQUARIA_DATA_PATH="${HOME}/.local/aquaria"


# Debian
export DEBFULLNAME="Nicolas Braud-Santoni"
export DEBEMAIL="nicolas@braud-santoni.eu"

# Sway
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=intl

# pkg-config
export PKG_CONFIG_PATH="${HOME}/.local/lib/pkgconfig"
