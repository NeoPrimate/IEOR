#import "../../../utils/code.typ": code
#import "../../../utils/examples.typ": eg


== M/M/1

- Arrival rate ($lambda$): Average number of customers arriving per unit of time

- Service rate ($mu$): Average number of customers served per unit of time

#figure(image("../../../vis/exponential_interarrival_times_poisson_number_arrivals.png", width: 80%))

1. Utilization ($rho$)

Fraction of time the server is busy

$
rho = lambda / mu
$

2. Average Number of Customers in the System ($L$)

Average number of customers (both waiting and being served) in the system

$
L = rho / (1 - rho)
$

3. Average Number of Customers in the Queue ($L_q$)

Average number of customers waiting in the queue

$
L_q = rho^2 / (1 - rho)
$

4. Average Time a Customer Spends in the System ($W$)

Average time a customer spends in the system (from arrival until they are done being served) 

$
W = 1 / (mu - lambda)
$

5. Average Waiting Time in the Queue ($W_q$)

Average time a customer spends just waiting in line before being served

$
W_q = rho / (mu - lambda)
$

6. Probability that the System is Empty ($P_0$)

Probability that there are zero customers in the system (no one is being served and no one is waiting)

$
P_0 = 1 - rho
$

7. Probability that n Customers are in the System ($P_n$)

Probability that there are n customers in the system (either waiting or being served)

$
P_n = (1 - rho) dot rho^n
$

8. Probability the Queue is Full (if the Queue has Limited Capacity) ($P_n_"max"$)

Probability that the system is at full capacity

$
P_n_"max" = (1 - rho) dot p^(n_"max")
$

9. System Throughput

Rate at which customers are served and leave the system

$
"Throughput" = lambda
$

10. Expected Time in Service ($W_s$)

Average time a customer spends actually being served (not including waiting time)

$
W_s = 1 / mu
$

11. Idel Time ($1 - rho$)

Fraction of time that the server is idle (i.e., not serving any customers)

$
"Idle Time" = 1 - rho
$

12. Probability of Having to Wait in the Queue ($P_w$)

Probability that an arriving customer will have to wait before being served, i.e., that the server is busy when the customer arrives

$
P_w = rho
$

13. Variance of the Number of Customers in the System ($"Var"(L)$)

Variance of the number of customers in the system

$
"Var"(L) = rho / (1 - rho)^2
$

#eg[
A bank with a single teller

- *Arrival rate ($lambda$)*: On average, 4 customers arrive every 10 minutes ($lambda = 4$ custommers per 10 minutes)

-  *Service Rate ($mu$)*: The teller can serve 6 customers every 10 minutes ($mu = 6$ customers per 10 minutes)

1. *Utilization ($rho$)*

$
rho = lambda / mu = 4 / 6 = 0.67
$

The teller is busy 67% of the time. The remaining 33% of the time, the teller is idle, waiting for the next customer

2. Average Number of Customers in the System ($L$)

$
L = rho / (1 - rho) = 0.67 / (1 - 0.67) = 2
$

On average, there are 2 customers in the coffee shop at any given time, either being served or waiting in line

3. Average Number of Customers in the Queue ($L_q$)

$
L_q = rho^2 / (1 - rho) = 0.67^2 / (1 - 0.67) = 1.33
$

On average, about 1.33 customers are waiting in line at any time

4. Average Time a Customer Spends in the System ($W$)

$
W = 1 / (mu - lambda) = 1 / 6 - 4 = 0.5
$

On average, a customer spends 5 minutes ($0.5 times 10$ minutes) in the shop (including both waiting in line and getting served)

5. Average Waiting Time in the Queue ($W_q$)

$
W_q = rho / (mu - lambda) = 0.67 / (6 - 4) = 0.33
$

On average, a customer waits 3.3 minutes ($0.33 times 10$ minutes) in line before being served by the teller

6. Probability that the System is Empty ($P_0$)

$
P_0 = 1 - rho = 1 - 0.67 = 0.33
$

There is a 33% chance that the coffee shop is empty, meaning there is no customer in the queue or being served

7. Probability that n Customers are in the System ($P_n$)

$
P_n = (1 - rho) dot rho^n = (1 - 0.67) dot 0.67^2 = 0.148
$

There is a 14.8% chance that exactly 2 customers are either in line or being served

8. Probability the Queue is Full (if the Queue has Limited Capacity) ($P_n_"max"$)

$
P_n_"max" = (1 - rho) dot p^(n_"max") = (1 - 0.67) dot 0.67^5 = 0.028
$

There is a 2.8% chance that the system is full, and no new customers can enter

9. System Throughput

$
"Throughput" = lambda = 4
$

The coffee shop serves 4 customers every 10 minutes, on average

10. Expected Time in Service ($W_s$)

$
W_s = 1 / mu = 1 / 6 = 0.167
$

On average, a customer spends 1.67 minutes being served by the teller

11. Idel Time ($1 - rho$)

$
"Idle Time" = 1 - rho = 1 - 0.67 = 0.33
$

The teller is idle 33% of the time

12. Probability of Having to Wait in the Queue ($P_w$)

$
P_w = rho = 0.67
$

There is a 67% chance that a customer will have to wait when they arrive

13. Variance of the Number of Customers in the System ($"Var"(L)$)

$
"Var"(L) = rho / (1 - rho)^2 = 0.67 / (1 - 0.67)^2 = 6.12^2
$

The queue length varies significantly, with a variance of 6.12 customers
]

Costs

- *Cost per Waiting Customer per Unit Time ($C_w$)*: cost incurred per customer for each unit of time they spend waiting in the queue

$
"Total Waiting Cost" = L_q times C_w times "Unit Time"
$

- *Cost per Idle Server per Unit Time ($C_s$)*: cost incurred per unit time when the server is not serving customers

$
"Total Idle Cost" = (1 - rho) times C_s times "Unit Time"
$

Total Cost

$
"Total Cost" = "Total Waiting Cost" + "Total Idle Cost"
$

#eg[

  - Arrival Rate ($lambda$): 4 customers per 10 minutes
  - Service Rate ($mu$): 6 customers per 10 minutes
  - Cost per Waiting Customer per Hour ($C_w$): \$10
  - Cost per Idle Server per Hour ($C_s$): \$20
  - Operational Time: 1 hour 

  1. Utilization

  $
  rho = lambda / mu = 4 / 6 = 0.67
  $

  2. Average Number of Customers in Queue ($L_q$)

  $
  L_q = rho^2 / (1 - rho) = 0.67^2 / (1 - 0.67) = 1.33 "cusommers"
  $

  3. Total Waiting Cost

  $
  "Total Waiting Cost" = L_q times C_w times "Unit Time" = 1.33 times 10 times 1 = \$13.33
  $

  4. Idle Time

  $
  "Idle Time" = 1 - rho = 1 - 0.67 = 0.33
  $

  5. Total Idle Cost

  $
  "Total Idle Cost" = (1 - rho) times C_s times "Unit Time" = 0.33 times 20 times 1 = \$6.67
  $

  6. Total Cost

  $
  "Total Cost" = "Total Waiting Cost" + "Total Idle Cost" = 13.33 + 6.67 = \$20
  $
]




