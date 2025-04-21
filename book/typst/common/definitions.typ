
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
    component_and_phase: definition_env(
      title: "Component Graph & Phase Plane",
      label: <def_component_and_phase>,
      [
        For a differential equation involving the functions $F_1$, $F_2$, #sym.dots, $F_n$, and
        the variable $t$, the _component graphs_ are the $n$ graphs
        of $(t, F_1 (t))$, $(t, F_2 (t))$, #sym.dots.

        The _phase plane_ or _phase space_ associated with the
        differential equation is the $n$-dimensional space with
        axes corresponding to the values of $F_1$, $F_2$, #sym.dots, $F_n$.
      ],
    ),
    equilibrium_solution: definition_env(
      title: "Equilibrium Solution",
      label: <def_equilibrium_solution>,
      [
        An _equilibrium solution_ to a
        differential equation or system of differential equations
        is a solution that is constant in the independent variable(s).
      ],
    ),
    equilibrium_classification_informal: definition_env(
      title: "Classification of Equilibria",
      label: <def_equilibrium_classification_informal>,
      [
        An equilibrium solution $f$ is called
        - _attracting_ if locally, solutions converge to $f$
        - _repelling_ if there is a fixed distance so that locally, solutions tend away from $f$ by that fixed distance
        - _stable_ if there is a fixed distance so that locally, solutions stay within that fixed distance of $f$
        - _unstable_ if $f$ is not stable
      ],
    ),
    equilibrium_classification_formal: definition_env(
      title: "Classification of Equilibria (Formal)",
      label: <def_equilibrium_classification_formal>,
      [
        An equilibrium solution $f$ is called
        - _attracting at time $t_0$_ if
          there exists $epsilon > 0$ such that for all solutions $g$ satisfying $abs(g(t_0) - f(t_0)) < epsilon$, we have $lim_(t -> infinity) f(t) = lim_(t -> infinity) g(t)$.
        - _repelling at time $t_0$_ if there exists $epsilon > 0$ and $delta > 0$ such that for all
          solutions $g$ that satisfy $0 < abs(g(t_0) - f(t_0)) < epsilon$ there exists $T in RR$ so that for all $t > T$ we have
          $abs(g(t) - f(t)) > delta$.
        - _stable at time $t_0$_ if for all $epsilon > 0$ there exists a $delta > 0$ such that for all solutions $g$ satisfying $abs(g(t_0) - f(t_0)) < delta$
          we have $abs(g(t) - f(t)) < epsilon$ for all $t > t_0$.
        - _unstable at time $t_0$_ if $f$ is not stable at time $t_0$.
        
        $f$ is called attracting/repelling/stable/unstable if it has the corresponding property for all $t$.
      ],
    ),
    phase_portrait: definition_env(
      title: "Phase Portrait",
      label: <def_phase_portrait>,
      [
        A _phase portrait_ or _phase diagram_ is the plot of a vector field in phase space where each vector rooted at $(x, y)$ is tangent to a solution curve passing through $(x, y)$ and its length is given by the speed of a solution passing through $(x, y)$.
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

