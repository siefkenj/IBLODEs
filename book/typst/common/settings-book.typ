#import "../libs/_workbook.typ": setup
#let workbook = setup(banner_color: color.rgb("#00a2cb"))

// Bind `lookup_def` with the current definition environment so they appear boxed correctly.
#import "./definitions.typ": show_def
/// Show the definition with the given name. `name` is a string.
#let show_def = show_def.with(definition_env: workbook.definition)

#let active_env = "book"
#import "./defaults.typ": env_lookup_all, restrict
#let env = env_lookup_all(
  base_env: (..workbook, active_env: active_env, restrict: restrict.with(active_env: active_env), show_def: show_def),
)


