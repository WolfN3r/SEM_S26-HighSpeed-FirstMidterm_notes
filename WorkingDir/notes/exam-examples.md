---
title: HSDSD Exam Prep — Key Formulas and Worked Examples
---

---

## Part 1 — Key Formula Sheet

### Chapter 1

| Formula | Meaning | Reference |
|---|---|---|
| $f_{\max} = 0.32/\tau_r$ | Highest frequency of interest | chap1.pdf p.6 |
| $T_D \geq t_r/10$ | TX line criterion | chap1.pdf p.7 |

### Chapter 2

| Formula | Meaning | Reference |
|---|---|---|
| $Z_0 = \sqrt{L/C}$ | Characteristic impedance (lossless) | chap2.pdf p.9 |
| $Z_0 \approx \frac{87}{\sqrt{\varepsilon_r+1.41}}\ln\!\frac{5.98H}{0.8W+T}$ | Microstrip impedance | chap2.pdf p.9 |
| $Z_0 \approx \frac{60}{\sqrt{\varepsilon_r}}\ln\!\frac{4H}{0.67\pi(T+0.8W)}$ | Symmetric stripline impedance | chap2.pdf p.10 |
| $v = c/\sqrt{\varepsilon_r}$, $\text{TD} = x\sqrt{\varepsilon_r}/c$ | Propagation velocity and delay | chap2.pdf p.11 |
| $\text{TD} = \sqrt{LC}$, $Z_0 = \sqrt{L/C}$ | Alternate forms → $L=\text{TD}\cdot Z_0$, $C=\text{TD}/Z_0$ | chap2.pdf p.11 |
| $\varepsilon_e = \frac{\varepsilon_r+1}{2}+\frac{\varepsilon_r-1}{2}(1+\frac{12H}{W})^{-1/2}+F-0.217(\varepsilon_r-1)\frac{T}{\sqrt{WH}}$ | Effective $\varepsilon$ for microstrip | chap2.pdf p.12 |
| Segments $\geq 10 \cdot \text{TD}/T_r$ | SPICE model segmentation | chap2.pdf p.14 |
| $V_i = V_s Z_0/(Z_0+Z_s)$ | Initial wave voltage | chap2.pdf p.17 |
| $\rho = (Z_t-Z_0)/(Z_t+Z_0)$ | Reflection coefficient | chap2.pdf p.18 |

### Chapter 3

| Formula | Meaning | Reference |
|---|---|---|
| $V_{\text{noise}} = L_m\,dI/dt$ | Inductive coupling noise | chap3.pdf p.4 |
| $I_{\text{noise}} = C_m\,dV/dt$ | Capacitive coupling noise | chap3.pdf p.5 |
| $A_{\text{NEXT}} = \frac{V_{\text{in}}}{4}(\frac{L_m}{L}+\frac{C_m}{C})$ | NEXT peak (matched, $T_r<2$TD) | chap3.pdf p.13 |
| $B_{\text{FEXT}} = -\frac{V_{\text{in}}X\sqrt{LC}}{2T_r}(\frac{L_m}{L}-\frac{C_m}{C})$ | FEXT peak (matched, $T_r<2$TD) | chap3.pdf p.13 |
| $Z_{\text{odd}}=\sqrt{(L_{11}-L_{12})/(C_{11}+C_m)}$ | Odd-mode impedance | chap3.pdf p.27 |
| $Z_{\text{even}}=\sqrt{(L_{11}+L_{12})/(C_{11}-C_m)}$ | Even-mode impedance | chap3.pdf p.29 |
| $K = L_{12}/\sqrt{L_{11}L_{22}}$ | Inductive coupling factor | chap3.pdf p.21 |

### Chapter 5

| Formula | Meaning | Reference |
|---|---|---|
| $\delta = \sqrt{\rho/(\pi F\mu)}$ | Skin depth | chap5.pdf p.6 |
| $R_{\text{ac}} \approx \sqrt{\rho\pi\mu F}(1/W+1/6H)$ | AC resistance, microstrip (approx) | chap5.pdf p.12 |
| $R_{\text{ac}} = R_S\sqrt{F}$ | AC resistance via surface resistance | chap5.pdf p.15 |
| $\tan\delta_d = \varepsilon''/\varepsilon'$ | Dielectric loss tangent | chap5.pdf p.21 |
| $G = \tan\delta_d \cdot 2\pi F C_{11}$ | Dielectric shunt conductance | chap5.pdf p.21 |
| $C_{90^\circ} \approx C_{11}\cdot w$ | Excess capacitance at 90$^\circ$ bend | chap5.pdf p.39 |

---

## Part 2 — Worked Example: Chapter 2

### Problem (from chap2.pdf, pp.37–43)

A driver ($Z_s = 30\,\Omega$, edge rate $t_r = 100$ ps, swing 0 to 2 V) drives a microstrip trace ($Z_0 = 50\,\Omega$, length 5 in., $\varepsilon_r = 4.0$, $T = 1.0$ mil, $W = 5$ mil).

**Step 1: Find H (trace height)**

Using $Z_0 = 50\,\Omega$ in the microstrip formula:

$$50 = \frac{87}{\sqrt{4.0+1.41}}\ln\!\frac{5.98H}{0.8(5)+1.0} \implies H = 3.2 \text{ mils}$$

*(chap2.pdf, p.39)*

**Step 2: Find effective $\varepsilon_e$**

$W/H = 5/3.2 = 1.5625 > 1$, so $F = 0$.

$$\varepsilon_e = \frac{4+1}{2}+\frac{4-1}{2}\left(1+\frac{12(3.2)}{5}\right)^{-1/2}+0-0.217(4-1)\frac{1.0}{\sqrt{5.0\times3.2}} = 2.84$$

*(chap2.pdf, p.40)*

**Step 3: Find propagation velocity and TD**

$$v = \frac{3\times10^8}{\sqrt{2.84}} = 1.78\times10^8 \text{ m/s}$$

$$\text{TD} = \frac{5\text{ in.}\times 0.0254\text{ m/in.}}{1.78\times10^8\text{ m/s}} = 713\text{ ps}$$

*(chap2.pdf, p.40)*

**Step 4: Determine wave shape (lattice diagram)**

Initial voltage: $V_i = 2 \times 50/(50+30) = 1.25$ V

$\rho_{\text{load}} = (∞-50)/(∞+50) = +1$ (open load assumed)

At $t = \text{TD}$: load sees $1.25 + 1.25(+1) = 2.5$ V

$\rho_{\text{source}} = (30-50)/(30+50) = -0.25$

At $t = 2\text{TD}$: source reflection = $1.25\times(-0.25) = -0.3125$ V, so source sees $1.25 - 0.3125 = 0.9375$ V above steady state.

Steady state = $2 \times \infty/(\infty+30) \approx 2$ V (for open load). The ringing settles at 2 V.

*(chap2.pdf, p.41)*

**Step 5: Number of SPICE segments**

Since $t_r < 2\text{TD}$ ($100\text{ ps} < 1426\text{ ps}$), reflections matter:

$$N \geq 10\left(\frac{713\text{ ps}}{100\text{ ps}}\right) = 71.3 \implies \text{use }72$$

*(chap2.pdf, p.42)*

---

## Part 3 — Worked Example: Chapter 3

### Problem (from chap3.pdf, pp.17–18 — Example 3.2)

Two coupled lines: $Z_0 = 70\,\Omega$, both ends terminated at 70 Ω, $V_{\text{in}} = 1.0$ V, $T_r = 100$ ps, length $X = 2$ in.

Given matrices:
$$[L] = \begin{bmatrix} L_{11} & L_m \\ L_m & L_{11} \end{bmatrix} \text{nH/in.}, \quad [C] = \begin{bmatrix} C_{11} & -C_m \\ -C_m & C_{11} \end{bmatrix} \text{pF/in.}$$

(Numerical values read from slide; extracted text was partially corrupted — see chap3.pdf p.17 for exact matrix values.)

**NEXT:**
$$A_{\text{NEXT}} = \frac{1.0}{4}\left(\frac{L_m}{L_{11}} + \frac{C_m}{C_{11}}\right)$$

Check $T_r = 100\text{ ps}$ vs. $2\text{TD}$ to determine which formula applies.

**FEXT:**
$$B_{\text{FEXT}} = -\frac{1.0 \times 2\text{ in.}\sqrt{L_{11}C_{11}}}{2\times100\text{ ps}}\left(\frac{L_m}{L_{11}} - \frac{C_m}{C_{11}}\right)$$

*(chap3.pdf, p.18)*

---

## Part 4 — Worked Example: Chapter 5

### Problem (from chap5.pdf, pp.23–27)

Stripline: $W = 5$ mil, $H_1 = H_2 = 10$ mil, $t = 0.63$ mil, $\varepsilon_r = 4.0$.

**Step 1: Find $R_S$ (surface resistance)**

For copper: $\rho = 1.72\times10^{-8}$ Ω·m, $\mu = \mu_0 = 4\pi\times10^{-7}$ H/m.

$$R_S = \sqrt{\rho\pi\mu} = \sqrt{1.72\times10^{-8}\times\pi\times4\pi\times10^{-7}}$$

*(chap5.pdf, p.24)*

**Step 2: Frequency where $\delta = t$**

$$\delta = t = 0.63\text{ mil} = 16\,\mu\text{m} \implies F_{\text{skin}} = \frac{\rho}{\pi\mu\delta^2}$$

Below this frequency: $R = R_{\text{DC}}$. Above: $R \propto \sqrt{F}$. This crossover is ~17 MHz for copper with this geometry.

*(chap5.pdf, p.26)*

**Step 3: AC resistance at 400 MHz**

$$R_{\text{ac}} = R_S\sqrt{400\times10^6} \times \frac{1}{W} + \frac{1}{W_{\text{ground}}}$$

*(chap5.pdf, p.27)*

**Step 4: Shunt conductance at 400 MHz**

From $\text{PD} = \sqrt{\varepsilon_r}/c$:  
$C_{11} = \text{PD}/Z_0 = \ldots$ pF/m

$$G = \tan\delta \times 2\pi \times 400\times10^6 \times C_{11}$$

*(chap5.pdf, p.27)*

---

## Part 5 — Quick Reference: Common Pitfalls

1. **Don't confuse $T_r < 2$TD with $T_r > 2$TD** for NEXT. Only in the long-line case ($T_r < 2$TD) is NEXT length-independent.

2. **Odd mode = underdriven** (lower $Z$); **even mode = overdriven** (higher $Z$). Remember: $Z_{\text{odd}} < Z_0 < Z_{\text{even}}$.

3. **FEXT = 0 in striplines** (both modes travel at the same speed). FEXT ≠ 0 in microstrips.

4. **Surface resistance $R_S$** is in Ω·√s/square — it does not have units of Ω alone. $R_{\text{ac}} = R_S\sqrt{F}$.

5. **Segments formula uses TD and $T_r$** — not just the physical length. Always check the ratio.

6. **$\varepsilon_e$ in microstrip** uses $\varepsilon_r$ (the bulk value), not the effective value — don't iterate.

7. **AC load termination**: $R = Z_0$ AND $RC_L = 1\text{–}2\tau_r$ — both conditions must be met.
