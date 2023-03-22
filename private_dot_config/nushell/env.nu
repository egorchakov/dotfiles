# Nushell Environment Config File
let-env STARSHIP_SHELL = "nu"
let-env STARSHIP_SESSION_KEY = (random chars -l 16)
let-env PROMPT_MULTILINE_INDICATOR = (^/home/evgenii/.cargo/bin/starship prompt --continuation)

# Does not play well with default character module.
# TODO: Also Use starship vi mode indicators?
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = "I 〉"
let-env PROMPT_INDICATOR_VI_NORMAL = "N 〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

let-env PROMPT_COMMAND = {
    # jobs are not supported
    let width = (term size).columns
    ^/home/evgenii/.cargo/bin/starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
}

# Whether we can show right prompt on the last line
let has_rprompt_last_line_support = (version).version >= 0.71.0

# Whether we have config items
let has_config_items = (not ($env | get -i config | is-empty))

if $has_rprompt_last_line_support {
    let config = if $has_config_items {
        $env.config | upsert render_right_prompt_on_last_line true
    } else {
        {render_right_prompt_on_last_line: true}
    }
    {config: $config}
} else {
    { }
} | load-env

let-env PROMPT_COMMAND_RIGHT = {
    if $has_rprompt_last_line_support {
        let width = (term size).columns
        ^/home/evgenii/.cargo/bin/starship prompt --right $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
    } else {
        ''
    }
}

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

source ~/.zoxide.nu  

let-env EDITOR = 'hx'
let-env PYTHONBREAKPOINT = 'pudb.set_trace'
let-env PYTHON_KEYRING_BACKEND = 'keyring.backends.null.Keyring'
let-env DOCKER_BUILDKIT = 1
let-env COMPOSE_DOCKER_CLI_BUILD = 1
