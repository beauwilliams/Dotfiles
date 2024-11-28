local function init()
  require("core")
  safe_require("plugins._lazy")
  safe_require("settings._options")
  safe_require("settings.mappings")
  safe_require("settings.commands")
  safe_require("settings.autocommandss")
  safe_require("settings.abbreviations")
  safe_require("settings.lsp")
  safe_require("settings._theme")
  return nil
end
init()
return nil
