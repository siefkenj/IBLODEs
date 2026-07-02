#import "../libs/lib.typ": *
// Make a "How to use this guide" section
//  - State that blue box learning objectives are presented in a way that will be applicable to students. However, there are many "hidden" objectives givin in the notes boxes. (Because some exercises are not standalone exercises, the full objectives don't make sense to state in many cases.)
// Include a schedule for the appendices? Including the calculation methods that are not in the body of the text?

= What is in this guide?

This guide provides learning objectives and notes for running a 12 week "Modelling with Differential
Equations" course.

The guide omits the text of each module, but it includes the core exercises annotated with _learning
objectives_, _solutions_ and instructional _notes_. Additionally, the guide splits the core
exercises into weeks (assumed 3 hours of lecture per week) via _Lessons_.

== How to use this guide

#let annotate(it) = text(size: .85em, fill: blue, it)

To prepare for a week of class using this guide and the textbook:
+ #annotate[(Guide)] Read the week's _Lesson_ to get background on the learning objectives and
  design decisions of the core exercises.
+ #annotate[(Textbook)] Read the body text of the _Module(s)_ included in the lesson.
+ #annotate[(Textbook)] Work through the _core exercises_ included in the lesson. Prepare for these
  exercises as you would prepare for a typical active-learning class. E.g., make notes on:
  - What you think the objectives of the exercise are, and which parts of the exercise support those
    objectives.
  - Which parts of the exercises will students get stuck on, and what hints could you give to get
    students unstuck.
  - What would an appropriate conclusion to the exercise be? How would you summarize the punchline?
+ #annotate[(Guide)] Read through the provided _learning objectives_ and _notes_ and see how similar
  they are to your initial assessments.

=== Learning Objectives

Each question has content objectives and pedagogical objectives. The content objectives are written
such that they could be shared with students; these content objectives are what appear in the
learning objective boxes. An example of a content objective is "Apply linearization to classify the
stability of an equilibrium point."

Pedagogical objectives are explained in the notes boxes. These are objectives like "Become familiar
with a specific system of ODEs that will be used in later exercises."

=== Notes

The notes boxes outline the intent of each exercise along with pedagogical objectives and specific
hints for instructors about what students may do/how they tend to approach different parts of the
exercise. These notes were developed based on comments from several instructors who have taught
using these materials.

=== Solutions

Solutions, written using techniques from the modules, are provided as a reference. Solutions are
often just answers with minimal explanation.

== Technology Notes

This text relies heavily on numerical simulation (using spreadsheets). Additionally, the core
exercises rely on Desmos applets for exploring and interacting with phase portraits and slope
fields.

=== Spreadsheets

This book uses spreadsheets to simulate solutions to differential equations. Some instructors may
wish to use a different programming language (Python, MatLab, etc.), but we argue that spreadsheets
have several advantages over "real" programming languages (especially for students without
significant programming experience).

#[
  #set list(marker: text([*$+$*], fill: green.darken(30%), size: .8em))
  - The tabular nature of the algorithm for Euler's method is naturally reflected in a spreadsheet.
  - Students have familiarity with spreadsheets (though they may not be proficient with them) and
    are not intimidated by them.
  - Answering questions like "when does a solution achieve a maximum" can be done visually/with
    scrolling in a spreadsheet, rather than requiring students to write code to find the time when a
    maximum occurs.
  - Minimal syntax overhead and a point-and-click interface for many operations.
  - Spreadsheets will likely be applicable to students' lives beyond this course.
]

However, there are some drawbacks to using spreadsheets.
#[
  #set list(marker: text([*$-$*], fill: red.darken(30%), size: .8em))
  - Plotting solutions with different time steps is difficult. As a workaround, we encourage
    students to copy-and-paste their data into Desmos and use Desmos's plotting functionality.

  - Advanced algorithms like Improved Euler's method and Runge-Kutta are difficult to correctly
    implement in a spreadsheet. (This text only uses Euler's method, so this is not a problem for
    the core exercises.)

  - Error messages relating to `NaN` or `#DIV/0!` can be confusing to students, and when simulating
    exponential solutions, getting out-of-bounds numbers is common.
]


=== Desmos Applets

Desmos applets are provided as-needed during the core exercises. The most relevant applets are:

- https://www.desmos.com/calculator/ghavqzqqjn A slope-field plotter.
- https://www.desmos.com/calculator/e3vrgrvmqr A slope-field plotter with _Euler's method and
  Runge-Kutta_ built in.
- https://www.desmos.com/calculator/h3wtwjghv0 A phase-portrait plotter for $2 times 2$ systems.
- https://www.desmos.com/calculator/fvqxqp6eds A phase-portrait plotter for $2 times 2$ systems with
  _Euler's method and Runge-Kutta_ built in.

Sometimes an exercise will link to one of these Desmos applets with the axes pre-scaled to make
sense for the question.

We recommend not giving out the links with built-in simulation methods until later in the course
when students have demonstrated that they can simulate on their own when asked.

= Example Schedule

The following schedule is based on a 12-week semester that meets 3 hours per week. Lectures are
accompanied by homeworks, exams, and tutorials.

For a course that also includes solution techniques, a suggested schedule for the appendices is
included.


+ @lesson:1

@lesson:1

#set text(size: .85em)
#table(
  columns: (auto, 1fr, auto, auto),
  stroke: 0.5pt,
  align: (center, left, center, left),
  table.header(strong[Week], strong[Topic], strong[Modules], strong[Events]),
  [1],
  [Population Models and Differential Equations],
  [1],
  [],

  [2],
  [Euler's Method and Numerical Approximations],
  [2],
  [Tutorials begin],

  table.cell(colspan: 4)[
    _Euler's Method Group Quiz_
  ],
  [3],
  [Lotka–Volterra Models; Multi-dimensional Euler's Method],
  [3],
  [Euler's Method Group Quiz (tutorial)],

  [4],
  [Phase Space and Equilibrium Solutions],
  [3 & 4],
  [Homework Quiz (tutorial)],

  [5],
  [Phase Portraits and their Applications],
  [5],
  [],

  [6],
  [Matrix Systems with Constant Coefficients (Real Solutions)],
  [6],
  [Homework Quiz (tutorial)],

  [7],
  [Eigen Solutions],
  [6],
  [],

  table.cell(colspan: 4)[
    _Midterm (two-stage test with group modelling component)_
  ],

  [8],
  [Affine Models],
  [7],
  [],

  [9],
  [Complex Eigenvalues; Introduction to Linearization],
  [8],
  [Homework Quiz (tutorial)],

  [10],
  [Linearization],
  [9],
  [],

  [11],
  [Higher-order ODEs; Boundary Value Problems],
  [10 & 11],
  [Homework Quiz (tutorial)],

  [12],
  [Famous ODEs],
  [App. A],
  [Makeup Quiz (tutorial)],

  table.cell(colspan: 4)[
    _Modelling Group Quiz_
  ],
  table.cell(colspan: 4)[
    _Individual Final Exam_
  ],
)

== Assessments

// two-stage tests

// Euler modelling quiz early on
