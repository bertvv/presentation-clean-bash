# Clean Bash: Leveling up your shell scripting skills

---

## Introduction

+++

### whoami

- Bert Van Vreckem
- Lecturer ICT at University College Ghent (HOGENT)
    - Linux, stats, project/thesis coach
- Open source enthousiast
    - Ansible, Git, LaTeX, Vagrant, ...

+++

@title[The good, bad & ugly]

Who **loves** scripting in Bash?

+++

I expected no/very few hands...

+++

Bash is

- ugly
- arcane
- weird

+++

However, Bash also

- is everywhere
- is not going anywhere soon
- is useful for automating tedious tasks
- has no dependencies

+++

If you accept this, then hopefully also:

- learning Bash is useful
- code quality is valuable
- good coding practices matter
- revision control goes without saying

+++

@title[Clean code]

![Clean Code book](assets/img/clean-code.jpg)

---

## Improve robustness

+++

### My setup

Vim + ALE + ShellCheck

templates.vim + Ultisnips

+++

ALE: Asynchronous Lint Engine

<https://github.com/w0rp/ale>

![ALE example](https://github.com/w0rp/ale/blob/master/img/example.gif?raw=true)

+++

ShellCheck: Static analyzer for Bash

<https://www.shellcheck.net/>

![ShellCheck example](https://inconsolation.files.wordpress.com/2014/07/2014-07-16-6m47421-shellcheck.jpg)

+++

templates.vim

<https://www.vim.org/scripts/script.php?script_id=1172>

[My Bash script template](https://github.com/bertvv/dotfiles/blob/master/.vim/templates/sh)

+++

Ultisnips

<https://www.vim.org/scripts/script.php?script_id=2715>

[My Bash snippets](https://github.com/bertvv/dotfiles/blob/master/.vim/UltiSnips/sh.snippets)

### Write code incrementally and test continually!

<!-- TODO: add typical scripting session with editor and console -->

+++

### "Unofficial Bash Strict Mode"

```bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
```

+++

### Internal field separator

```bash
# Default
IFS=$' \n\t' 

# Recommendation: remove the space
IFS=$'\n\t' 
```

See example [ifs.sh](https://github.com/bertvv/presentation-clean-bash/blob/master/examples/ifs.sh)

+++

### Print log messages

```bash
readonly debug='on'
log() {
    printf '\e[0;33m[INF] %s\e[0m\n' "${*}"
}
debug() {
  [ "${debug}" == 'on' ] && printf '\e[0;36m[DBG] %s\e[0m\n' "${*}"
}
error() {
  printf "\e[0;31m[ERR] %s\e[0m\n" "${*}" 1>&2
}
```

+++

### Bash's "debug mode"

```bash
set -x
#
# Problematic code
#
set +x
```

Shows each command, after applying substitutions

+++

### Unit tests with BATS

Bash Automated Testing System

<https://github.com/bats-core/bats-core>

Example:

- <https://github.com/HoGentTIN/ilnx-labos/blob/master/labo6/tests/02-gebruikerslijst.bats>
- <https://github.com/HoGentTIN/ilnx-labos/blob/master/labo8/tests/1-passphrase.bats>
- <https://github.com/HoGentTIN/elnx-sme/blob/master/test/pu004/lamp.bats>

---

## Functions as building blocks of robust, clean shell scripts

+++

### Bash functions

- scripts inside scripts
    - but no subshell!
- pass arguments: positional parameters
- return value = exit status
    - of last statement
    - `return 0`, `return 1`, etc.
- other "return values" through `stdout`

+++

```bash
# Function declaration syntax
my_function() {
    # ...
}

# Calling a function
my_function arg1 arg2 arg3
```

+++

```bash
# Usage: mkd DIR
#   Create a directory and cd into it.
mkd() {
    mkdir -p "${1}" && cd "${1}"
}

# Example:
mkd a/b/c
```

+++

```bash
# Usage: copy_iso_to_usb ISO_FILE DEVICE
# Copy an ISO file to a USB device, showing progress with pv (pipe viewer)
# e.g. copy_iso_to_usb FedoraWorkstation.iso /dev/sdc
copy_iso_to_usb() {
  # Name parameters
  local iso="${1}"
  local destination="${2}"
  # Local variable:
  local iso_size

  iso_size=$(stat -c '%s' "${iso}")

  log 'Copying ${iso} (${iso_size}B) to ${destination}'

  dd if="${iso}" \
    | pv --size "${iso_size}" \
    | sudo dd of="${destination}"
}
```

---

## Robustness, continued

+++

### Idempotence

@snap[south west]
@quote[**Idempotence** is the property of an operation whereby it can be applied multiple times without changing the result beyond the initial application.](Wikipedia)
@endsnap

+++

This script can only be run once:

```bash
#! /bin/bash
user="${1}"
password="${2}"

adduser "${user}"
passwd --stdin <<< "${password}"
```

+++

```bash
# ...

if ! getent passwd "${user}" > /dev/null
then
    adduser "${user}"
fi
passwd --stdin <<< "${password}"
```

+++

### Make your scripts idempotent

- Script can be run under any cirumstance
- Result is desired state of the system
- Fail early if something goes wrong

---

## Improve Readability

---

## Q&A

+++

## Keep in touch!

Bert Van Vreckem

[@bertvanvreckem](http://twitter.com/bertvanvreckem)

<http://twitter.com/bertvanvreckem>

<http://github.com/bertvv/presentation-clean-bash>