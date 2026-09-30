#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"

// #set heading(numbering: "1.1.")
#set text(font: "Helvetica", size: 8pt)
#show table: it => align(center, it)

#let result(content) = box(stroke: blue, fill: blue.transparentize(75%), inset: 0.5em, radius: 0.25em)[
  #content
]

#let r(x) = calc.round(x, digits: 2)


#import "@local/tystats:0.1.0": norm, expon, poisson

= Problem 1 (Max Points 40) 

Sport Zone's running shoes division in Zaragoza purchases a line of shoes at €30 from its supplier in China. As there is a long lead time, at the time of order placement, demand is still uncertain. Sport Zone has a forecast that its demand is normally distributed with mean 2,100 and standard deviation 600 for the upcoming season. In addition, Sport Zone recently found an alternative supplier in Portugal with a higher unit cost of €40 but with a negligible lead time. As the lead time from Portugal is very short, Sport Zone may make the order decision from Portugal even after demand is realized. Sport Zone sells the shoes at €50 each. The leftover inventory can be sold to discounters for €5.

// ---------- Parameters ----------
#let price = 50
#let cost_china = 30
#let cost_portugal = 40
#let salvage = 5
#let goodwill = 0 // penalty per unit of unmet demand

#let demand_mean = 2100
#let demand_sd = 600

// ---------- Helpers (reusable) ----------
#let r(x, digits: 4) = calc.round(x, digits: digits)

// Standard normal loss function L(z) = phi(z) - z (1 - Phi(z))
#let loss(z) = norm.pdf(z) - z * (1 - norm.cdf(z))

// Critical ratio c_u / (c_u + c_o)
#let critical_ratio(underage, overage) = underage / (underage + overage)

// Optimal order quantity for a critical ratio
#let optimal_q(ratio, mean: demand_mean, sd: demand_sd) = norm.ppf(ratio, mean: mean, std_dev: sd)

// Expected inventory outcomes for an order quantity q
#let inventory(q, mean: demand_mean, sd: demand_sd) = {
  let z = (q - mean) / sd
  let L = loss(z)
  let short = sd * L // E[(D - q)^+]
  let sold = mean - short // E[min(D, q)]
  let leftover = q - sold // E[(q - D)^+]
  (z: z, L: L, short: short, sold: sold, leftover: leftover)
}

- Price ($p$): #price €/unit
- Cost, China ($c_c$): #cost_china €/unit
- Cost, Portugal ($c_p$): #cost_portugal €/unit
- Salvage value ($s$): #salvage €/unit
- Goodwill cost ($g$): #goodwill €/unit
- Demand: $D tilde cal(N)(mu = #demand_mean, sigma = #demand_sd)$

Throughout:

$
  E["Short"] &= E[(D - Q)^+] = sigma dot L(z), quad z = (Q - mu) / sigma \
  E["Sold"] &= E[min(D, Q)] = mu - E["Short"] \
  E["Leftover"] &= E[(Q - D)^+] = Q - mu + E["Short"] \
  L(z) &= phi(z) - z (1 - Phi(z))
$

(a) _If Sport Zone can only place an order from the supplier in China, how many shoes should Sport Zone buy to maximize its expected profit in the upcoming season? What is its expected profit? (5 points)_

#let underage_a = price - cost_china + goodwill
#let overage_a = cost_china - salvage
#let ratio_a = critical_ratio(underage_a, overage_a)
#let Q_a = optimal_q(ratio_a)
#let inv_a = inventory(Q_a)
#let profit_a = (
  price * inv_a.sold + salvage * inv_a.leftover - goodwill * inv_a.short - cost_china * Q_a
)

A unit short loses the margin (plus goodwill); a unit left over loses its cost net of salvage:

$
  c_u = p - c_c + g = #price - #cost_china + #goodwill = #underage_a
$
$
  c_o = c_c - s = #cost_china - #salvage = #overage_a
$
$
  "cr" = c_u / (c_u + c_o) = #underage_a / (#underage_a + #overage_a) = #r(ratio_a)
$
$
  Q^* = F^(-1)(#r(ratio_a)) = #result[#r(Q_a)] approx #calc.round(Q_a) "units"
$

#let x = lq.linspace(demand_mean - 4*demand_sd, demand_mean + 4*demand_sd, num: 200)
#let y = x.map(x => norm.cdf(x, mean: demand_mean,std_dev: demand_sd))

#figure(
  lq.diagram(
    width: 10cm,
    height: 8cm,
    xlim: (0, 4000),
    ylim: (0, 1),
    xlabel: [$Q$],
    ylabel: [$$],
    lq.plot(x, y, mark: none, stroke: 1.5pt),
    lq.hlines(ratio_a, max: Q_a, stroke: 1pt + red),
    lq.vlines(Q_a, max: norm.cdf(Q_a, mean: demand_mean, std_dev: demand_sd), stroke: 1pt + red),
  ),
  caption: [$F^(-1) ("cr")$]
)

With $z = #r(inv_a.z)$ and $L(z) = #r(inv_a.L)$:

$
  E["Short"] &= #demand_sd times #r(inv_a.L) = #r(inv_a.short) \
  E["Sold"] &= #demand_mean - #r(inv_a.short) = #r(inv_a.sold) \
  E["Leftover"] &= #r(Q_a) - #demand_mean + #r(inv_a.short) = #r(inv_a.leftover)
$

Therefore:

$
  pi_a (Q)
  &= p E["Sold"] + s E["Leftover"] - g E["Short"] - c_c Q \
  &= #price times #r(inv_a.sold) + #salvage times #r(inv_a.leftover) - #goodwill times #r(inv_a.short) - #cost_china times #r(Q_a) \
  &= #result[#r(profit_a)]
$

#let qs = lq.linspace(0, 4000, num: 300)
#let inv_q = qs.map(inventory)

#let overage_cost = inv_q.map(i => overage_a * i.leftover)
#let underage_cost = inv_q.map(i => underage_a * i.short)
#let mismatch = overage_cost.zip(underage_cost).map(((o, u)) => o + u)
#let mismatch_a = overage_a * inv_a.leftover + underage_a * inv_a.short

#figure(
  lq.diagram(
    width: 10cm,
    height: 7cm,
    xlim: (0, 4000),
    ylim: (0, 60000),
    xlabel: [$Q$],
    ylabel: [Expected cost (€)],
    legend: (position: top + right),
    lq.plot(qs, overage_cost, mark: none, label: [$c_o E["Leftover"]$]),
    lq.plot(qs, underage_cost, mark: none, label: [$c_u E["Short"]$]),
    lq.plot(qs, mismatch, mark: none, stroke: 1.5pt, label: [$M(Q)$]),
    lq.vlines(Q_a, stroke: (paint: black, dash: "dashed")),
  ),
  caption: [Expected mismatch cost; $pi(Q) = (p - c) mu - M(Q)$ is maximized where $M$ is minimized.],
)

#let revenue = inv_q.map(i => price * i.sold)
#let salvage_rev = inv_q.map(i => salvage * i.leftover)
#let purchase = qs.map(q => cost_china * q)
#let profit_q = qs.enumerate().map(((k, q)) => revenue.at(k) + salvage_rev.at(k) - goodwill * inv_q.at(k).short - purchase.at(k))

#figure(
  lq.diagram(
    width: 10cm,
    height: 7cm,
    xlim: (0, 4000),
    xlabel: [$Q$],
    ylabel: [€],
    legend: (position: top + left),
    lq.plot(qs, revenue, mark: none, label: [$p E["Sold"]$]),
    lq.plot(qs, salvage_rev, mark: none, label: [$s E["Leftover"]$]),
    lq.plot(qs, purchase, mark: none, label: [$c_c Q$]),
    lq.plot(qs, profit_q, mark: none, stroke: 1.5pt, label: [$pi(Q)$]),
    lq.vlines(Q_a, stroke: (paint: black, dash: "dashed")),
  ),
  caption: [Components of expected profit.],
)

(b) _If Sport Zone can place an order from both suppliers, how many shoes should Sport Zone buy from China to maximize expected profit, especially considering that it still has a chance to order some quantity from Portugal after demand is realized? What is its expected profit in this case? (5 points)_

#let underage_b = cost_portugal - cost_china
#let overage_b = cost_china - salvage
#let ratio_b = critical_ratio(underage_b, overage_b)
#let Q_b = optimal_q(ratio_b)
#let inv_b = inventory(Q_b)
#let profit_b = (
  price * demand_mean - cost_china * Q_b - cost_portugal * inv_b.short + salvage * inv_b.leftover
)
#let option_value = profit_b - profit_a

Any demand above $Q$ is covered by Portugal after demand is realized, so every customer is served (no lost sales). A unit short now costs only the extra sourcing cost, not the lost margin:

$
  c_u = (p - c_c) - (p - c_p) = c_p - c_c = #cost_portugal - #cost_china = #underage_b
$
$
  c_o = c_c - s = #cost_china - #salvage = #overage_b
$
$
  "cr" = c_u / (c_u + c_o) = #underage_b / (#underage_b + #overage_b) = #r(ratio_b)
$
$
  Q^* = F^(-1)(#r(ratio_b)) = #result[#r(Q_b)] approx #calc.round(Q_b) "units"
$

With $z = #r(inv_b.z)$ and $L(z) = #r(inv_b.L)$, the expected shortage is now the expected Portugal order:

$
  E["Portugal"] &= E[(D - Q)^+] = #demand_sd times #r(inv_b.L) = #r(inv_b.short) \
  E["Leftover"] &= #r(Q_b) - #demand_mean + #r(inv_b.short) = #r(inv_b.leftover)
$

All $mu$ units of demand are sold at $p$, so:

$
  pi_b (Q)
  &= p mu - c_c Q - c_p E["Portugal"] + s E["Leftover"] \
  &= #price times #demand_mean - #cost_china times #r(Q_b) - #cost_portugal times #r(inv_b.short) + #salvage times #r(inv_b.leftover) \
  &= #result[#r(profit_b)]
$

The Portugal option raises expected profit by $#r(profit_b) - #r(profit_a) = #r(option_value)$ €, and Sport Zone orders #calc.round(Q_a - Q_b) fewer units from China, because running short now costs #underage_b € per unit instead of #underage_a €.

#let pdf(x) = norm.pdf(x, mean: demand_mean, std_dev: demand_sd)
#let xs = lq.linspace(0, 4200, num: 300)
#let xs_china = lq.linspace(0, Q_b, num: 150)
#let xs_portugal = lq.linspace(Q_b, 4200, num: 150)
#let p_china_only = norm.cdf(Q_b, mean: demand_mean, std_dev: demand_sd)

#figure(
  lq.diagram(
    width: 10cm,
    height: 7cm,
    xlim: (0, 4200),
    ylim: (0, auto),
    xlabel: [Demand $D$],
    ylabel: [$f(D)$],
    legend: (position: top + left),
    lq.fill-between(xs_china, xs_china.map(pdf), fill: blue.transparentize(60%),
      label: [$D <= Q^*$: China only ($P = #r(p_china_only, digits: 3)$)]),
    lq.fill-between(xs_portugal, xs_portugal.map(pdf), fill: orange.transparentize(60%),
      label: [$D > Q^*$: Portugal tops up ($P = #r(1 - p_china_only, digits: 3)$)]),
    lq.plot(xs, xs.map(pdf), mark: none, stroke: 1.5pt + black),
    lq.vlines(Q_b, stroke: (paint: red, dash: "dashed"), label: [$Q^*_b approx #calc.round(Q_b)$]),
    lq.vlines(Q_a, stroke: (paint: black, dash: "dashed"), label: [$Q^*_a approx #calc.round(Q_a)$]),
  ),
  caption: [Demand distribution split at the China order quantity.],
)

(c) Now suppose that Sport Zone has to make a one-time contract payment to establish a business relationship with the Portuguese supplier. What is the maximum amount Sport Zone would be willing to pay to have this new supplier? (5 points)

#let option_value = profit_b - profit_a

The most Sport Zone should pay is the extra expected profit the Portugal supplier brings.

$
  "Max payment"
  &= pi_b (Q^*_b) - pi_a (Q^*_a) \
  &= #r(profit_b) - #r(profit_a) \
  &= #result[#r(option_value)]
$

The payment is a one-time fixed cost, so it does not change the marginal trade-off: Sport Zone still orders $Q^*_b approx #calc.round(Q_b)$ units from China and uses Portugal for any demand above that. The backup is worth #r(option_value, digits: 2) € because a unit short now costs only $c_p - c_c = #underage_b$ € instead of $p - c_c = #underage_a$ €. This lets Sport Zone order #calc.round(Q_a - Q_b) fewer units from China and still serve every customer.

(d) _Now back to (a), suppose that Sport Zone is considering a thesis project with ZLOG 2017 to improve their demand forecasting. If the company anticipates a more accurate forecast with the same mean but a reduced standard deviation of (1-theta) $times$ 600 (where theta is a number between 0 and 1), how much would Sport Zone be willing to pay for this project? Please express your response as a function of theta (rather than testing different values of theta). (5 points)_

#let z_star = inv_a.z
#let phi_star = norm.pdf(z_star)
#let cost_per_sigma = (underage_a + overage_a) * phi_star // € lost per unit of sigma
#let forecast_value = cost_per_sigma * demand_sd // value of a perfect forecast (theta = 1)

For normal demand, $z^* = Phi^(-1)("cr")$ depends only on the critical ratio, so it stays at $z^* = #r(z_star)$ for any $sigma$. Then $Q^* = mu + z^* sigma$, and both $E["Short"] = sigma L(z^*)$ and $E["Leftover"] = sigma (z^* + L(z^*))$ scale with $sigma$:

$
  pi(sigma)
  &= (p - c_c) mu - c_o E["Leftover"] - c_u E["Short"] \
  &= (p - c_c) mu - sigma [c_o z^* + (c_u + c_o) L(z^*)] \
  &= (p - c_c) mu - (c_u + c_o) phi(z^*) sigma
$

where the last step uses $Phi(z^*) = c_u / (c_u + c_o)$. Expected profit falls linearly in $sigma$ at a rate of

$
  (c_u + c_o) phi(z^*) = (#underage_a + #overage_a) times #r(phi_star) = #r(cost_per_sigma) "€ per unit of" sigma
$

With $sigma' = (1 - theta) sigma$, the most Sport Zone would pay is the profit gain:

$
  V(theta)
  &= pi((1 - theta) sigma) - pi(sigma) \
  &= (c_u + c_o) phi(z^*) sigma theta \
  &= #r(cost_per_sigma) times #demand_sd times theta \
  &= #result[#r(forecast_value, digits: 2) $theta$]
$

Check: at $theta = 1$ (perfect forecast), $V = #r(forecast_value, digits: 2)$ €, exactly the expected mismatch cost in (a): $(p - c_c) mu - pi_a = #r((price - cost_china) * demand_mean - profit_a, digits: 2)$ €.

// Profit of the China-only newsvendor for a given sigma (brute force, for checking)
#let profit_for_sd(sd) = {
  if sd == 0 { return (price - cost_china) * demand_mean }
  let q = optimal_q(ratio_a, sd: sd)
  let inv = inventory(q, sd: sd)
  price * inv.sold + salvage * inv.leftover - goodwill * inv.short - cost_china * q
}

#let profit_theta(t) = profit_a + forecast_value * t // closed form
#let theta_breakeven = (profit_b - profit_a) / forecast_value // project beats Portugal backup

#let ts = lq.linspace(0, 1, num: 100)
#let ts_check = lq.linspace(0, 1, num: 11)

#figure(
  lq.diagram(
    width: 10cm,
    height: 7cm,
    xlim: (0, 1),
    ylim: (30000, 43000),
    xlabel: [$theta$],
    ylabel: [Expected profit (€)],
    legend: (position: bottom + right),
    lq.fill-between(ts, ts.map(_ => profit_a), y2: ts.map(profit_theta),
      fill: blue.transparentize(80%), label: [$V(theta) = #r(forecast_value, digits: 2) theta$]),
    lq.plot(ts, ts.map(profit_theta), mark: none, stroke: 1.5pt, label: [$pi(theta)$, closed form]),
    lq.scatter(ts_check, ts_check.map(t => profit_for_sd((1 - t) * demand_sd)),
      color: black, size: 4pt, label: [$pi(theta)$, newsvendor]),
    lq.hlines(profit_a, stroke: (paint: gray, dash: "dotted")),
    lq.hlines((price - cost_china) * demand_mean, stroke: (paint: gray, dash: "dotted")),
    lq.hlines(profit_b, stroke: (paint: orange, dash: "dashed"), label: [$pi_b$ (Portugal backup)]),
    lq.vlines(theta_breakeven, stroke: 0.8pt + orange),
  ),
  caption: [Expected profit as the forecast improves. The project beats the Portugal backup for $theta > #r(theta_breakeven, digits: 3)$.],
)

(e) What do you observe in (d) in terms of the impact of standard deviation on the expected profit? (5 points) 

(f) Back to (a), the company has realized from their history that if a customer can't find buy what he/she wants because of stock out, their reputation gets worse and they eventually lose some of the customers. They have estimated this undesirable impact as the monetary cost, which is €3 per each of lost sales. What is the optimal order quantity and the expected profit respectively? What do you observe here especially comparing this result with that of 
(a)? (5 points) 

(g) In (f), what are the optimal order quantity and the expected profit if the monetary cost per each of lost sales is €10, €20, €30 and €40? What do you observe here especially comparing this result with that of (f)? (5 points) 

(h) In (a), suppose Sport Zone has to pay a fixed transportation cost of €500 whenever it places an order in addition to other costs. How many shoes should Sport Zone buy to maximize its expected profit in the upcoming season? What is its expected profit? (5 points) 


= Problem 2 (Max Points 35) 

Sam Holding (SH) sells a tent to Intersport (IP). SH's variable cost per tent is €100 while its wholesale price is €185 per tent (the wholesale price includes the cost of shipping the tent to IP). IP sells the tent for €250. Suppose IP's forecast for season sales can be described with a Poisson distribution with rate (mean) 8.75. Furthermore, IP plans to only buy once from SH and any eventual leftovers are sold at a discount of 75% (i.e., at €62.5 per tent).

#let c = 100
#let w = 185
#let p = 250
#let s = 62.5
#let lam = 8.75

(a) How many tents should IP order? (5 points) 

#let cu_ip = p - c
#let co_ip = c - s

#let cr_ip = cu_ip / ( cu_ip + co_ip)

#let Q_ip = poisson.ppf(cr_ip, lam)

$
  c_u = p - c = #cu_ip \
  c_o = c - s = #co_ip \
$

$
  "cr" 
  &= c_u / (c_u + c_o) \
  &= #cr_ip
$

$
  Q^* = F^(-1) ("cr") = #Q_ip
$

(b) What is IP's expected profit given his optimal order quantity in (a)? (5 points) 

#let e_short_ip = lam * (1 - poisson.cdf(Q_ip - 1, lam)) - Q_ip * (1 - poisson.cdf(Q_ip, lam))

#let e_sales_ip = lam - e_short_ip
#let e_leftover_ip = Q_ip - e_sales_ip

#let e_profit_ip = p * e_sales_ip + s * e_leftover_ip - c * Q_ip

$
  E["Short"] = sigma L 
  &= lambda (1 - F(Q-1)) - Q(1 - F(Q)) \
  &= #calc.round(e_short_ip, digits: 2)
$

$
  E["Sales"] = mu - E["Short"] = #calc.round(e_sales_ip, digits: 2)
$

$
  E["Leftover"] = Q - E["Sales"] = #calc.round(e_leftover_ip, digits: 2)
$

$
  E["Profit"] 
  &= p E["Sales"] + s E["Leftover"] - g E["Short"] - c Q \
  &= #calc.round(e_profit_ip, digits: 2)
$


(c) What is SH's expected profit given IP's order in part (a)? (5 points) 

(d) To maximize the supply chain's total profit (SH's profit plus IP's profit) how many tents should be shipped to IP? (5 points) [(e)~(f)] Suppose SH were to accept unsold tents at the end of the season. IP would incur a €15 shipping cost per tent returned to SH. Suppose SH gives IP a 90% credit for each returned tent, that is, SH pays IP €166.5 for each returned tent.  

(e) How many tents should IP order to maximize its profit? (5 points) 

(f) What is the expected profit for IP and SH, given IP's order in part (e)? (5 points) 

(g) To maximize the supply chain's total profit, what should IP's buyback percentage be? (The current credit is 90%). Assuming that SH can sell all returned tents at €185 per tent, is profit maximizing buyback percentage feasible? (5 points) 

= Problem 3 (Max Points 15) 

Each year the admissions committee at a top business school receives a large number of 
applications for admission to the MBA program and they have to decide on the number of 
offers to make. Since some of the admitted students may decide to pursue other opportunities, the committee typically admits more students than the ideal class size of 720 students. You were asked to help the admissions committee estimate the appropriate number of people who should be admitted. It is estimated that in the coming year the number of people who will not accept the admission offer is normally distributed with mean 50 and standard deviation 21. Suppose for now that this school does not maintain a waiting list, that is, all students are accepted or rejected. 

#let n_ideal = 720
#let reject_mean = 50
#let reject_sd = 21

(a) Suppose 750 students are admitted. What is the probability that the class size will be at least 720 students? (5 points) 

#let n_admitted = 750

#let x = lq.linspace(reject_mean - 4*reject_sd, reject_mean + 4*reject_sd, num: 200)
#let y = x.map(x => norm.pdf(x, mean: reject_mean,std_dev: reject_sd))

#figure(
  lq.diagram(
    width: 10cm,
    height: 8cm,
    xlabel: [$Q$],
    ylabel: [$$],
    lq.plot(x, y, mark: none, stroke: 1.5pt),
    lq.vlines(n_admitted, stroke: 1pt + red),
    lq.vlines(n_ideal, stroke: 1pt + red),
  ),
  caption: []
)

(b) There is a mutual agreement that it is about two times more expensive to have a student in excess of the ideal 720 than to have fewer students in the class. What is the appropriate number of students to admit? (5 points) 

(c) A waiting list mitigates the problem of having too few students since at the very last 
moment there is an opportunity to admit some students from the waiting list. Hence, the admissions committee revises its estimate: It claims that it is five times more expensive to have a student in excess of 720 than to have fewer students accept among the initial group of admitted students. What is your revised suggestion? (5 points)

= Problem 4 (Max Points 10)

In the formal presentation of the Newsvendor problem, we have shown that the profit
maximization problem is equivalent to the minimizing of the following cost function:

$
  C(Q) = E[C_u dot (D - Q)^+ + C_o dot (Q - D)^+]
  
$

or,

$
  C(Q) = C_u E["short"] + C_o E["left"]
$


Assume that the demand is normally distributed with mean μ and standard deviation $sigma$. By using the characterization (i.e., expression) for the optimal order quantity, $Q^*$, show that the
optimal cost can be expressed as $C(Q^*) = A(C_u, C_o) times sigma$ , where $A(C_u, C_o)$ is a constant which is a function of the cost parameters Cu and Co but not of the parameters ($mu$, $sigma$) of the demand distribution $D$. What can you infer for the maximum profit that the newsvendor can gain by ordering the optimal quantity?

= Quiz Problem (Max Points 20)

On a given Boston-Barcelona flight, there are 200 seats. Suppose the ticket price is \$475 on average and the number of passengers who reserve a seat but do not show up for departure is normally distributed with mean 30 and standard deviation 15. You decide to overbook the flight and estimate that the average loss from a passenger who will have to be bumped (if the number of passengers exceeds the number of seats) is \$800.

(a) What is the maximum number of reservations that should be accepted? (2 point)

(b) Suppose you allow 220 reservations. How much money do you expect to pay out in
compensation to bumped passengers? (2 point)

(c) Suppose you allow 220 reservations. What is the probability that you will have to deal with bumped passengers? (2 points)

[(d)~(g)] Now assume there is no overbooking, and the high fare is \$675 and the low fare is \$375. Demand for the low fare is abundant while demand for the high fare is normally distributed with a mean of 80 and standard deviation 35.

(d) What is the probability of selling 200 reservations if you set an optimal protection level (i.e., number of seats reserved) for the full fare? (8 points)

(e) Suppose a protection level of 85 is established. What is the average number of lost high-fare passengers? (2 points)

(f) Continue to assume a protection level of 85 is established. What is the expected number of unoccupied seats? (2 points)

(g) Again, assume a protection level of 85 is established. What is the expected revenue from the flight? (2 points)
