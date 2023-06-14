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

let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

let-env PATH = ($env.PATH | split row (char esep) | prepend ['~/.local/bin', '~/.cargo/bin', '~/.pyenv/bin'])

load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

let-env PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

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
