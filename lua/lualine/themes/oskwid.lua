local oskwid_theme = require("oskwid.palette").themes

local oskwid = {}

oskwid.normal = {
  a = { bg = oskwid_theme.primary, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.primary },
  c = { bg = oskwid_theme.activeBackground, fg = oskwid_theme.activeForeground },
}

oskwid.insert = {
  a = { bg = oskwid_theme.variable, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.variable },
}

oskwid.command = {
  a = { bg = oskwid_theme.yellow, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.yellow },
}

oskwid.visual = {
  a = { bg = oskwid_theme.magenta, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.magenta },
}

oskwid.replace = {
  a = { bg = oskwid_theme.red, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.red },
}

oskwid.terminal = {
  a = { bg = oskwid_theme.blue, fg = oskwid_theme.activeBackground },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.blue },
}

oskwid.inactive = {
  a = { bg = oskwid_theme.lowBackground, fg = oskwid_theme.ignored },
  b = { bg = oskwid_theme.lowActiveBackground, fg = oskwid_theme.ignored },
  c = { bg = oskwid_theme.background, fg = oskwid_theme.ignored },
}

return oskwid
