// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_appendix, simple_table
#let (sans, serif, module, definition, example, theorem) = workbook

#label_appendix(<app:linear_algebra>)

You can find a comprehensive review of linear algebra the book _Linear Algebra_ by Jason Siefken. A
free copy is accessible at
#align(center, link("https://siefkenj.github.io/IBLLinearAlgebra"))
In particular, it is suggested that you review Module 6 on Subspaces & Bases, Module 15 on
Eigenvalues and Eigenvectors, and Module 16 on Diagonalization.

== Complex Row-Reduction

One topic that may not have been covered in your linear algebra course is finding the null space of
a matrix with complex entries. The process is the same as for a matrix with real entries: row reduce
to find the solution to $A arrow(x)=arrow(0)$. However, your eyes may deceive you. Consider the
matrix
$
  M = mat(1, i; 1+i, -1+i).
$
The columns of $M$ are linearly _dependent_, even if they don't appear to be. You can verify by
subtracting $(1+i) dot "row"_1$ from $"row"_2$ to arrive at the matrix $mat(1, i; 0, 0)$.

The moral of the story is, when dealing with matrices with complex entries, follow the algorithms
and you won't be lead astray.
