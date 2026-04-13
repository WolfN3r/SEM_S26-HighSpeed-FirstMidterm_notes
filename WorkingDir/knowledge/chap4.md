# Coupled Microstrip Line

> Source: `chap4_HSDSD.pdf`  
> Instructor: Chun-Long Wang, National Taiwan University of Science and Technology
>
> *Note: This chapter presents research results on techniques to suppress far-end crosstalk (FEXT) in coupled microstrip lines.*

---

## 4.1 Literature Survey *(pp.3–7)*

Several existing methods for suppressing FEXT in coupled microstrip lines:

| Method | FEXT Reduction | Drawback |
|---|---|---|
| Guard trace [1] | Slight | Minimal improvement |
| Grounded guard trace [2] | Efficient | Limited routing due to vias |
| Grounded guard trace + dielectric overlay [3] | Efficient, only 2 vias | Extra dielectric overlay cost |
| Serpentine guard trace [4] | Efficient, no vias/overlay | Large area |
| Alternately open-circuited stubs [5] | Efficient, less area | Large reflection |

**Motivation for this chapter's approach:** eliminate the need for dielectric overlay, vias, serpentine guard trace, AND reduce reflection — using a **decoupling capacitor** method.

---

## 4.2 Baseline: Coupled Microstrip Line Parameters *(p.9)*

**Substrate:** FR4, $\varepsilon_r = 4.4$, $\tan\delta = 0.02$

**Dimensions:** $w = 1.42$ mm, $s = 0.7$ mm, $h = 0.8$ mm, $\ell = 40$ mm

Equivalent circuit per unit length: series self-inductance $L_s$, mutual inductance $L_m$, shunt self-capacitance $C_s$, mutual capacitance $C_m$.

---

## 4.3 Even- and Odd-Mode Equivalent Circuits *(p.10)*

| Mode | Series inductance | Shunt capacitance | Time delay |
|---|---|---|---|
| Even | $L_s + L_m$ | $C_s$ | $\text{TD}_{\text{even}} = \ell\sqrt{(L_s+L_m)C_s}$ |
| Odd | $L_s - L_m$ | $C_s + 2C_m$ | $\text{TD}_{\text{odd}} = \ell\sqrt{(L_s-L_m)(C_s+2C_m)}$ |

*(chap4.pdf, p.10)*

**Key finding:** $\text{TD}_{\text{even}} \neq \text{TD}_{\text{odd}}$ in a microstrip. The time difference is:

$$T_d = \text{TD}_{\text{even}} - \text{TD}_{\text{odd}}$$

This difference $T_d$ is **the root cause of FEXT** in a microstrip line (unlike stripline, where $T_d = 0$).

---

## 4.4 FEXT and NEXT — Ideal Coupled Line *(pp.11–13)*

**Even/odd mode decomposition:** A direct excitation on the active line decomposes into even-mode excitation (both lines driven $+V_s/2$) and odd-mode excitation (active $+V_s/2$, quiet $-V_s/2$).

For the baseline (ideal) coupled line:
- $\text{TD}_{\text{even}} = 253.614$ ps, $\text{TD}_{\text{odd}} = 229.202$ ps, $T_d = 24.412$ ps
- **FEXT peak** = 0.076 V
- **NEXT peak** = 0.019 V

FEXT = $V_{4o}(t) + V_{4e}(t)$ — the even and odd mode contributions arrive at different times due to $T_d$, producing a pulse.

---

## 4.5 FEXT/NEXT Estimation Equations (Baseline) *(p.14)*

**NEXT peak (at $t = t_r$):**

$$V_2(t_r) = V_{2e}(t_r) + V_{2o}(t_r)$$

$$V_{2e}(t_r) = \frac{V_s}{2}\left(\frac{Z_{\text{even}}}{Z_{\text{even}} + Z_0}\right) - \frac{V_s}{2} \cdot \frac{Z_{\text{even}} - Z_0}{Z_{\text{even}} + Z_0}$$

<!-- VERIFY: slide 14 formulas partially truncated in text extraction; refer to chap4.pdf p.14 for exact form -->

**FEXT peak (at $t = \text{TD}_{\text{even}}$):**

$$|V_4(\text{TD}_{\text{even}})| = V_{\max} \cdot \min\!\left(\frac{T_d}{t_r}, 1\right)$$

where $V_{\max} = \frac{Z_0}{Z_{\text{even}} + 2Z_0 + Z_{\text{odd}}} \cdot V_s$

*(chap4.pdf, p.14)*

---

## 4.6 Coupled Microstrip with Front-End Decoupling Capacitor *(pp.22–33)*

### Topology *(p.22)*
A capacitor $C_f$ is placed at the **near-end (source end)** of the quiet line.

### Design Concept *(p.24)*
The goal is to make $\text{TD}_{\text{even}} = \text{TDc}_{\text{odd}}$ by adding $C_f$:

The odd-mode time delay with $C_f$ added becomes:

$$\text{TDc}_{\text{odd}} = \ell\sqrt{(L_s - L_m)\left(C_s + 2C_m + \frac{2C_f}{\ell}\right)}$$

*(chap4.pdf, p.23)*

Setting $T_d = \text{TDc}_{\text{odd}} - \text{TD}_{\text{even}} = 0$ gives the required $C_f$.

**Example:** $T_d = 24.412$ ps → $C_f = 0.6$ pF (ideal line) *(p.25)*

### Effect on FEXT and NEXT *(pp.26–27)*

| Parameter | Baseline | With $C_f$ |
|---|---|---|
| $T_d$ (ideal) | 24.412 ps | 0 |
| FEXT peak (ideal) | 0.076 V | 0.027 V |
| NEXT peak (ideal) | 0.019 V | 0.080 V |

**Trade-off:** Adding $C_f$ suppresses FEXT but **increases NEXT** (because the front-end capacitor interacts with the odd-mode wave).

### Lossy line results *(pp.32–33)*:
- FEXT: simulation 0.0257 V, measurement 0.0268 V (baseline was 0.063/0.055 V)
- NEXT: simulation 0.0710 V, measurement 0.0636 V (baseline was 0.018/0.016 V)

---

## 4.7 Eye Diagram Comparison *(pp.34–36)*

Simulation with pseudo-random bit sequence (PRBS):

| Bit Rate | Baseline Eye Height | With $C_f$ Eye Height |
|---|---|---|
| 2 Gbps | 97.2% | 97.2% |
| 4 Gbps | 95.2% | 88.8% |
| 8 Gbps | 94.0% | 86.0% |
| 16 Gbps | 79.6% | 64.4% |

**Conclusion:** Eye diagram performance degrades with front-end $C_f$ at high bit rates. *(p.36)*

---

## 4.8 Distributed Decoupling Capacitors *(pp.39–40)*

Instead of a single lumped $C_f$, distribute $\Delta C_f$ capacitors **along the line**.

| Number of caps | Spacing | $\Delta C_f$ per cap | FEXT |
|---|---|---|---|
| 4 ($\lambda/2$) | every $\lambda/2$ | 0.125 pF | better |
| 8 ($\lambda/4$) | every $\lambda/4$ | 0.0625 pF | better |
| 20 ($\lambda/10$) | every $\lambda/10$ | 0.025 pF | ≈0 |

*(chap4.pdf, p.39)*

**S-parameter improvement:** Distributed caps restore the good transmission coefficient ($S_{13}$) and reduce reflections ($S_{11}$) that were degraded by the lumped front-end cap. *(pp.41–42)*

---

## 4.9 Summary *(p.43)*

| Method | FEXT (V meas/sim) | NEXT (V meas/sim) |
|---|---|---|
| Conventional | 0.055 / 0.063 | 0.016 / 0.018 |
| Front-end $C_f$ | 0.027 / 0.026 | 0.064 / 0.071 |
| Distributed $C_f$ | — / 0 | — / 0.028 |

- Front-end $C_f$: reduces FEXT but increases NEXT and degrades eye at high bit rate.
- Distributed $C_f$: restores eye quality and achieves near-zero FEXT with acceptable NEXT.
