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

/// Modified from https://github.com/typst/typst/issues/4035
/// Use with
/// ```typ
/// show ref: allow_missing_refs
/// ```
/// at the top of every file where missing refs should be allowed.
#let allow_missing_refs(it) = {
  if str(it.target) in all-bib-entries() or it.element != none {
    it
  } else {
    text(fill: red)[\<Target not found: #emph(str(it.target))\>]
  }
}

#show ref: allow_missing_refs
