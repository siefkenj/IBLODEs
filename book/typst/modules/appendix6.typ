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





// Below is a compilation of the modules that are most relevant to the material in this book.

// == Module 6: Subspaces & Bases

// Lines or planes through the origin can be written as spans
// of their direction vectors. However, a line or plane that doesn't
// pass through the origin cannot be written as a span—--it must
// be expressed as a _translated_ span.

// // #align(center)[
// //   // The following is a placeholder for the TikZ diagram.
// //   // Typst does not support TikZ directly. You may use an image or Typst's own drawing primitives.
// //   _[Diagram: span and translated span. Replace with Typst drawing or image as needed.]_
// // ]
// XXX ADD DIAGRAM

// There's something special about sets that can be expressed as 
// (untranslated) spans. In particular, since a linear combination
// of linear combinations is still a linear combination, a span
// is _closed_ with respect to linear combinations. That is, 
// by taking linear combinations of vectors in a span, you cannot
// escape the span. In general, sets that have this property are called
// _subspaces_.

// #show_def("subspace")

// In the definition of a subspace, property (i) is called
// being _closed with respect to vector addition_ and
// property (ii) is called being _closed with respect to
// scalar multiplication_.

// Subspaces generalize the idea of _flat spaces through the origin_. They include 
// lines, planes, volumes and more.

// #example(
//   prompt: 
//   [ Let $cal(V) subset.eq RR^2$ be the complete solution to 
//   $x + 2 y = 0$. Show that $cal(V)$ is a subspace.]
//   ,
//   [
//   Let $arrow(u) = mat(u_1; u_2)$ and 
//   $arrow(v) = mat(v_1; v_2)$ be in $cal(V)$, 
//   and let $k$ be a scalar.

//   By definition, we have 
//   $ u_1 + 2 u_2 & = 0 \
//     v_1 + 2 v_2 & = 0 $
  
//   We will show that $cal(V)$ is nonempty and that
//     (i) $arrow(u) + arrow(v) in cal(V)$; and
//     (ii) $k arrow(u) in cal(V)$.

//   First we will show (i).
//   Observe that
//   $
//     arrow(u) + arrow(v) = mat(u_1 + v_1; u_2 + v_2)
//   $
//   and the coordinates of $arrow(u) + arrow(v)$ satisfy
//   $
//     (u_1 + v_1) + 2 (u_2 + v_2) =
//     (u_1 + 2 u_2) + (v_1 + 2 v_2) =
//     0 + 0 = 0
//   $
//   Since the coordinates of $arrow(u) + arrow(v)$ satisfy the equation $x + 2 y = 0$, 
//   we have shown that $arrow(u) + arrow(v) in cal(V)$.

//   Next we will show (ii).
//   Observe that
//   $
//     k arrow(u) = mat(k u_1; k u_2)
//   $
//   and the coordinates of $k arrow(u)$ satisfy
//   $
//     (k u_1) + 2 (k u_2) = 
//     k (u_1 + 2 u_2) =
//     k 0 = 0
//   $
//   And so, we have shown that $k arrow(u) in cal(V)$.

//   Finally, since $arrow(0) = mat(0; 0)$ satisfies $x + 2 y = 0$, 
//   we conclude that $arrow(0) in cal(V)$
//   and so $cal(V)$ is non-empty.

//   Thus, by the definition, we have shown that $cal(V)$ is a subspace.
//   ]
//   )

// #example(
//   prompt: [
//   Let $cal(W) subset.eq RR^2$ be the line expressed in vector form
//   as 
//   $
//     arrow(x) = t mat(1; 2) + mat(1; 1)
//   $
//   Determine whether $cal(W)$ is a subspace.],
//   [
//   $cal(W)$ is *not* a subspace. To see this, notice that $arrow(v) = mat(1; 1) in cal(W)$,
//   but $0 arrow(v) = arrow(0) in.not cal(W)$. Therefore, $cal(W)$ is not closed under scalar multiplication
//   and so it cannot be a subspace.
//   ]
// )

// As mentioned earlier, subspaces and spans are deeply connected.
// This connection is given by the following theorem.

// #theorem(
// title: [Subspace-Span],
// [
//   Every subspace is a span and every span is a subspace. More precisely,
//   $cal(V) subset.eq RR^n$ is a subspace if and only if $cal(V) =
//   "Span" cal(X)$ for some set $cal(X)$.
// ]
// )

// // #proof(
// //   [
// //   We will start by showing every span is a subspace. Fix $cal(X) subseteq RR^n$
// //   and let
// //   $cal(V) = Span cal(X)$. First note that if $cal(X) ne Set{}$, then $cal(V)$
// //   is non-empty because $cal(X) subseteq cal(V)$ and if $cal(X) = Set{}$, then $cal(V) = Set{arrow(0)}$,
// //   and so is still non-empty.

// //   Fix $arrow(v), arrow(u) in cal(V)$. By definition there are $arrow(x)_1, arrow(x)_2, ..., arrow(y)_1, arrow(y)_2, ... in cal(X)$ 
// //   and scalars $alpha_1, alpha_2, ..., beta_1, beta_2, ...$ so that
// //   $
// //     arrow(v) = sum alpha_i arrow(x)_i
// //     arrow(u) = sum beta_i arrow(y)_i
// //   $

// //   To verify property (i), observe that
// //   $
// //     arrow(u) + arrow(v) = sum alpha_i arrow(x)_i + sum beta_i arrow(y)_i
// //   $
// //   is also a linear combination of vectors in $cal(X)$ (because all $arrow(x)_i$ and $arrow(y)_i$
// //   are in $cal(X)$), and so $arrow(u) + arrow(v) in Span cal(X) = cal(V)$.

// //   To verify property (ii), observe that for any scalar $alpha$, 
// //   $
// //     alpha arrow(v) = alpha sum alpha_i arrow(x)_i = sum (alpha alpha_i) arrow(x)_i in
// //     Span cal(X) = cal(V)
// //   $
// //   Since $cal(V)$ is non-empty and satisfies both properties (i) and (ii), it is a subspace.

// //   Now we will prove that every subspace is a span. Let $cal(V)$ be a subspace
// //   and consider $cal(V)' = Span cal(V)$. Since taking a span may only enlarge a set, we know
// //   $cal(V) subseteq cal(V)'$. If we establish that $cal(V)' subseteq cal(V)$,
// //   then $cal(V) = cal(V)' = Span cal(V)$, which would complete the proof.

// //   Fix $arrow(x) in cal(V)'$. By definition, there are $arrow(v)_1, arrow(v)_2, ..., arrow(v)_n in cal(V)$ and scalars
// //   $alpha_1, alpha_2, ..., alpha_n$ so that
// //   $
// //     arrow(x) = sum alpha_i arrow(v)_i
// //   $
// //   Observe that 
// //   $alpha_i arrow(v)_i in cal(V)$ for all $i$, since $cal(V)$ is closed under scalar
// //   multiplication. It follows that $alpha_1 arrow(v)_1 + alpha_2 arrow(v)_2 in cal(V)$,
// //   because $cal(V)$ is closed under sums. Continuing, 
// //   $(alpha_1 arrow(v)_1 + alpha_2 arrow(v)_2) + alpha_3 arrow(v)_3 in cal(V)$ because
// //   $cal(V)$ is closed under sums. Applying the principle of finite induction, we see
// //   $
// //     arrow(x) = sum alpha_i arrow(v)_i
// //     = (((alpha_1 arrow(v)_1 + alpha_2 arrow(v)_2)
// //     + alpha_3 arrow(v)_3) + ... + alpha_{n-1} arrow(v)_{n-1})
// //     + alpha_n arrow(v)_n in cal(V)
// //   $
// //   Thus $cal(V)' subseteq cal(V)$, which completes the proof.
// //   ]
// // )

// The previous theorem is saying that spans and subspaces are two ways of talking about the same
// thing. Spans provide a _constructive_ definition of lines/planes/volumes/etc. through the origin. That is,
// when you describe a line/plane/etc. through the origin as a span, you're saying "this is a line/plane/etc. through the origin
// because every point in it is a linear combination of _these specific vectors_". In contrast, subspaces provide a _categorical_
// definition of lines/planes/etc. through the origin. 
// When you describe a line/plane/etc. through the origin as a subspace, 
// you're saying "this is a line/plane/etc. through the origin because these _properties_ are satisfied".
// // Categorical definitions are useful when working with objects where it's hard to pin down exactly what the elements inside are.

// *Takeaway:*
//   Spans and subspaces are two different ways of talking about the same objects: points/lines/planes/etc. through the origin.


// === Special Subspaces

// When thinking about $RR^n$, there are two special subspaces that are always available. The first is $RR^n$ itself.
// $RR^n$ is obviously non-empty, and linear combinations of vectors in $RR^n$ remain in $RR^n$. The second is
// the _trivial subspace_, ${arrow(0)}$.

// #show_def("trivial_subspace")

// #theorem(
//   title: ["Trivial Set"],
// [
//   The trivial subspace is a subspace.
// ])
// // #proof(
// //   First note that $Set{arrow(0)}$ is non-empty since $arrow(0) in Set{arrow(0)}$. Now, since
// //   $arrow(0)$ is the only vector in $Set{arrow(0)}$, properties (i) and (ii) follow quickly:
// //   $
// //     arrow(0) + arrow(0) = arrow(0) in Set{arrow(0)}
// //   $
// //   and
// //   $
// //     alpha arrow(0) = arrow(0) in Set{arrow(0)}
// //   $
// // )

// === Bases

// Let $arrow(d) = mat(2; 1)$ and consider $ell = "span"{arrow(d)}$.

// // #align(center)[
// //   // The following is a placeholder for the TikZ diagram.
// //   // Typst does not support TikZ directly. You may use an image or Typst's own drawing primitives.
// //   _[Diagram: line through origin and direction vector. Replace with Typst drawing or image as needed.]_
// // ]
// // 
// XXX ADD DIAGRAM

// We know that $ell$ is a subspace, and we defined $ell$ as the span of ${arrow(d)}$,
// but we didn't have to define $ell$ that way. We could have, for instance, defined $ell = "span"{arrow(d), -2 arrow(d), 1/2 arrow(d)}$. However,
// $"span"{arrow(d)}$ is a simpler way to describe $ell$ than $"span"{arrow(d), -2 arrow(d), 1/2 arrow(d)}$.
// This property is general: the simplest descriptions of a line involve the span of only one vector.

// Analogously, let $cal(P) = "span"{arrow(d)_1, arrow(d)_2}$ be the plane
// through the origin with direction vectors $arrow(d)_1$ and $arrow(d)_2$. There
// are many ways to write $cal(P)$ as a span, but the simplest ones
// involve exactly two vectors. The idea of a *basis* comes
// from trying to find the simplest description of a subspace.

// #show_def("basis")

// In short, a basis for a subspace is a linearly independent set that spans that
// subspace.
 
// #example(
//   prompt: [
//   // EXLINEBASIS
//   Let $ell = "span"{mat(1; 2), mat(-2; -4), mat(1/2; 1)}$. Find
//   two different bases for $ell$.],
//   [
//   We are looking for a set of linearly independent vectors that spans $ell$.
//   Notice that $mat(1; 2) = -1/2 mat(-2; -4) = 2 mat(1/2; 1)$.
//   Therefore,
//   $
//     "span"{mat(1; 2)} =
//     "span"{mat(-2; -4)} =
//     "span"{mat(1/2; 1)} =
//     "span"{mat(1; 2), mat(-2; -4), mat(1/2; 1)} =
//     ell
//   $
//   Because ${mat(1; 2)}$ is linearly independent and spans $ell$,
//   we have that ${mat(1; 2)}$ is a basis for $ell$.

//   Similarly, ${mat(1/2; 1)}$ is another basis for $ell$.
//   ]
// )

// Unpacking the definition of basis a bit more, we can see that 
// a basis for a subspace
// is a set of vectors
// that is _just the right size_ to describe everything in the subspace.
// It's not too big—because it is linearly independent, there are no
// redundancies. It's not too small—because we require it to span the subspace. #footnote([If you're into British fairy tales, you might call a basis a _Goldilocks set_]).

// There are several facts everyone should know about bases:
// + Bases are not unique. Every subspace (except the trivial subspace)
//   has multiple bases.
// + Given a basis for a subspace, every vector in the subspace can be written
//   as a _unique_ linear combination of vectors in that basis.
// + Any two bases for the same subspace have the same number of elements.

// You can prove the first fact by observing that if $cal(B) = {arrow(b)_1, arrow(b)_2, ...}$ is a basis
// with at least one element#footnote([The empty set is a basis for the trivial subspace.])
// then ${2 arrow(b)_1, 2 arrow(b)_2, ...}$ is a different basis. The second fact is a consequence of all bases 
// being linearly independent. The third fact is less obvious and takes some legwork to prove, so we will accept it
// as is. 
 
// === Dimension

// Let $cal(V)$ be a subspace. Though there are many bases for $cal(V)$, they all
// have the same number of vectors in them. And, this number says something fundamental about $cal(V)$:
// it tells us the maximum number of linearly independent vectors that can simultaneously exist in $cal(V)$.
// We call this number the *dimension* of $cal(V)$.

// #show_def("dimension")

// This definition agrees with our intuition about lines and planes: the dimension of a line through $arrow(0)$ is $1$, and
// the dimension of a plane through $arrow(0)$ is $2$. It even tells us the dimension of the single point ${arrow(0)}$
// is $0$
// // The dimension of a line, plane, or point not through the origin is defined to be the dimension of the subspace obtained when it is translated to the origin.

// #example(
//   prompt:[
//   Find the dimension of $RR^2$.],
//   [
//   Since ${hat(x), hat(y)}$ is a basis for $RR^2$, we know $RR^2$ is
//   two dimensional.
//   ]
// )

// #example(
//   prompt:[
//   Let $ell = "span"{mat(1; 2), mat(-2; -4), mat(1/2; 1)}$.
//   Find the dimension of the subspace $ell$.],
//   [
//   This is the same subspace from the earlier example where we found
//   ${mat(1; 2)}$ and ${mat(1/2; 1)}$
//   were bases for $ell$. Both these bases contain one element, and so
//   $ell$ is a one dimensional subspace.
//   ]
// )

// #example(
//   prompt:[
//   Let $A = {(x_1, x_2, x_3, x_4)$ given $x_1 + 2 x_2 - x_3 = 0$ and $x_1 + 6 x_4 = 0}$. Find a basis for and the dimension
//   of $A$.],
//   [
//   $A$ is the complete solution to the system
//   $
//     x_1 + 2 x_2 - x_3 &= 0 \ 
//     x_1 + 6 x_4 &= 0
//   $
//   which can be expressed in vector form as
//   $
//     mat(x_1; x_2; x_3; x_4) = t mat(0; 1/2; 1; 0) + s mat(-6; 3; 0; 1)
//   $
//   Therefore $A = "span"{mat(0; 1/2; 1; 0), mat(-6; 3; 0; 1)}$. Since ${mat(0; 1/2; 1; 0), mat(-6; 3; 0; 1)}$
//   is a linearly independent spanning set with two elements, $A$ is two dimensional.
//   ]
// )
 
// Like $RR^2$ and $RR^3$, whenever we discuss $RR^n$, we always have a standard basis that comes
// along for the ride.

// #show_def("standard_basis")

// *Note:* the notation $arrow(e)_i$ is context specific. If we say $arrow(e)_i in RR^2$,
// then $arrow(e)_i$ must have exactly two coordinates. If we say $arrow(e)_i in RR^(45)$,
// then $arrow(e)_i$ must have $45$ coordinates.



// == Module 15: Eigenvalues & Eigenvectors


// == Module 16: Diagonalization


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
