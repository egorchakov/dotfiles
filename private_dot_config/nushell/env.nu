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

$env.PATH = ($env.PATH | split row (char esep) | prepend ['~/.local/bin', '~/.cargo/bin', '~/.pyenv/bin', '/opt/homebrew/bin', '/usr/local/go/bin'])

load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

$env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

alias zl = zellij
alias ipy = ipython
alias j = just
alias av = aws-vault
alias f = yazi
alias pt = poetry
alias pts = poetry shell

$env.EDITOR = 'hx'
$env.PYTHONBREAKPOINT = 'pudb.set_trace'
$env.PYTHON_KEYRING_BACKEND = 'keyring.backends.null.Keyring'
$env.DOCKER_BUILDKIT = 1
$env.COMPOSE_DOCKER_CLI_BUILD = 1

mkdir ~/.cache/zoxide
zoxide init nushell | str replace --all 'def-env' 'def --env' | save -f ~/.cache/zoxide/init.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/atuin
atuin init nu | save -f ~/.cache/atuin/init.nu
