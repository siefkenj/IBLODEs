#let questions = (
  (
    statement: [Find the eigenvalues and solve $cases(x'_1=x_2, x'_2=-x_1)$.#v(.7em)],
    solution: [
      Eigenvalues: $plus.minus i$

      Solution: $arrow(x)= C_1 mat(cos(t); -sin(t)) + C_2 mat(sin(t); cos(t))$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.104]
  ),
  (
    statement: [
      Suppose that $arrow(x)' = A arrow(x)$, where $A$ is a 2 by 2 matrix with eigenvalues $2 plus.minus i$. Describe the behaviour.
    ],
    solution: [
      It has a spiral source.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.5.102]
  ),
  (
    statement: [Compute the eigenvalues and eigenvectors of 

    $A = mat(1,1;-1,0)$#v(.7em)
    Then solve the system $arrow(x)' = A arrow(x)$.],
    solution: [For $A = mat(1,1;-1,0)$:
    + The eigenvalues are: $(1 + i sqrt(3))/2,(1 - i sqrt(3))/2$.
      
      The eigenvectors are: $mat(-2; 1 - i sqrt(3)), mat(-2; 1 + i sqrt(3))$#v(.7em)
      
    + $arrow(x)' = C_1 e^(t/2) mat(-2 cos((t sqrt(3))/2); cos((t sqrt(3))/2) + sqrt(3) sin((t sqrt(3))/2)) + C_2 e^(t/2) mat(-2 sin((t sqrt(3))/2); sin((t sqrt(3))/2) - sqrt(3) cos((t sqrt(3))/2))$],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.102]
  )
)