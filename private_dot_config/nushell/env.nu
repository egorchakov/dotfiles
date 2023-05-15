# Nushell Environment Config File
# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
let-env PATH = ($env.PATH | split row (char esep) | prepend ['~/.local/bin', '~/.cargo/bin', '~/.pyenv/bin'])

alias zl = zellij
alias ipy = ipython
alias j = just
alias av = aws-vault
alias f = xplr

let-env EDITOR = 'hx'
let-env PYTHONBREAKPOINT = 'pudb.set_trace'
let-env PYTHON_KEYRING_BACKEND = 'keyring.backends.null.Keyring'
let-env DOCKER_BUILDKIT = 1
let-env COMPOSE_DOCKER_CLI_BUILD = 1

zoxide init nushell | save -f ~/.zoxide.nu
starship init nu | save -f ~/.starship.nu
