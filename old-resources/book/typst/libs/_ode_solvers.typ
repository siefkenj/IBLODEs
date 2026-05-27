#import "@preview/cetz:0.4.0"

/// Cap the length of a vector to 1.
#let scale_cap(v) = {
  let len = calc.sqrt(v.at(0) * v.at(0) + v.at(1) * v.at(1) + 0.01)
  let scale = calc.atan(len).rad() / len / calc.pi
  (scale * v.at(0), scale * v.at(1))
}

/// Produce a linearly spaced array of numbers between `start` and `stop` with `step` increments.
#let linspace(start, stop, step) = {
  let len = calc.ceil((stop - start) / step)
  range(len).map(i => start + i * step)
}

/// Draw a vector from point `p` to point `p + v` with an arrowhead.
/// This returns an object that should be placed as a child of a `cetz.canvas`.
#let draw_vec(p, v, color: black, head_scale: 0.2, head_slant: 0.327, head_width: 0.615, head_length: 1) = {
  import cetz.draw: *
  let (dx, dy) = v
  let (px, py) = p
  let len = calc.sqrt(dx * dx + dy * dy) + 0.01
  let scale = calc.atan(len).rad() * head_scale
  let (nx, ny) = (dx / len, dy / len)
  let (dx_ortho, dy_ortho) = (-ny, nx)

  let arrow = (
    (0, 0),
    (-head_slant * nx + head_width * dx_ortho, -head_slant * ny + head_width * dy_ortho),
    (head_length * nx, head_length * ny),
    (-head_slant * nx - head_width * dx_ortho, -head_slant * ny - head_width * dy_ortho),
    (0, 0),
  ).map(p => (px + dx + scale * p.at(0), py + dy + scale * p.at(1)))

  line(..arrow, stroke: none, fill: color)
  //line(p, (px + dx, py + dy), stroke: color + scale*7pt)
  line(p, (px + dx, py + dy), stroke: color + .5pt)
}

/// Perform a single step of the Euler method for solving a 2D IVP.
#let step_euler(f, v, Delta) = {
  let (x_0, y_0) = v
  let (dx, dy) = f(x_0, y_0)
  (x_0 + Delta * dx, y_0 + Delta * dy)
}

/// Perform a single step of the improved Euler method for solving a 2D IVP.
#let step_improved_euler(f, v, Delta) = {
  let (x_0, y_0) = v
  let (dx, dy) = f(x_0, y_0)
  let v_1 = (x_0 + Delta * dx, y_0 + Delta * dy)
  let (dx_1, dy_1) = f(v_1.at(0), v_1.at(1))
  (x_0 + Delta * (dx + dx_1) / 2, y_0 + Delta * (dy + dy_1) / 2)
}

/// Perform a single step of the Runge-Kutta 4 method for solving a 2D IVP.
#let step_rk4(f, v, Delta) = {
  let (x_0, y_0) = v
  let (dx_1, dy_1) = f(x_0, y_0)
  let (dx_2, dy_2) = f(x_0 + Delta * dx_1 / 2, y_0 + Delta * dy_1 / 2)
  let (dx_3, dy_3) = f(x_0 + Delta * dx_2 / 2, y_0 + Delta * dy_2 / 2)
  let (dx_4, dy_4) = f(x_0 + Delta * dx_3, y_0 + Delta * dy_3)
  (x_0 + Delta * (dx_1 + 2 * dx_2 + 2 * dx_3 + dx_4) / 6, y_0 + Delta * (dy_1 + 2 * dy_2 + 2 * dy_3 + dy_4) / 6)
}

/// Solve a 2D IVP using the given method.
/// - `f` is a function that accepts `(x,y)` and returns `(dx,dy)`.
/// - `v_0` is the initial value of `(x,y)`.
/// - `steps` is the number of steps to take.
/// - `Delta` is the step size.
#let solve_2d_ivp(f, v_0, steps, Delta: 0.1, method: "euler") = {
  let step = if method == "euler" {
    step_euler
  } else if method == "improved_euler" {
    step_improved_euler
  } else if method == "rk4" {
    step_rk4
  } else {
    assert(false, message: "Unknown method: \"" + str(method) + "\"")
  }

  let v = v_0
  let res = (v,)
  for i in range(steps) {
    v = step(f, v, Delta)
    res.push(v)
  }

  res
}

/// Solve a 1d IVP using the given method.
/// - `f` is a function that accepts `(x, y)` and returns `(dy)`.
/// - `v_0` is the initial value of `(x, y)`.
/// - `steps` is the number of steps to take.
/// - `Delta` is the step size.
#let solve_1d_ivp(f, v_0, steps, Delta: 0.1, method: "euler") = {
  let step = if method == "euler" {
    step_euler
  } else if method == "improved_euler" {
    step_improved_euler
  } else if method == "rk4" {
    step_rk4
  } else {
    assert(false, message: "Unknown method: \"" + str(method) + "\"")
  }

  // We use the 2d solver to solve the 1d case.
  let _f = (x, y) => (1, f(x, y))

  let v = v_0
  let res = (v,)
  for i in range(steps) {
    v = step(_f, v, Delta)
    res.push(v)
  }

  res
}