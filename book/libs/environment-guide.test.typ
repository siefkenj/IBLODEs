#import "environments.typ": *
#import "settings-question.typ": *
#import "settings-guide.typ": *
#import "environment-question.typ": *
#import "environment-guide.typ": *

#set page(paper: "us-letter")
#show: e.prepare(question)
#show: guide_template

= Tests for the guide functions

== Just the colored box

#annotation_box[A box without a title

  Lists should work:
  + Item 1
    + Item 2
      + Item 2a
      + Item 2b

  And bullet lists:
  - Item 1
    - Item 2
    - Item 2a
    - Item 2b
]

#annotation_box(title: [A title], [Some content with a title])

#annotation_box(title: [A title], color: red, [Some content with a title and a custom color])

// Internal functions
#{
  let nums = _generate_question_part_address(2, (1,))
  assert(nums == ("2.1",))
  let nums = _generate_question_part_address(2, (1, 2))
  assert(nums == ("2.1", "(b)"))
  let nums = _generate_question_part_address(2, (1, 2, 3))
  assert(nums == ("2.1", "(b)", "iii."))
}


#question(label: <first-one>)[
  #learning_objectives[Note this stuff!
    - Be vigilant
    - Be noble.

    When analyzing, remember:
    + Work hard.
    + Work smart on:
      + Paperwork
      + Finding your true passion and talking about it a long time.
  ]
  This is a question. It has some parts and sub parts.

  + Part 1.
    + Subpart A.
    + Subpart B.
  + Part 2.
    + And more
      + And more!
]

#question[
  #learning_objectives(([Do important stuff], [Be important]))
  #notes[Important notes that you should be aware of.
    - @the-part[] Make sure you know what you're doing.
  ]
  A second question!
  + #label_question_part(<the-part>) Do the work.
  + Then solve it.
  + What was significant about @the-part[]?
    #notes[Another note]
    + #label_question_part(<thinking>) Think more
    + Did your thinking in @thinking[] change your mind?
]

#pagebreak()
== guide_settings visibility fields (visual)


#{
  show: e.set_(guide_settings, active: false)
  question(label: <third>)[
    #learning_objectives[An objective that should be invisible because the guide is not active.]
    #notes[Notes that should be invisible because the guide is not active.]
    The guide is not active for this question, so no objectives should appear.
  ]
}

#{
  show: e.set_(guide_settings, learning_objectives_visible: false, notes_visible: true)
  question[
    #learning_objectives[This should be hidden because visibility is false.]
    #notes[This should be visible because visibility is true.]
    Notes visible but objectives not.
  ]
}
#{
  show: e.set_(guide_settings, learning_objectives_visible: true, notes_visible: false)
  question[
    #learning_objectives[This should be visible because visibility is true.]
    #notes[This should be hidden because visibility is false.]
    Objectives visible but notes not.
  ]
}

#pagebreak()
== Test some lessons

#lesson(title: "First lesson")[
  This is the first lesson
]

#question[some question]
#question[some question]

#lesson(title: "Second lesson")[
  This is the second lesson
]

#question[some question]
#question[some question]
