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

### Clean Code

![Clean Code book](assets/img/clean-code.jpg)

---

## Improve robustness

+++

### My setup

Vim + ALE + ShellCheck

+++

ALE: Asynchronous Lint Engine

<https://github.com/w0rp/ale>

![ALE example](https://github.com/w0rp/ale/blob/master/img/example.gif?raw=true)

+++

ShellCheck: Static analyzer for Bash

<https://www.shellcheck.net/>

![ShellCheck example](https://inconsolation.files.wordpress.com/2014/07/2014-07-16-6m47421-shellcheck.jpg)

+++

### Write code incrementally and test continually!

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

See example [ifs.sh](assets/examples/ifs.sh)

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

---

## Improve Readability

---

## Q&A

## Keep in touch!

Bert Van Vreckem

[@bertvanvreckem](http://twitter.com/bertvanvreckem)

<http://twitter.com/bertvanvreckem>

<http://github.com/bertvv/presentation-clean-bash>