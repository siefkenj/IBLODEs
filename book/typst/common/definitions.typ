
/// Show a named definition.
///  - name (string): The string label of the definition (it is the key in the dictionary lookup).
/// - definition_env: The definition environment function used to draw the definition box, etc.
#let show_def(definition_env: x => x, name) = {
  /// The list of all definitions that can be looked up.
  ///
  /// = If you have a new definition, it should be added here.
  ///
  let all_definitions = (
    model: definition_env(
      title: "Mathematical Model",
      label: <def_model>,
      [
        A _mathematical model_ is a description of the world that is
        + created in the service of answering a question, and
        + where the complexity of the world has been abstracted away to numbers, quantities, and their relationships.
          #footnote[Other mathematical objects are also allowed.]
      ],
    ),
    diffeq: definition_env(
      title: "Differential Equation",
      label: <def_diffeq>,
      [
        A _differential equation_ is an equation relating a function to one or more of its
        derivatives.
      ],
    ),
    model_fit: definition_env(
      title: "Fitting a Model",
      label: <def_model_fit>,
      [
        Given a model $M$ with parameters $k_1$, $k_2$, #sym.dots and data $D$, fitting the model $M$ to the
        data $D$ is the process of finding values for the parameters $k_1$, $k_2$, #sym.dots so that $M$
        most accurately predicts the data $D$.
      ],
    ),
  )

  /// Show the definition with the given name. `name` is a string.
  let _def_lookup(name) = {
    let ret = all_definitions.at(name, default: none)
    if ret == none {
      text(fill: red, [Definition not found. Available definitions are: #all_definitions.keys()])
    } else {
      ret
    }
  }

  _def_lookup(name)
}

