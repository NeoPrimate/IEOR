# ZLOG Math Gap Todo

Math chapters/topics missing from the book, derived from a comparison against MIT OCW courses for the ZLOG ZLC M.Eng. in Logistics & SCM:

- ESD.260J Logistics Systems · ESD.273J Logistics & SCM
- 15.053 Optimization Methods · 15.760A Operations Management · 15.769 Operations Strategy
- 15.762J Supply Chain Planning · 15.763J Manufacturing System & SC Design
- 15.871 / 15.988 System Dynamics
- ESD.290 Special Topics in SCM · MITx SCM MicroMasters (SC0x–SC4x)

Legend: 🔴 critical · 🟡 high-value · 🟢 nice-to-have

---

## Top 12 highest-impact additions (do these first)

- [ ] 🔴 **Dynamic Programming** — Bellman recursion, principle of optimality, forward/backward induction; deterministic + stochastic
- [ ] 🔴 **Standard normal loss function** $L(z)=\phi(z)-z(1-\Phi(z))$ + table — unlocks every fill-rate / safety-stock derivation
- [ ] 🔴 **Multi-echelon inventory** — Clark-Scarf serial system + Graves-Willems guaranteed-service
- [ ] 🔴 **Risk pooling** — square-root law, correlated pooling $\sigma_{pool}^2=\sum\sigma_i^2+2\sum\rho_{ij}\sigma_i\sigma_j$, postponement
- [ ] 🔴 **Network optimization core** — transportation problem, assignment + Hungarian, transshipment, MCNF algorithms
- [ ] 🔴 **TSP + VRP** — formulations, Clarke-Wright savings, Daganzo continuous approximation
- [ ] 🔴 **Facility location** — UFLP, CFLP, p-median, set/max covering, center-of-gravity (Weiszfeld)
- [ ] 🔴 **Decision analysis** — decision trees, EMV, EVPI, EVSI
- [ ] 🔴 **Stochastic programming** — two-stage with recourse, EVPI vs VSS
- [ ] 🔴 **Aggregate planning + MRP/MPS/DRP arithmetic**
- [ ] 🔴 **System Dynamics core** — stocks/flows, causal loops, Erlang-$n$ delays, beer-game/bullwhip closed forms, goal-seeking-with-delays ODE
- [ ] 🔴 **Factory physics** — VUT/Kingman/Sakasegawa, Hopp-Spearman best/worst/PWC, kanban, takt time, learning curves, line balancing

---

## 1. Optimization

- [ ] 🔴 Dynamic programming (Bellman, knapsack-DP, shortest-path-DP, equipment replacement)
- [ ] 🔴 Stochastic DP / MDPs (states/actions/rewards, value & policy iteration, infinite horizon, discounted reward)
- [ ] 🔴 Decision trees / EVPI / EVSI / Bayesian update on tree
- [ ] 🔴 Decision criteria under uncertainty: maximin, maximax, minimax-regret, Hurwicz, Laplace
- [ ] 🔴 Stochastic programming: two-stage with recourse, scenario trees, deterministic equivalent, chance constraints
- [ ] 🟡 Robust optimization: box / ellipsoidal / Bertsimas-Sim Γ-budget; robust LP counterpart
- [ ] 🟡 Cutting planes — Gomory pure & mixed, cover/clique/lifted inequalities, branch-and-cut
- [ ] 🟡 Column generation — restricted master + pricing subproblem (cutting-stock)
- [ ] 🟡 Benders decomposition — master + feasibility/optimality cuts
- [ ] 🟢 Dantzig-Wolfe decomposition
- [ ] 🟡 Quadratic Programming (Markowitz, regression-as-QP)
- [ ] 🟢 SOCP / SDP intro
- [ ] 🟢 Interior-point methods, ellipsoid method
- [ ] 🟡 Network simplex
- [ ] 🟡 Two-phase / Big-M simplex initialization (verify present)
- [ ] 🟢 Anti-cycling: Bland's rule, lexicographic
- [ ] 🟡 Total unimodularity theorems explicit
- [ ] 🟡 Subgradient method (Lagrangian dual updates)
- [ ] 🟡 Farkas lemma / theorems of the alternative / separating hyperplane
- [ ] 🟡 Metaheuristics individually: simulated annealing, tabu search, GRASP, GA, ant colony, VNS

## 2. Network Optimization

- [ ] 🔴 Transportation problem — LP form, NW-corner, MODI, Vogel
- [ ] 🔴 Assignment problem + Hungarian algorithm
- [ ] 🔴 Transshipment problem
- [ ] 🔴 Min-cost flow algorithms — negative-cycle canceling, successive shortest paths
- [ ] 🟡 Minimum spanning tree — Prim, Kruskal
- [ ] 🟡 Floyd-Warshall all-pairs shortest path
- [ ] 🟢 A* search
- [ ] 🟡 Topological sort, DAG shortest path
- [ ] 🟡 Bipartite matching
- [ ] 🔴 TSP — DFJ + MTZ formulations, nearest-neighbor, 2-opt/3-opt, Lin-Kernighan, Christofides 3/2-bound
- [ ] 🔴 VRP family — CVRP, VRPTW formulations
- [ ] 🔴 Clarke-Wright savings $s_{ij}=c_{0i}+c_{0j}-c_{ij}$
- [ ] 🟡 Sweep heuristic, Fisher-Jaikumar
- [ ] 🔴 Daganzo continuous-approximation routing $L\approx k\sqrt{nA}$
- [ ] 🔴 CPM (forward/backward pass, slack)
- [ ] 🔴 PERT (beta-PERT $\mu=(a+4m+b)/6$, $\sigma^2=((b-a)/6)^2$, CLT on critical path)
- [ ] 🟡 Crashing LP
- [ ] 🟢 Design Structure Matrix (DSM) partitioning/sequencing

## 3. Facility Location & Network Design

- [ ] 🔴 Center of gravity / Weiszfeld iteration
- [ ] 🔴 p-median (MIP)
- [ ] 🟡 p-center (minimax)
- [ ] 🔴 Set covering (LSCP), max covering (MCLP)
- [ ] 🔴 UFLP — uncapacitated, dual-ascent (Erlenkotter), Lagrangian
- [ ] 🔴 CFLP — capacitated, Lagrangian relaxation
- [ ] 🔴 Two-echelon location (plant→DC→customer) MIP
- [ ] 🟡 Hub location — p-hub median, flow-aggregation discount α

## 4. Queueing

- [ ] 🔴 Erlang C formula named, with derivation
- [ ] 🟡 Erlang B (loss) formula
- [ ] 🔴 G/G/1 Kingman / VUT equation $CT_q\approx\frac{c_a^2+c_e^2}{2}\frac{\rho}{1-\rho}t_e$
- [ ] 🔴 G/G/c Sakasegawa approximation
- [ ] 🔴 Linking equation $c_d^2=(1-\rho^2)c_a^2+\rho^2 c_e^2$ (variance propagation)
- [ ] 🟡 M/M/c/K finite capacity
- [ ] 🟡 M/M/c+M (Erlang A) with abandonment
- [ ] 🟡 Square-root staffing $c\approx\rho+\beta\sqrt{\rho}$ (Halfin-Whitt)
- [ ] 🟡 Jackson networks (open, product-form)
- [ ] 🟢 Two-machine finite-buffer, Buzacott-Shanthikumar; decomposition
- [ ] 🔴 Poisson process as a process — superposition, thinning, PASTA, Palm's theorem
- [ ] 🟡 Birth-death processes (general derivation)
- [ ] 🟢 Renewal theory basics
- [ ] 🟡 Continuous-time Markov chains
- [ ] 🟢 Brownian motion intro

## 5. Inventory

- [ ] 🔴 Standard normal loss function $L(z)$ chapter with table
- [ ] 🔴 Clark-Scarf serial multi-echelon (echelon vs installation stock, induced penalty)
- [ ] 🔴 METRIC (Sherbrooke) for repairables
- [ ] 🟡 VARI-METRIC (Graves variance correction)
- [ ] 🔴 Guaranteed-service Graves-Willems $\tau_i=s_{i-1}+T_i-s_i$, $SS_i=z\sigma_i\sqrt{\tau_i}$
- [ ] 🟡 Stochastic-service Lee-Billington / Ettl
- [ ] 🟡 Eppen-Schrage allocation (OWMR)
- [ ] 🟡 Power-of-two policies + Roundy 98% bound
- [ ] 🔴 Lot-sizing heuristics: Silver-Meal, Least Unit Cost, Part-Period Balancing, POQ
- [ ] 🟡 CLSP / DLSP / CSLP / PLSP capacitated lot-sizing MIPs
- [ ] 🟢 ELSP (economic lot scheduling problem)
- [ ] 🔴 Risk-pooling formulas: square-root law + correlated extension
- [ ] 🔴 Postponement / delayed differentiation (Lee-Tang)
- [ ] 🟡 Component commonality (Baker-Magazine-Nuttle)
- [ ] 🔴 Stochastic lead-time SS $\sigma_{DL}=\sqrt{L\sigma_D^2+\bar D^2\sigma_L^2}$ explicit
- [ ] 🟢 Random yield models (Yano-Lee)
- [ ] 🔴 Bullwhip closed form $\frac{Var(O)}{Var(D)}=1+\frac{2L}{p}+\frac{2L^2}{p^2}$ (verify in `bullwhip.typ`)
- [ ] 🟡 Service-parts $(S{-}1, S)$ policy

## 6. Forecasting

- [ ] 🔴 Croston's method + Syntetos-Boylan correction (intermittent demand)
- [ ] 🟡 ADI / CV² classification (Syntetos-Boylan-Croston grid)
- [ ] 🔴 Tracking signal $TS=\sum e_t/\text{MAD}$
- [ ] 🔴 MAD ↔ σ relationship $\sigma\approx 1.25\,\text{MAD}$ under normality
- [ ] 🟡 Theil's U decomposition ($U^M, U^S, U^C$)
- [ ] 🟡 Forecast combination: simple average, inverse-variance, Granger-Ramanathan
- [ ] 🟡 Hierarchical forecasting: top-down, bottom-up, MinT reconciliation
- [ ] 🟡 Bayesian forecasting / conjugate updates (Beta-Binomial, Gamma-Poisson, Normal-Normal)
- [ ] 🟢 Kalman filter / state-space forecasting
- [ ] 🔴 Forecast-error → safety-stock linkage (use RMSE, not σ_demand)
- [ ] 🟡 Aggregation & pooling effect on forecast accuracy (CV reduction)
- [ ] 🟡 Stationarity tests — ADF, KPSS
- [ ] 🟢 GARCH / volatility models

## 7. Decision Analysis (entirely missing)

- [ ] 🔴 Decision trees, rollback / folding-back
- [ ] 🔴 EMV, EVPI, EVSI
- [ ] 🟡 Utility theory: risk aversion, certainty equivalent, risk premium
- [ ] 🟡 Maximin / maximax / minimax-regret / Hurwicz / Laplace criteria
- [ ] 🟡 AHP (Analytic Hierarchy Process)
- [ ] 🟢 TOPSIS / weighted-sum / goal programming

## 8. Game Theory & Auction Theory (entirely missing)

- [ ] 🔴 Two-player zero-sum, payoff matrix, dominated strategies, saddle points
- [ ] 🔴 Minimax theorem (von Neumann) + LP formulation of zero-sum game
- [ ] 🟡 Mixed strategies
- [ ] 🟡 Nash equilibrium (pure & mixed) for non-zero-sum
- [ ] 🟡 Stackelberg games
- [ ] 🟢 Cooperative games / Shapley value, core
- [ ] 🔴 Auctions: first-price, second-price (Vickrey), English, Dutch
- [ ] 🟡 Revenue equivalence theorem
- [ ] 🔴 Combinatorial auctions — Caplice-Sheffi WDP, set-partitioning IP, VCG
- [ ] 🟢 Mechanism design basics

## 9. Revenue Management & Pricing (entirely missing)

- [ ] 🔴 Littlewood's rule (two-class) $P(D_1>y)=p_2/p_1$
- [ ] 🔴 EMSR-a, EMSR-b nested booking limits
- [ ] 🟡 DP formulation of RM (Bellman on capacity × time)
- [ ] 🟡 Overbooking (binomial / normal show-up)
- [ ] 🟡 Bid-price control from network LP duals
- [ ] 🟡 Choice-based RM (multinomial logit demand)
- [ ] 🔴 Static price optimization (linear demand $p^*=(a+bc)/(2b)$)
- [ ] 🟡 Markdown optimization
- [ ] 🟡 Dynamic pricing
- [ ] 🟡 Real options for capacity (binomial lattice CRR, Black-Scholes flavor)

## 10. Scheduling & Project Management (entirely missing)

- [ ] 🔴 Single-machine: SPT (mean flow), EDD (max lateness), LPT, Moore (number tardy)
- [ ] 🔴 Johnson's rule (2-machine flow shop)
- [ ] 🟡 Job-shop heuristics: shifting bottleneck
- [ ] 🟡 Dispatching rules: FCFS, SPT, EDD, CR, slack-based
- [ ] 🔴 CPM forward/backward, slack
- [ ] 🔴 PERT stochastic durations + CLT
- [ ] 🟡 Crashing LP
- [ ] 🟢 Design Structure Matrix (DSM) partitioning/sequencing

## 11. Manufacturing / Factory Physics (entirely missing)

- [ ] 🔴 Hopp-Spearman Best/Worst/PWC triplet, critical WIP $W_0=r_b T_0$
- [ ] 🔴 CONWIP; comparison vs kanban / MRP
- [ ] 🔴 Kanban sizing $K=\lceil DL(1+\alpha)/C\rceil$
- [ ] 🔴 Takt time = available time / demand
- [ ] 🔴 Line balancing — theoretical-min stations, balance efficiency, LTT, Ranked Positional Weight
- [ ] 🟡 Heijunka / EPEI
- [ ] 🟡 Karmarkar clearing function $TH=f(WIP)$
- [ ] 🟡 OEE = Availability × Performance × Quality
- [ ] 🟡 Effective process time with breakdowns: $t_e=t_0/A$, variance inflation
- [ ] 🔴 Theory of Constraints throughput accounting ($T, OE, I, NP$); DBR; product-mix LP
- [ ] 🔴 Learning curves: Wright $T_n=T_1 n^{-b}$ + Crawford; cumulative-cost integral

## 12. Aggregate Planning / MRP (entirely missing)

- [ ] 🔴 Aggregate planning LP (chase, level, mixed; hire/fire/OT/inventory/backlog)
- [ ] 🟡 Bowman transportation-LP form of APP
- [ ] 🟢 HMMS Holt-Modigliani-Muth-Simon quadratic / linear decision rule
- [ ] 🔴 MRP — gross-to-net, BOM explosion, lead-time offsetting
- [ ] 🔴 MPS / time-phased records
- [ ] 🟡 DRP pull-up logic
- [ ] 🟡 RCCP (rough-cut capacity) bills of capacity
- [ ] 🟢 Hax-Meal hierarchical planning (item / family / type)

## 13. SC Contracts & Coordination (entirely missing)

- [ ] 🔴 Buy-back contract (Cachon-Lariviere)
- [ ] 🔴 Revenue-sharing
- [ ] 🟡 Quantity-flexibility contract
- [ ] 🟡 Options contracts
- [ ] 🔴 Double marginalization correction
- [ ] 🔴 Channel coordination algebra (centralized vs decentralized profit)
- [ ] 🟡 TCO / should-cost models
- [ ] 🟡 Make-vs-buy break-even $Q^*=F/(v_b-v_m)$

## 14. Reliability / Maintenance (entirely missing)

- [ ] 🔴 Reliability $R(t)=e^{-\lambda t}$ derivation; bathtub curve
- [ ] 🔴 Series/parallel system reliability ($\prod R_i$, $1-\prod(1-R_i)$)
- [ ] 🔴 MTBF, MTTR, availability $A=\text{MTBF}/(\text{MTBF}+\text{MTTR})$
- [ ] 🟡 Weibull failure distribution
- [ ] 🟡 Age vs block replacement
- [ ] 🟡 Hazard rate (verify `hf.typ` covers reliability framing)

## 15. System Dynamics (entirely missing chapter family)

- [ ] 🔴 Stocks & flows ODE foundation $\dot S=\text{in}-\text{out}$, dimensional consistency
- [ ] 🔴 Causal loop diagrams, link & loop polarity
- [ ] 🔴 First-order linear systems: $\dot x=g x$ (R), $\dot x=(x^*-x)/\tau$ (B) — closed forms
- [ ] 🔴 Numerical integration: Euler, RK4; DT selection $\Delta t\le \min(\tau)/4$
- [ ] 🔴 Delays: pipeline, exponential 1st-order, higher-order Erlang $n$-stage; SMOOTH/DELAY operators
- [ ] 🔴 Smoothing & forecasting: SES recursion, SMOOTH3, TREND, FORECAST
- [ ] 🔴 Stock-management structure (anchoring + supply-line correction); supply-line neglect → bullwhip
- [ ] 🔴 Beer Distribution Game equations + Sterman estimated decision rule
- [ ] 🟡 Bass diffusion $\dot A=(p+qA/N)(N-A)$, peak time $\ln(q/p)/(p+q)$
- [ ] 🟡 Logistic growth + closed form
- [ ] 🟡 SIR / SEIR, $R_0$, herd immunity
- [ ] 🟢 Lotka-Volterra
- [ ] 🟡 Limits to growth / overshoot-and-collapse
- [ ] 🟡 Capacity-cycle / commodity-cycle models
- [ ] 🟡 Workforce / aging chain / coflow structures
- [ ] 🔴 Goal-seeking with delays → 2nd-order ODE; damping ratio $\zeta$, natural frequency $\omega_n$
- [ ] 🟡 Phase-plane analysis, nullclines, trajectories
- [ ] 🔴 Linearization at equilibrium, Jacobian, eigenvalue classification (node/saddle/spiral/center)
- [ ] 🟡 Routh-Hurwitz stability criterion
- [ ] 🟢 Hopf bifurcation, limit cycles, period-doubling, chaos
- [ ] 🟢 Lyapunov function intro
- [ ] 🟡 Theil's inequality coefficient $U$ for SD validation
- [ ] 🟡 Calibration: FIMLOF / Powell parameter search
- [ ] 🟡 Monte Carlo / Latin Hypercube sensitivity
- [ ] 🟢 Path dependence / lock-in (Polya urn)

## 16. Differential Equations (only one file today)

- [ ] 🔴 First-order ODEs: separable, exact, integrating factor
- [ ] 🔴 Linear 2nd-order ODEs: homogeneous, particular, undetermined coefficients
- [ ] 🟡 Systems of linear ODEs, matrix exponential
- [ ] 🔴 Equilibria & stability (eigenvalue test)
- [ ] 🟡 Phase portraits (2-D)
- [ ] 🔴 Numerical methods: Euler, Heun, RK4
- [ ] 🟡 Laplace transforms
- [ ] 🟡 Nonlinear ODEs: linearization, limit cycles

## 17. Probability

- [ ] 🔴 Distributions missing: Lognormal, Gamma, Beta, Negative Binomial, Geometric, Uniform (continuous + discrete), Triangular, Weibull, Hypergeometric, Compound Poisson
- [ ] 🔴 Joint / marginal / conditional in multivariate explicit chapters
- [ ] 🟡 Convolutions of independent r.v.s
- [ ] 🟡 Order statistics
- [ ] 🔴 Law of total expectation / total variance as named theorems
- [ ] 🔴 LLN, CLT with derivations
- [ ] 🟡 Inequalities: Markov, Chebyshev, Jensen, Chernoff, Hoeffding
- [ ] 🔴 Standard normal loss function $L(z)$ chapter
- [ ] 🟡 Conjugate priors for Bayesian updates
- [ ] 🟡 Mixture distributions

## 18. Statistics

- [ ] 🔴 Bootstrap & resampling
- [ ] 🔴 Acceptance sampling: OC curve, AOQ, AOQL, single/double/sequential plans
- [ ] 🟡 ARL (Average Run Length) for control charts; WECO rules
- [ ] 🟡 Six Sigma DPMO conversion, ±1.5σ shift
- [ ] 🟡 Rolled throughput yield
- [ ] 🟢 Gage R&R
- [ ] 🟢 Survival analysis (Kaplan-Meier, Cox PH)
- [ ] 🟡 Kalman filter
- [ ] 🔴 PCA
- [ ] 🟡 Time-series cross-validation specifics

## 19. Linear Algebra

- [ ] 🔴 SVD
- [ ] 🔴 PCA as application
- [ ] 🟡 QR decomposition, Cholesky decomposition
- [ ] 🟡 Pseudoinverse (Moore-Penrose)
- [ ] 🟡 Matrix calculus (gradient/Jacobian/Hessian of vector-valued functions)
- [ ] 🟡 Quadratic forms explicit usage (positive/negative-(semi)definiteness)
- [ ] 🟡 Norms: vector $p$-norms, matrix norms, spectral norm
- [ ] 🟡 Spectral theorem, diagonalization conditions
- [ ] 🟢 Iterative solvers: Jacobi, Gauss-Seidel, conjugate gradient
- [ ] 🟢 Power iteration

## 20. Real Analysis (almost empty today)

- [ ] 🟡 Sequences, series, convergence (real-line)
- [ ] 🟡 Continuity, differentiability proofs
- [ ] 🟢 Topology of $\mathbb R^n$ (open/closed/compact)
- [ ] 🟢 Integration theory (Riemann, intro to Lebesgue)
- [ ] 🟢 Metric spaces, Banach fixed-point

## 21. Algorithms (sparse)

- [ ] 🟡 Floyd-Warshall all-pairs SP
- [ ] 🟡 A* heuristic search
- [ ] 🟡 Topological sort
- [ ] 🟡 MST: Prim, Kruskal
- [ ] 🟡 Bipartite matching (Hopcroft-Karp)
- [ ] 🟢 Sorting (mergesort, quicksort, heapsort)
- [ ] 🟡 Big-O analysis chapter
- [ ] 🟡 NP-hardness reductions intro

## 22. Financial Math (entirely missing)

- [ ] 🔴 TVM: PV, FV, NPV, IRR, payback
- [ ] 🔴 Cash-to-cash cycle = DIO + DSO − DPO
- [ ] 🟡 GMROI (verify formula in existing file)
- [ ] 🟡 DuPont decomposition: ROA = margin × turnover
- [ ] 🟡 Activity-based costing
- [ ] 🟡 Real options (binomial CRR; Black-Scholes intro for capacity)
- [ ] 🟢 CAPM, risk-adjusted discount rate
- [ ] 🟡 Inventory carrying-cost rate decomposition

## 23. Sustainability Math

- [ ] 🟡 Carbon accounting Scope 1/2/3
- [ ] 🟡 Emissions factor × ton-km, modal-shift trade-off
- [ ] 🟡 Green-newsvendor / EOQ with carbon cost $Q^*=\sqrt{2D(S+e_S)/(h+e_h)}$
- [ ] 🟢 Closed-loop SC / remanufacturing (Fleischmann)
- [ ] 🟢 LCA basics

## 24. SC Risk Math

- [ ] 🟡 VaR, CVaR / Expected Shortfall
- [ ] 🔴 TTR / TTS framework (Simchi-Levi)
- [ ] 🟡 Risk-exposure index
- [ ] 🟡 Compound-Poisson disruption loss models
- [ ] 🟡 Backup-supplier / dual-sourcing decision tree

## 25. Information Theory

- [ ] 🟡 Entropy (Shannon)
- [ ] 🟡 KL divergence
- [ ] 🟡 Mutual information
- [ ] 🟡 Information gain (decision-tree learning)

---

## Verification list (chapters that may exist but need a quick check)

- [ ] `bullwhip.typ` — does it contain the closed-form variance amplification?
- [ ] `eoq/multi_echelon.typ` — Clark-Scarf? Or just framing?
- [ ] `statistics/functions/hf.typ` — hazard rate framed for reliability?
- [ ] `inventory/metrics/gmroi.typ` — formula present and derived?
- [ ] `time_series/ets/` — Holt-Winters labelled by name (additive/multiplicative)?
- [ ] `error_metrics/` — tracking signal?
- [ ] `optimization/simplex_method.typ` — two-phase / Big-M / Bland's rule?
- [ ] `optimization/heuritic_algorithms.typ` — does it cover SA / TS / GA individually?
- [ ] `markov_chains/` — DTMC only or also CTMC?
