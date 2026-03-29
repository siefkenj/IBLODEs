#import "environments.typ": *
#import "settings-question.typ": *
#import "environment-question.typ": *

#set page(paper: "us-letter")
#show: e.prepare(question)

= Tests for the question environment.

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
  This is a question. It has some parts and sub parts.

  + Part 1.
    + Subpart A.
    + Subpart B.
  + Part 2.
    + And more
      + And more!
]

#question[
  A second question!
  + #label_question_part(<the-part>) Do the work.
  + Then solve it.
  + What was significant about @the-part[]?
    + #label_question_part(<thinking>) Think more
    + Did your thinking in @thinking[] change your mind?
]

#question(label: <third>)[
  A third!
]

See @first-one and @third for the first and third questions, respectively. And see @the-part for the
first part of the second question.

#[
  == Question without start marker (used for slides)

  #show: e.set_(question_settings, include_start_marker: false)

  #question[
    This question doesn't have a start marker.
    + And it has parts.
  ]
]