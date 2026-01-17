#let questions = (
  (
    statement: [
      Find the complex conjugate and absolute value for:
      
      + $z=3+5i$
      + $z=8i$
      + $z=100$
    ],
    solution: [
      + $overline(z)=3-5i, |z|=sqrt(34)$
      + $overline(z)=-8i, |z|=8$
      + $overline(z)=100, |z|=100$
    ],
  ),
  (
    statement: [
      Find the value of $z_1z_2$ for:
      
      + $z_1=e^(5i), z_2=e^(-9i)$
      + $z_1=2e^(13i), z_2=3e^(2i)$
      + $z_1=5e^(100i), z_2=5e^(-100i)$
    ],
    solution: [
      + $z_1z_2=e^(-4i)$
      + $z_1z_2=6e^(15i)$
      + $z_1z_2=25$
    ],
  ),
  (
    statement: [
      Solve the following quadratic equations:
      
      + $3x^2+5x+100=0$
      + $x^2+x+10=0$
      + $9x^4+6x^2+1=0$
    ],
    solution: [
      + $x=-5/6 plus.minus (5i sqrt(47))/6$#v(.7em)
      + $x=-1/2 plus.minus (i sqrt(39))/2$#v(.7em)
      + $x= plus.minus i/(sqrt(3))$#v(.7em)
    ],
  ),
  (
    statement: [
      Find all eigenvalues and their corresponding eigenvectors of the following:
      
      + $M=mat(3, -1; 1, 4)$#v(.7em)
      + $M=mat(1, -5;3, 1)$#v(.7em)
      + $M=1/5 mat(1, -5;3, 1)$#v(.7em)
      + $M=mat(0, -1, 0; 0, 0, -1; -1, 0, 0)$
    ],
    solution: [
      + $lambda_1=1/2 (7+i sqrt(3)), lambda_2=1/2 (7-i sqrt(3))$#v(.7em)$arrow(v_1)=1/2 vec(-1+i sqrt(3), 2), arrow(v_2)=1/2 vec(-1-i sqrt(3), 2)$#v(.7em)
      + $lambda_1 = 1+i sqrt(15), lambda_2=1-i sqrt(15)$#v(.7em)$arrow(v_1)= vec(i sqrt(5/3), 1), arrow(v_2)= vec(-i sqrt(5/3), 1)$#v(.7em)
      + $lambda_1 = 1/5 (1+i sqrt(15)), lambda_2=1/5 (1-i sqrt(15))$#v(.7em)$arrow(v_1)= vec(i sqrt(5/3), 1), arrow(v_2)= vec(-i sqrt(5/3), 1)$#v(.7em)
      + $lambda_1 = -1, lambda_2=1/2 (1+i sqrt(3)), lambda_3=1/2 (1-i sqrt(3))$#v(.7em)$arrow(v_1)=vec(1, 1, 1), arrow(v_2)=1/2 vec(-1-i sqrt(3), -1+i sqrt(3), 2), arrow(v_3)=1/2 vec(-1+i sqrt(3), -1-i sqrt(3), 2)$
    ],
  )
)