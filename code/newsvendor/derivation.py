import sympy as sp
from scipy.stats import norm

# ---------------------------------------------------------------
# Symbolic setup
# ---------------------------------------------------------------
x, Q = sp.symbols('x Q', real=True)
mu = sp.symbols('mu', real=True)
sigma = sp.symbols('sigma', real=True, positive=True)
c_o, c_u = sp.symbols('c_o c_u', positive=True)

# Normal PDF and CDF (symbolic)
f = (1 / (sigma * sp.sqrt(2 * sp.pi))) * sp.exp(-((x - mu)**2) / (2 * sigma**2))
F = sp.Rational(1, 2) * (1 + sp.erf((Q - mu) / (sigma * sp.sqrt(2))))


# ---------------------------------------------------------------
# Step 1: Expected overage and underage
# ---------------------------------------------------------------
expected_overage = sp.integrate((Q - x) * f, (x, -sp.oo, Q))
expected_underage = sp.integrate((x - Q) * f, (x, Q, sp.oo))

print("E[(Q - D)+] =")
sp.pprint(sp.simplify(expected_overage))
print("\nE[(D - Q)+] =")
sp.pprint(sp.simplify(expected_underage))


# ---------------------------------------------------------------
# Step 2: Build the cost function C(Q)
# ---------------------------------------------------------------
C = c_o * expected_overage + c_u * expected_underage


# ---------------------------------------------------------------
# Step 3: Path 1 — differentiate the full cost
# ---------------------------------------------------------------
dC_dQ = sp.simplify(sp.diff(C, Q))
print("\ndC/dQ (from full cost) =")
sp.pprint(dC_dQ)


# ---------------------------------------------------------------
# Step 3b: Path 2 — the "clean" form using F(Q) directly
# ---------------------------------------------------------------
dC_dQ_clean = c_o * F - c_u * (1 - F)
print("\ndC/dQ (clean form c_o F - c_u (1-F)) =")
sp.pprint(sp.simplify(dC_dQ_clean))

# Verify the two paths agree
print("\nDo both forms match? ",
      sp.simplify(dC_dQ - dC_dQ_clean) == 0)


# ---------------------------------------------------------------
# Step 4: Solve dC/dQ = 0 for the critical ratio
# ---------------------------------------------------------------
critical_eq = sp.Eq(dC_dQ_clean, 0)
F_at_Qstar = sp.solve(critical_eq, F)[0]
print("\nF(Q*) =")
sp.pprint(sp.simplify(F_at_Qstar))    # → c_u / (c_o + c_u)


# ---------------------------------------------------------------
# Step 5: Second-derivative check (convexity)
# ---------------------------------------------------------------
d2C = sp.simplify(sp.diff(C, Q, 2))
print("\nd²C/dQ² =")
sp.pprint(d2C)   # should be (c_o + c_u) * f(Q)  ≥ 0


# ---------------------------------------------------------------
# Step 6: Numerical example — newspaper problem
# ---------------------------------------------------------------
co_val, cu_val = 0.50, 1.50
mu_val, sigma_val = 100, 20

cr = cu_val / (co_val + cu_val)
Q_star = norm.ppf(cr, loc=mu_val, scale=sigma_val)

print(f"\nCritical ratio c_u / (c_o + c_u) = {cr:.4f}")
print(f"Optimal order quantity Q*       = {Q_star:.2f}")
