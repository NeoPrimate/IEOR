#import "../utils/examples.typ": eg
#import "../utils/code.typ": code

== Rules

=== Complement Rule

The probability of the complement of an event 
$A$ is $P(A^c) = 1 - P(A)$

How likely it is that the event does not occur.

#eg[
  Consider a fair die:

- Let A be the event "rolling a 4". Then $P(A) = 1 / 6$

- The complement of A, denoted $P(A^c)$, is "not rolling 4"

- $P(A^c) = 1 - P(A) = 1 - 1 / 6 = 5 / 6$
]

=== Multiplication Rule

- Independent Events

If $A$ and $B$ are independent, then $P(A inter B) = P(A) times P(B)$. The probability of both events occurring is the product of their individual probabilities.

#eg[
Consider flipping two fair coins. Let $A$ be the event "the first coin is heads" and $B$ be the event "the second coin is heads"

- Since the flips are independent, $P(A inter B)=P(A) times P(B)$

- $P(A) = 1 / 2$ and $P(B) = 1 / 2$

- Thus, $P(A inter B) = 1 / 2 times 1 / 2 = 1 / 4$
]

- Dependent Events

If $A$ and $B$ are dependent, $P(A inter B) = P(A) times P(B | A)$, where $P(B | A)$ is the conditional probability of $B$ given $A$.

#eg[
Draw two cards from a standard deck without replacement. Let $A$ be the event "drawing an Ace on the first draw" and $B$ be the event "drawing an Ace on the second draw"

- $P(A) = 4 / 52 = 1 / 13$

- If A occurs (i.e., an Ace is drawn first), there a re 3 Aces left out of 51 cards. So, $P(B | A) = 3 / 51 = 1 / 17$

- Thus, $P(A inter B) = P(A) times P(B | A) = 1 / 13 times 1 / 17 = 1 / 221$
]

=== Addition Rule

For Any Two Events: $P(A union B) = P(A) + P(B) - P(A inter B)$. This accounts for the overlap between the two events to avoid double counting.

#eg[
Suppose you roll a die, and you want to find the probability of rolling a 2 or a 4.

- Let $A$ be the event "rolling a 2," and $B$ be the event "rolling a 4"

- $P(A) = 1 / 6$ and $P(B) = 1 / 6$

- Since A and B are mutually exclusive, $P(A inter B) = 0$

- $P(A union B) = P(A) + P(B) - P(A inter B) = 1 / 6 + 1 / 6 - 0 = 2 / 6 = 1 / 3$
]

=== Conditional Probability

The probability of an event $A$ given that $B$ has occurred is $P(A | B) = P(A inter B) / P(B)$, provided $P(B) > 0$.

#eg[
In a deck of 52 cards, if you know a card is a spade, what is the probability that it is an Ace?

- Let $A$ be the event "drawing an Ace," and $B$ be the event "drawing a spade"

- $P(B) = 12 / 52 = 1 / 4$

- There is 1 Ace of Spades out of 13 spades, so $P(A inter B) = 1 / 32$

- Thus, $P(A | B) = P(A inter B) / P(B) = (1 / 52) / (13 / 52) = 1 / 13$
]

=== Law of Total Probability

If ${B_i}$ is a partition of the sample space, then for any event A:

$
P(A) = sum_i P(A inter B_i) = sum_i P(A | B_i) times P(B_i)
$

#eg[
Suppose you want to calculate the probability of raining on a given day. You know that it's either sunny or cloudy, and the probability of rain is different in each condition.

- Let $B_1$ be the event "sunny" and $B_2$ be the event "cloudy"

- $P(B_1) = 3 / 4$ and $P(B_2) = 1 / 4$

- The probability of rain given sunny is $P(A | B_1) = 1 / 10$, and given cloudy is $P(A | B_2) = 2 / 5$

- The total probability of rain is:
$
P(A) &= P(A | B_1) times P(B_1) + P(A | B_2) times P(B_2) \
&= 1 / 10 times 3 / 4 + 2 / 5 times 1 / 4 \
&= 3 / 40 + 2 / 20 \
&= 3 / 40 + 4 / 40 \
&= 7 / 40 \
$

]

=== Law of Large Numbers

As the number of trials of a random experiment increases, the sample mean will converge to the expected value (mean) of the random variable

#eg[
You flip a fair coin 1000 times. As you increase the number of flips, the proportion of heads should get closer to the probability of heads (which is 0.5).
]

=== Central Limit Theorem

For a sufficiently large number of trials, the distribution of the sample mean approaches a normal distribution, regardless of the distribution of the population

#eg[
Suppose you are rolling a fair die repeatedly and calculating the average of the results. If you take 30 samples, each being the average of 10 die rolls, the distribution of those sample means will be approximately normal with a mean of 3.5 (the mean of a fair die) and a standard deviation that can be computed based on the original die's distribution.
]