#let cc_by_sa = box(width: 3em, place(dy: -.85em, image("../images/by-sa.svg", height: 1em)))
#let copyright = [_#sym.copyright Galvão-Sousa & Siefken, 2025 #cc_by_sa _]

= About this Book
== For the student

This book is your introductory guide to differential equations. It is divided into modules, and each
module is further divided into exposition, practice problems, and core exercises.

To optimally learn from this text, you should:

- Start each module by reading through the exposition to get familiar with the main ideas and
  terminology.
- Work through the core exercises to develop an understanding and intuition behind the main ideas
  and their subtleties.
- Re-read the exposition and identify which concepts each core exercise connects with.
- Work through the practice problems. These will serve as a check on whether you've understood the
  main ideas well enough to apply them.

*Core exercises.*
Most (but not all) core exercises will be worked through during lecture time, and after each of the
core exercises there is space provided for you to work. The point of the core exercises is to
develop the main ideas of differential equations by exploring examples.

*Contributing to the book.* Did you find an error? Do you have a better way to explain a
differential equations concept? Please, contribute to this book! This book is open-source, and we
welcome contributions. Contributions/Issues should be raised on GitHub at
https://github.com/siefkenj/IBLODEs

== For the instructor

This book was designed for a one-semester introductory differential equations course in the second
year with a focus on modelling and simulation (MAT244 at the University of Toronto). It has not been
designed for a proofs-based course nor a "learn 5 methods to solve specific
ODEs"-course.

The book leans heavily on simulation via Euler's method. It's main thrust is the analysis of the
equilibria of non-linear first-order systems of differential equations via studying linear/affine
approximations to said systems. These tools are then applied to higher-order differential equations.

Theorems about existence and uniqueness aren't emphasized until the end of the text. Since most
ordinary differential equations have solutions and cases of non-uniqueness are often contrived, this
text opts to motivate the question of existence and uniqueness via an introduction to boundary value
problems. (But, instead of answering the very hard question of conditions for the existence and
uniqueness of solutions to boundary value problems, we state the standard theorems for initial value problems.)

This book is grouped into modules. Each module contains exposition about a subject, practice
problems (for students to work on by themselves), and core exercises (for students to work on with
your guidance). Modules group related concepts and have been designed to facilitate learning rather
than to serve as a reference.

*Using the book.* This book has been designed for use in large active-learning classrooms driven by
a think, pair-share/small-group-discussion format. Specifically, the core exercises (these are the
problems which aren’t labeled “Practice Problems” and for which space is provided to write answers)
are designed for use during class time.

A typical class day looks like:

+ *Student pre-reading.* Before class, students will read through the relevant module.

+ *Introduction by instructor.* This may involve giving a definition, a broader context for the
  day’s topics, or answering questions.

+ *Students work on problems.* Students work individually or in pairs/small groups on the prescribed
  core exercise. During this time the instructor moves around the room addressing questions that
  students may have and giving one-on-one coaching.

+ *Instructor intervention.* When most students have successfully solved the problem, the instructor
  refocuses the class by providing an explanation or soliciting explanations from students. This is
  also time for the instructor to ensure that everyone has understood the main point of the exercise
  (since it is sometimes easy to miss the point!).

  If students are having trouble, the instructor can give hints and additional guidance to ensure
  students’ struggle is productive.

+ *Repeat step 3.*

Using this format, students are thinking (and happily so) most of the class. Further, after
struggling with a question, students are especially primed to hear the insights of the instructor.

*Conceptual lean.* The _core exercises_ are geared towards concepts. Algorithms, like Euler's
method, are developed by the students themselves before formalizing. Phase portraits and analysis of
equilibrium solutions are the backbone of the text, and higher-order differential equations are
reduced to systems of first-order equations (they don't receive special treatment).

The traditional "solving" techniques of separation of variables, integrating factors, etc. can be
found in the appendices. We feel that, aside from separation of variables, these techniques do not
pass the time/value threshold for a modern differential equations course, but if your curriculum
requires such topics, integrate the applicable appendices as needed.

*How to prepare.* Running an active-learning classroom is less scripted than lecturing. The largest
challenges are: (i) understanding where students are at, (ii) figuring out what to do given the
current understanding of the students, and (iii) timing.

To prepare for a class day, you should:

+ *Strategize about learning objectives.* Figure out what the point of the day’s lesson is and
  brainstorm some examples that would illustrate that point.

+ *Work through the core exercises.*

+ *Reflect.* Reflect on how each core exercise addresses the day’s goals. Compare with the examples
  you brainstormed and prepare follow-up questions that you can use in class to test for
  understanding.

+ *Schedule.* Write timestamps next to each core exercise indicating at what minute you hope to
  start each exercise. Give more time for the exercises that you judge as foundational, and be
  prepared to triage. It’s appropriate to leave exercises or parts of exercises for homework, but
  change the order of exercises at your peril—they really do build on each other.

A typical 50 minute class is enough to get through 2–3 core exercises (depending on the difficulty),
and class observations show that class time is split 50/50 between students working and instructor
explanations.

Please contact the author with feedback and suggestions, or if you are decide to use the book in a
course you are teaching. You can also easily submit feedback about an error or typo by creating a
_GitHub Issue_ at https://github.com/albertlind/IBLODEs/issues

== License
_Differential Equations_ by Bernardo Galvão-Sousa & Jason Siefken is licensed under a #link(
  "http://creativecommons.org/licenses/by-sa/4.0/",
)[Creative Commons Attribution-ShareAlike 4.0 International License]. You are free to download, use,
print, and even sell this work as you wish to. You can also modify the text as much as you like
(create a custom edition for your students, for example), as long as you attribute the parts of the
text you use to the author.

If you are interested in using parts of the book combined with another text with a similar but
different license (GFDL, for example), email the authors to get permission to modify the license.

*Incorporated Content.* This book incorporates some exposition and exercises from _Notes on Diffy
  Qs_ by Jiří Lebl following a Creative Commons Attribution-ShareAlike license. As well, passages
were incorporated from the creative-commons licensed book _Linear Algebra_ by Jason Siefken.

== Contributors

This book is a collaborative effort. The following people have contributed to its creation:
#quote(block: true)[
  Jake Zimmermann
]
