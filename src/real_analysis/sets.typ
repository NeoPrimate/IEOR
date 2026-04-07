#set math.equation(numbering: "(1)")
#show math.equation: it => {
  if it.block and not it.has("label") and it.numbering != none [
    #counter(math.equation).update(v => v - 1)
    #math.equation(it.body, block: true, numbering: none)
  ] else {
    it
  }
}

*Definition*: Set

A set is a collection of objects called elements or numbers

*Definition*: Empty Set $emptyset$

Set with no elements

Notation

- $a in S$: a is an element of S
- $a in.not S$: a is not an element of S
- $forall$: for all
- $exists$: there exists
- $arrow.double$: implies
- $arrow.l.r.double$: if and only if

*Definition*: 
1. if $A subset B$ if $a in A arrow.double a in B$
2. $A = B$ if $ A subset B and B subset A $ <equality>
3. $A subset.neq B$ if $A subset B and A eq.not B$ 

*Set Building Notation*

All $x$ satisfying property $P(x)$

${x in A, P(x)}$ or ${x , P(X)}$

*Examples*

1. $NN = {1, 2, 3, ...}$
2. $ZZ = {0, 1, -1, 2, -2, ...}$
3. $QQ = {m/n: m, n in ZZ quad n eq.not 0}$
4. Odd numbers: ${2m-1: m in NN}$

$
  NN subset ZZ subset QQ subset RR (subset CC)
$

*Definition* 

1. Union: $A union B = {x: x in A or x in B}$
2. Intersection: $A inter B.= {z: x in A and x in B}$
3. Difference: $A \\ B = {x: x in A and x in.not B}$
4. Complement: $A^C = {x: x in.not A}$
5. Disjount: $A inter B = emptyset$

*De Morgan*

If A, B, C are sets, then:
1. $(B union C)^C = B^C inter C^C$
2. $(B inter C)^C = B^C union C^C$
3. $A \\ (B union C) = (A \\ B) inter (A \\ C)$
4. $A \\ (B inter C) = (A \\ B) union (A \\ C)$

*Proof*

1. 

Let B, C be sets.

We want to prove that:

$
  (B union C)^C = B^C inter C^C
$

Since to prove the equality of two sets we need to show that @equality holds:

We need to show that:

$
  (B union C)^C subset B^C inter C^C  
$ <one>

and

$
  B^C inter C^C subset (B union C)^C
$ <two>

WTS @one:

Let 
$ 
  x in (B union C)^C
$ 

Then 

$
  x in.not B union C \
  arrow.double \
  x in.not B and x in.not C \
  arrow.double \
  x in B^C and x in C^C \
  arrow.double \
  x in B^C inter C^C \
$

Thus, $(B union C)^C subset B^C inter C^C$

WTS @two:

Let
$
  x in B^C inter C^C
$

Then

$
  x in B^C and C^C \
  arrow.double \
  x in.not B and x in.not C
  arrow.double \
  x in.not B union C
  arrow.double \
  x in (B union C)^C
$

Thus, $B^C inter C^C subset (B union C)^C$

Thus, $B^C inter C^C = (B union C)^C$

*Theorem*: Induction

$NN = {1, 2, 3, dots}$ has an ordering

*Axiom*: Well ordering property

If $S subset NN$ and $S eq.not emptyset$ then $S$ has a least element: i.e., $exists x in S s.t. x lt.eq y forall y in S$

Let $P(n)$ be a statement depending on $n in NN$. Assume:
1. (Base Case) $P(1)$ is True
2. (Induction Step) If $P(m)$ is True, then $P(m+1)$ is True

Then $P(n)$ is true for all $n in NN$

*Proof*

Let $S = {n in NN: P(n) "is not True"}$

WTS: $S = emptyset$

We will prove this by contradiction

(Assume the negation of the statement $S eq.not emptyset$ and derive a false statement. Rules of logic say that $S eq.not emptyset$ is false.)

Suppose $S eq.not emptyset$, by the well ordering property (WOP) of $NN$, $S$ has a least element $x in S$. Since $P(1)$ is True (assumption), $1 in.not S arrow arrow.double x eq.not 1$, this particular $x gt 1$. Since $x$ is the least element of $S$ and $x-1 < x$, $x-1 in.not S$. Thus, by the definition of $S$, $P(x-1)$ is True. By the second property of induction (Induction Step) $arrow.double P(X)$ is True $arrow.double x in.not S$.

From $S eq.not emptyset$, we conclude $exists x in NN$, $x in S$ and $x in.not S$. Contradiction.

Thus, $S eq emptyset$

*Using Induction*

We want to prove $forall n in NN, P(n)$ is True, we need to do 2 things:
1. Prove base case $P(1)$
2. Prove, if $P(m)$ is True, $P(m+1)$ is True

*Theorem*

$P(n)$

$forall c eq.not 1, forall n in NN$, 

$
  1 + c + c^2 + dots + c^n = (1 - c^(n+1)) / (1 - c)
$ <three>

*Proof*

Prove @three by induction:
1) (Basic Case) 

$
  1 + c^1 = (1 - c^(1 + 1)) / (1 - c) = 1 + c
$ 

2) (Induction Step)

$
  1 + c + dots + c^m = (1 - c^(m+1)) / (1 - c)
$

We want to prove @three holds for $n = m + 1$

We have:

$
  1 + c + dots + c^m + c^(m+1) 
  &= (1 - c^(m+1)) / (1 - c) + c^(m+1) \
  &= (1 cancel(- c^(m+1)) cancel(+ c^(m+1)) - c^(m+2)) / (1 - c) \
  &= (1 - c^((m+1)+1)) / (1 - c)
$

Thus, @three holds for $n = m + 1$. So by induction, @three holds for all $n in NN$

*Theorem*

If $c gt.eq -1$, then $forall n in NN$, 

$
  (1 + c)^n gt.eq 1 + n c
$ <four>

*Proof* (By Induction)

1) (Base Case)

$
  (1 + c)^1 gt.eq 1 + 1 c
$

So, @four  

