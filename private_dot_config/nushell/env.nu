$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

$env.PATH = ($env.PATH | split row (char esep) | prepend ['~/.local/bin', '~/.cargo/bin', '~/.pyenv/bin'])

load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

$env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

alias zl = zellij
alias ipy = ipython
alias j = just
alias av = aws-vault
alias f = xplr

$env.EDITOR = 'hx'
$env.PYTHONBREAKPOINT = 'pudb.set_trace'
$env.PYTHON_KEYRING_BACKEND = 'keyring.backends.null.Keyring'
$env.DOCKER_BUILDKIT = 1
$env.COMPOSE_DOCKER_CLI_BUILD = 1

zoxide init nushell | str replace --all 'let-env' '$env.' | save -f ~/.zoxide.nu
starship init nu | str replace --all 'let-env' '$env.'| save -f ~/.starship.nu
