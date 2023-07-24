-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'GruvboxDark'
config.font = wezterm.font 'JetBrains Mono'

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
  regex = [[(NAV-[0-9]{1,})]],
  format = 'https://navitia.atlassian.net/browse/$1',
})

config.keys = {
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action.QuickSelect,
  }
}

-- and finally, return the configuration to wezterm
return config

