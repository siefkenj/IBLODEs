#import "@preview/citegeist:0.2.0": load-bibliography

#let all-bib-entries() = {
  let bib-file = {
    let all-bib = query(bibliography)
    if all-bib.len() > 0 {
      all-bib.at(0).sources.at(0)
    } else {
      none
    }
  }
  if bib-file == none {
    (:)
  } else {
    load-bibliography(read(bib-file))
  }
}

#let STYLED_FUNC = (text(fill: red, "xxx")).func()

/// Modified from https://github.com/typst/typst/issues/4035
/// Use with
/// ```typ
/// show ref: allow_missing_refs
/// ```
/// at the top of every file where missing refs should be allowed.
#let allow_missing_refs(it) = {
  let matches = query(it.target)
  // XXX: This doesn't work right now. Maybe it can be fixed some how...
  // if matches.len() == 1 and matches.at(0).func() == STYLED_FUNC {
  //   // If the reference is to a styled element, it probably means we forgot to call `show: e.prepare()` in the module file.
  //   return text(fill: red)[\<ERROR cannot reference styled element #str(it.target)\> did you forget
  //     `e.prepare()`?]
  // }
  if str(it.target) in all-bib-entries() or it.element != none {
    it
  } else {
    text(fill: red)[\<NOT FOUND #emph(str(it.target))\>]
  }
}

// #show ref: allow_missing_refs
