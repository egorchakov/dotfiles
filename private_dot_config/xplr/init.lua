version = "0.21.3"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    'dtomvan/xpm.xplr',
    'dtomvan/extra-icons.xplr',
    'sayanarijit/fzf.xplr',
    'sayanarijit/zentable.xplr',
    'sayanarijit/tri-pane.xplr',
    'sayanarijit/preview-tabbed.xplr',
    'sayanarijit/alacritty.xplr',
    'sayanarijit/zoxide.xplr',
    'Junker/nuke.xplr',
  },
  auto_install = true,
  auto_cleanup = true,
})

require("preview-tabbed").setup()