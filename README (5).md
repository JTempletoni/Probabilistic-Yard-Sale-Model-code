# Probabilistic Yard-Sale Model

A MATLAB implementation of the probabilistic Yard-Sale Model (YSM) as formulated by Christophe Chorro (2016), extended to incorporate wealth-attained advantage (WAA) and various taxation and redistribution mechanisms. Produced as part of an undergraduate dissertation studying the emergence of wealth inequality in agent-based exchange models.

---

## Background

The Yard-Sale Model is a class of Multiplicative Random Asset Exchange Model (MRAEM) from the econophysics literature. Two agents are selected at random each round to transact; the amount exchanged is a fixed fraction of the poorer agent's wealth, ensuring the game remains zero-sum and no agent can go negative. Without any redistribution mechanism the model converges — provably, via martingale arguments — to a state of complete wealth condensation (oligarchy). A small redistribution parameter is sufficient to prevent this.

This project reproduces and extends Chorro's probabilistic reformulation of the model as a discrete-time Markov chain game, rather than the more common Fokker-Planck / SDE approach used by Boghosian et al. The key distinction is that agents hold a *share* of total wealth (so the state space is the simplex) rather than absolute units, making the system explicitly zero-sum.

---

## Repository Structure

| File | Description |
|---|---|
| `working2playerwithouttaxes.m` | Two-player game, no redistribution |
| `working2playerwithtaxes.m` | Two-player game with flat wealth tax `b` |
| `twoplayernotaxstrongsol.m` | Strong solution of the corresponding SDE via Euler–Maruyama |
| `twoplayersteadystate.m` | Monte Carlo steady-state density for the two-player game across a range of `b` values |
| `twoplayersteadystate2curve.m` | As above with a refined `b` range |
| `NxNgamewithtaxes.m` | N-player game with flat redistribution tax `b` |
| `NxNwithincometaxes.m` | N-player game with income/transaction tax `γ` on winnings |
| `NxNgamewithWAAbias.m` | N-player game with wealth-attained advantage (WAA) |
| `altNbyN.m` | Alternate N-player formulation (Chorro's end-of-paper remark): all agents transact each round, one random winner |
| `incometaxwithstartwealth.m` | N-player game with heterogeneous initial endowments and income tax |
| `lorenzfinished.m` | Lorenz curves and Gini index at multiple time snapshots |
| `probdensity.m` | Histogram-based PDF over entire simulation |
| `KerneldensityPDF.m` | Kernel density estimates of the wealth distribution at `t = 1000`, `t = 50000`, `t = end` |
| `ECDFandCDF.m` | Empirical CDF vs fitted normal CDF, with Kolmogorov–Smirnov test |
| `findingstats.m` | Variance and median wealth plotted over time |

> **Usage note:** The simulation files (`NxN*`, `working2player*`, `altNbyN`, `incometaxwithstartwealth`) each produce the wealth array `X(t, N)`. Run one of these first, then run any of the analysis/plotting files which consume `X` from the workspace.

---

## Model Description

### Two-Player Game

Each agent holds share $X^i_n \in [0,1]$ with $X^1_n + X^2_n = 1$. At each step a fair coin determines the winner; the amount transferred is $a \min(X^i_n, 1 - X^i_n)$, i.e. a fraction $a$ of the poorer player's wealth.

**Without redistribution:**
$$X^i_{n+1} = X^i_n \pm a \min(X^i_n,\, 1 - X^i_n)$$

**With redistribution parameter $b$:**
$$X^i_{n+1} = (1-b)X^i_n \pm a \min(X^i_n,\, 1 - X^i_n) + \frac{b}{2}$$

The redistribution term taxes all agents at rate $b$ each round and returns the proceeds equally, preventing absorbing-state collapse.

### N-Player Game

At each step two agents $k_1, k_2$ are drawn uniformly at random (without replacement). Only those two agents exchange wealth; all others are taxed and receive their share of the redistribution pot:

$$X_{n+1} = (1-b)X_n + \frac{b}{N} + \sum_{k \in S_N} Y^{k_1,k_2}_{n+1} \mathbf{1}_{V_{n+1}=(k_1,k_2)}$$

where $S_N = \{(k_1,k_2) \in \mathbb{N}^2 : N \geq k_1 > k_2 \geq 1\}$.

### Wealth-Attained Advantage (WAA)

Following Boghosian et al. (2016), the win probability shifts in favour of the wealthier agent:

$$p = \frac{1}{2} + \rho(X^{k_1}_n - X^{k_2}_n)$$

where $\rho$ is a weighting parameter. With $b = 0$ this accelerates wealth condensation markedly. With even a modest $b = 0.01$ the effect of WAA is negligible regardless of $\rho$.

---

## Key Parameters

| Parameter | Symbol | Typical value | Description |
|---|---|---|---|
| Number of players | `N` | 10 – 50 | Agents in the game |
| Rounds | `n` | 10 000 – 100 000 | Time steps simulated |
| Wealth fraction | `a` | 0.1 | Fraction of poorer agent's wealth exchanged |
| Redistribution rate | `b` | 0 – 0.05 | Flat wealth tax redistributed equally each round |
| WAA weighting | `ρ` / `e` | 5 | Scales the win-probability advantage of the richer agent |
| Income tax rate | `γ` | 0 – 0.5 | Tax on winnings only (alternative redistribution scheme) |

---

## Results Summary

- **Without redistribution** ($b = 0$): the game is a non-negative bounded martingale and converges to oligarchy. Lorenz curves diverge from equality over time; Gini index approaches 1.
- **With redistribution** ($b = 0.01$): wealth condensation is blocked. The stationary distribution is approximately normal around the equal-share $1/N$; Gini indices remain small (~0.05–0.06) and stable throughout.
- **Randomised** $a \in [0,1]$: a redistribution rate of $b = 0.01$ is insufficient; $b = 0.02$ restores stability.
- **WAA with** $b = 0.01$: the redistribution mechanism absorbs the advantage entirely; the distribution is indistinguishable from the no-WAA case.
- **Income tax variant**: taxing only the winner's gain (rather than all wealth each round) produces qualitatively similar stabilisation but requires careful calibration to conserve total wealth exactly.

---

## Dependencies

- MATLAB R2020a or later (earlier versions likely work)
- Statistics and Machine Learning Toolbox (`ksdensity`, `gpfit`, `ecdf`)
- No external packages required

---

## References

- Chorro, C. (2016). *A simple probabilistic approach of the yard-sale model.* Statistics & Probability Letters, 112.
- Boghosian, B. M. (2014). *Kinetics of wealth and the Pareto law.* Physical Review E, 89, 042804.
- Boghosian, B. M. et al. (2016). *Oligarchy as a phase transition: The effect of wealth-attained advantage in a Fokker-Planck description of asset exchange.*
- Boghosian, B. M. et al. (2022). *An economically realistic asset exchange model.* Philosophical Transactions of the Royal Society A, 380.
- Yakovenko, V. M. & Rosser, J. B. (2009). *Colloquium: Statistical mechanics of money, wealth, and income.* Reviews of Modern Physics, 81(4), 1703–1725.
