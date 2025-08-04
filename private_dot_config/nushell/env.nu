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

$env.NU_LIB_DIRS = [ ($nu.config-path | path dirname | path join 'scripts') ]
$env.NU_PLUGIN_DIRS = [ ($nu.config-path | path dirname | path join 'plugins') ]
$env.PATH = ($env.PATH | split row (char esep) | prepend ['~/.local/bin', '~/.cargo/bin', '~/go/bin', '/opt/homebrew/bin', '/usr/local/go/bin', '/usr/local/bin'])
$env.EDITOR = 'hx'
$env.PYTHONBREAKPOINT = 'pudb.set_trace'
$env.PYTHON_KEYRING_BACKEND = 'keyring.backends.null.Keyring'
$env.DYLD_FALLBACK_LIBRARY_PATH = "/opt/homebrew/lib/"

if (which zoxide | is-not-empty) {
  mkdir ~/.cache/zoxide
  zoxide init nushell | save -f ~/.cache/zoxide/init.nu
}

if (which starship | is-not-empty) {
  mkdir ~/.cache/starship
  starship init nu | save -f ~/.cache/starship/init.nu
}

if (which carapace | is-not-empty) {
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}

if (which atuin | is-not-empty) {
  mkdir ~/.cache/atuin
  atuin init nu | save -f ~/.cache/atuin/init.nu
}

def --env f [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

alias zl = zellij
alias ipy = ipython
alias j = just
alias av = aws-vault
