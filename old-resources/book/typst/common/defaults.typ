/// This file contains default settings for the book. These are used unless overridden.

#let config = (
  //sans_font: ("Droid Sans", "DejaVu Sans"),
  sans_font: ("NimbusSanL"),
  serif_font: ("Bitstream Charter", "Libertinus Serif"),
  mono_font: ("Latin Modern Mono"),
  def_color: color.rgb("#8dc73e"),
  thm_color: color.rgb("#ed9537"),
)

/// Set the font to the sans font.
#let sans(content) = {
  set text(font: config.sans_font)
  content
}

/// Set the font to the serif font.
#let serif(content) = {
  set text(font: config.serif_font)
  content
}

/// Set the font to the mono font.
#let mono(content) = {
  set text(font: config.mono_font)
  content
}

/// Create a boxed definition.
/// - title (content): The title of the definition.
/// - label (label | none): The label of the definition for referencing it.
/// - content (content): The body of the definition.
#let definition(title: none, label: none, content) = {
  let darker_color = config.def_color.darken(30%)
  show emph: it => text(it, fill: darker_color, weight: "bold")
  set list(marker: make_marker(color: darker_color))
  box(
    fill: def_color.lighten(80%),
    stroke: (left: def_color + 3pt),
    inset: 7pt,
    {
      text(
        [#title.#if label != none { label } else { none }],
        fill: darker_color,
        weight: "bold",
        font: sans_font,
      )
      content
    },
    width: 100%,
  )
}

/// Create a boxed theorem.
/// - title (content): The title of the definition.
/// - label (label | none): The label of the definition for referencing it.
/// - content (content): The body of the definition.
#let theorem(title: none, label: none, content) = {
  let darker_color = config.thm_color.darken(30%)
  show emph: it => text(it, fill: darker_color, weight: "bold")
  set list(marker: make_marker(color: darker_color))
  box(
    fill: def_color.lighten(80%),
    stroke: (left: def_color + 3pt),
    inset: 7pt,
    {
      text(
        [#title.#if label != none { label } else { none }],
        fill: darker_color,
        weight: "bold",
        font: sans_font,
      )
      content
    },
    width: 100%,
  )
}

/// Accept any number of arguments and return only the content in positional arguments.
/// This is used as a default "pass through everything" function.
#let noop(..args) = {
  args.pos().filter(c => type(c) == content).join()
}

/// Only show `content` when the `active_env` equals the `when` condition.
#let restrict(when: "", active_env: "", content, otherwise: none) = {
  if (type(when) == array and when.contains(active_env)) or when == active_env {
    content
  } else if otherwise != none {
    otherwise
  }
}

/// The default env
#let env = (
  sans: sans,
  serif: serif,
  mono: mono,
  definition: definition,
  theorem: theorem,
  slide: noop,
  question: noop,
  restrict: restrict,
)

/// A sentinel value that we can use to test for failed lookups.
#let _sentinel() = { }

/// Look up a key in the environment, falling back to defaults if the key is not found.
/// If there is no default, this function panics.
///
/// - base_env (dictionary): A dictionary to look up from. Items in `base_env` take priority.
#let env_lookup(base_env: env, key) = {
  // If `key` is an array, we want to return a dictionary with keys equal to the array values.
  if type(key) == array {
    return key.map(k => (k, env_lookup(base_env: base_env, k))).to-dict()
  }
  if type(key) != str {
    panic("Key must be a string or an array of strings, not '" + str(key) + "'.")
  }

  let ret = base_env.at(key, default: _sentinel)
  if ret == _sentinel {
    ret = env.at(key, default: _sentinel)
  }
  if ret == _sentinel {
    panic("Could not find key: " + str(key) + " in environment.")
  }

  ret
}

/// Return a dictionary of all environment values
/// that are defined by default.
///
/// - base_env (dictionary): A dictionary to look up from. Items in `base_env` take priority.
#let env_lookup_all(base_env: env) = {
  env_lookup(base_env: base_env, env.keys() + base_env.keys())
}
