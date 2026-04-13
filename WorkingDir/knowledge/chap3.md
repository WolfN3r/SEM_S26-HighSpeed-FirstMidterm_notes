# Crosstalk

> Source: `chap3_HSDSD.pdf`  
> Instructor: Chun-Long Wang, National Taiwan University of Science and Technology

---

## 3.1 Introduction *(p.3)*

**Crosstalk** is the unwanted coupling of energy from one signal line (the **aggressor/driver**) onto an adjacent line (the **victim**).

**Two effects:**
1. Changes impedance and propagation velocity → affects system timing and signal integrity.
2. Induces noise voltage/current on the victim line → degrades noise margins.

**Depends on:** data patterns, line-to-line spacing, and switching rates.

---

## 3.2 Mutual Inductance *(p.4)*

Magnetic-field coupling between lines is modelled by **mutual inductance $L_m$**.

When the aggressor carries a changing current, a voltage noise is induced on the victim:

$$V_{\text{noise},L_m} = L_m \frac{dI_{\text{driver}}}{dt}$$

*(chap3.pdf, p.4)*

---

## 3.3 Mutual Capacitance *(p.5)*

Electric-field coupling between lines is modelled by **mutual capacitance $C_m$**.

When the aggressor has a changing voltage, a current noise is injected onto the victim:

$$I_{\text{noise},C_m} = C_m \frac{dV_{\text{driver}}}{dt}$$

*(chap3.pdf, p.5)*

---

## 3.4 Inductance and Capacitance Matrices *(pp.6–8)*

For an $N$-conductor system, the parasitics are described by matrices.

### Inductance matrix:

$$[L] = \begin{bmatrix} L_{11} & L_{12} & \cdots \\ L_{21} & L_{22} & \cdots \\ \vdots & & \ddots \end{bmatrix}$$

- $L_{NN}$: self-inductance of line $N$
- $L_{MN}$: mutual inductance between lines $M$ and $N$

*(chap3.pdf, p.6)*

### Capacitance matrix:

$$[C] = \begin{bmatrix} C_{11} & C_{12} & \cdots \\ C_{21} & C_{22} & \cdots \\ \vdots & & \ddots \end{bmatrix}$$

- $C_{NN}$: total capacitance seen by line $N$ (capacitance to ground + all mutual capacitances)
- $C_{NM} = -C_m$ (mutual capacitance; negative off-diagonal)

*(chap3.pdf, p.7)*

### Two-conductor example *(p.8)*:

For two lines with mutual capacitance $C_m$ between them and ground capacitances:
$$C_{11} = C_{22} = C_{\text{self}} + C_m, \quad C_{12} = C_{21} = -C_m$$

$C_m$ is obtained by grounding line 2 and measuring charge on line 1.

---

## 3.5 Field Simulators *(pp.9–10)*

| Type | Speed | Accuracy | Use |
|---|---|---|---|
| **Electrostatic (2D)** | Fast (seconds) | Limited to simple geometries, no skin effect | Early design |
| **Full-wave (3D)** | Slow (hours–days) | Handles complex geometry, frequency-dependent losses, dispersion, radiation | Final verification |

Full-wave output is typically in **S-parameters** — less directly useful for digital interconnect simulation.

---

## 3.6 Near-End and Far-End Crosstalk *(pp.11–12)*

**Near-End Crosstalk (NEXT / Backward Crosstalk):** measured at the **driven end** of the victim line. Current is the **sum** of inductance- and capacitance-induced components:

$$I_{\text{near}} = I(L_m) + I_{\text{near}}(C_m)$$

*(chap3.pdf, p.11)*

**Far-End Crosstalk (FEXT / Forward Crosstalk):** measured at the **far end** of the victim line. Current is the **difference**:

$$I_{\text{far}} = I_{\text{far}}(C_m) - I(L_m)$$

*(chap3.pdf, p.11)*

**Timing:**
- NEXT begins at $t=0$, duration = $2\,\text{TD}$
- FEXT occurs at $t=\text{TD}$, duration $\approx \tau_r$ (rise/fall time)

*(chap3.pdf, p.12)*

---

## 3.7 Crosstalk Magnitudes — Matched Terminations *(pp.13–14)*

For matched terminations ($R = Z_0$ at both ends), $\text{TD} = X\sqrt{LC}$, where $X$ = line length, $L$, $C$ = self-inductance and capacitance per unit length.

### Case: $T_r < 2\text{TD}$ (long-line case)

**NEXT peak amplitude:**

$$A_{\text{NEXT}} = \frac{V_{\text{input}}}{4}\left(\frac{L_m}{L} + \frac{C_m}{C}\right)$$

*(chap3.pdf, p.13)*

**FEXT peak amplitude:**

$$B_{\text{FEXT}} = -\frac{V_{\text{input}} \cdot X\sqrt{LC}}{2T_r}\left(\frac{L_m}{L} - \frac{C_m}{C}\right)$$

*(chap3.pdf, p.13)*

**Key insight:** In the long-line case, NEXT is **independent of line length**, while FEXT **always depends on rise time and length**.

### Case: $T_r > 2\text{TD}$ (short-line case)

NEXT fails to reach maximum amplitude → multiply NEXT by $2\text{TD}/T_r$.  
FEXT equations remain unchanged. *(p.14)*

---

## 3.8 Mismatched Terminations *(p.15)*

When the victim line termination $R \neq Z_0$, reflections add to the crosstalk:

$$V_x = V_{\text{crosstalk}} \cdot \frac{1 + \rho}{1}$$

where $\rho = (R - Z_0)/(R + Z_0)$ and $V_x$ is the adjusted near- or far-end noise. *(p.15)*

---

## 3.9 Example 3.2 — Matched Terminations *(pp.17–18)*

$Z_0 \approx 70\,\Omega$, $R = 70\,\Omega$, $V_{\text{in}} = 1.0$ V, $T_r = 100$ ps, $X = 2$ in.

From L and C matrices given:

$$A_{\text{NEXT}} = \frac{V_{\text{in}}}{4}\left(\frac{L_m}{L} + \frac{C_m}{C}\right), \quad B_{\text{FEXT}} = -\frac{V_{\text{in}} X\sqrt{LC}}{2T_r}\left(\frac{L_m}{L} - \frac{C_m}{C}\right)$$

*(chap3.pdf, pp.17–18)*

---

## 3.10 SPICE Equivalent Circuit Model for Coupled Lines *(pp.20–23)*

For a pair of coupled lines, the **mutual inductance** is modelled by a coupling factor $K$:

$$K = \frac{L_{12}}{\sqrt{L_{11} L_{22}}}$$

*(chap3.pdf, p.21)*

### Example 3.4 — Coupled Line Model *(pp.21–23)*

Given: 5 in. long coupled lines, $T_r = 100$ ps. Key results:
- Minimum segments: $\geq 10(x/v)/T_r$ → 67 segments
- Per-segment values: $L(N)$, $C_{1g}(N) = C_{11} - C_m$, $C_m(N)$ computed by scaling by $5/67$ in./segment

*(chap3.pdf, pp.22–23)*

---

## 3.11 Odd Mode Propagation *(pp.24–27)*

When two adjacent lines carry **opposite-polarity signals** ($I_2 = -I_1$, $V_2 = -V_1$):

- **Odd-mode inductance** (reduced):

$$L_{\text{odd}} = L_{11} - L_m = L_{11} - L_{12}$$

*(chap3.pdf, p.25)*

- **Odd-mode capacitance** (increased):

$$C_{\text{odd}} = C_{11} + C_m$$

*(chap3.pdf, p.26)*

- **Odd-mode characteristic impedance** (reduced):

$$Z_{\text{odd}} = \sqrt{\frac{L_{\text{odd}}}{C_{\text{odd}}}} = \sqrt{\frac{L_{11} - L_{12}}{C_{11} + C_m}}$$

*(chap3.pdf, p.27)*

- **Odd-mode time delay:**

$$\text{TD}_{\text{odd}} = \sqrt{L_{\text{odd}} C_{\text{odd}}} = \sqrt{(L_{11} - L_{12})(C_{11} + C_m)}$$

*(chap3.pdf, p.27)*

**Effect:** $Z_s = Z_0 > Z_{\text{odd}}$ → **underdriven** condition.

---

## 3.12 Even Mode Propagation *(pp.28–29)*

When two adjacent lines carry **same-polarity signals** ($I_1 = I_2$, $V_1 = V_2$):

- **Even-mode inductance** (increased):

$$L_{\text{even}} = L_{11} + L_{12}$$

*(chap3.pdf, p.28)*

- **Even-mode capacitance** (reduced):

$$C_{\text{even}} = C_{11} - C_m$$

*(chap3.pdf, p.29)*

- **Even-mode characteristic impedance** (increased):

$$Z_{\text{even}} = \sqrt{\frac{L_{11} + L_{12}}{C_{11} - C_m}}$$

*(chap3.pdf, p.29)*

- **Even-mode time delay:**

$$\text{TD}_{\text{even}} = \sqrt{(L_{11} + L_{12})(C_{11} - C_m)}$$

*(chap3.pdf, p.29)*

**Effect:** $Z_s = Z_0 < Z_{\text{even}}$ → **overdriven** condition.

---

## 3.13 Summary: Odd vs. Even Mode *(pp.31–32)*

| Property | Odd Mode | Even Mode |
|---|---|---|
| Signals | Opposite polarity | Same polarity |
| $L_{\text{eff}}$ | $L_{11} - L_{12}$ (reduced) | $L_{11} + L_{12}$ (increased) |
| $C_{\text{eff}}$ | $C_{11} + C_m$ (increased) | $C_{11} - C_m$ (reduced) |
| $Z$ | Reduced ($<Z_0$) | Increased ($>Z_0$) |
| Driving condition | Underdriven | Overdriven |
| Time delay | Not obvious (TD may change either way) | Not obvious |

**Crosstalk does not induce velocity variations in a stripline**, but **does** in a microstrip. *(p.32)*

---

## 3.14 Single-Line Equivalent Model (SLEM) *(pp.33–35)*

For a multiconductor system, find the equivalent $L$ and $C$ seen by the target line (line 2), considering neighbors switching in phase or out of phase.

**One signal out of phase with neighbors 1 and 3:**

$$C_{\text{eq}} = C_{22} - C_{12} + C_{23}, \quad L_{\text{eq}} = L_{22} + L_{12} - L_{23}$$

*(chap3.pdf, p.34)*

**Rules for SLEM:**
- Nearest neighbors have greatest effect (mutual parasitics fall off exponentially).
- Common mode (all in phase) and differential mode (target out of phase) give worst-case impedance and velocity variations.
- SLEM accuracy degrades when edge-to-edge spacing/height ratio < 1. *(p.35)*

---

## 3.15 Crosstalk Trends *(pp.36–38)*

- **Lower-impedance** lines → better EM field confinement → less crosstalk-induced impedance variation.
- Mutual parasitics ($L_m$, $C_m$) fall off **exponentially** with trace-to-trace spacing.
- Even an undriven adjacent trace influences the impedance of a driven line.

---

## 3.16 Termination of Odd/Even Mode Line Pairs *(pp.39–40)*

### Pi-Termination Network:
- Even mode: $Z_{\text{even}} = 2R_3 \| R_1$ (parallel $R_1$ and two $R_3$ in series)
- Odd mode: $Z_{\text{odd}} = (1/2 R_3) \| R_1$

### T-Termination Network:
- Odd mode: $Z_{\text{odd}} = R_1$
- Even mode: $Z_{\text{even}} = R_1 + 2R_3$

*(chap3.pdf, pp.39–40)*

---

## 3.17 Minimization of Crosstalk — Rules of Thumb *(pp.41–42)*

1. **Widen spacing** $S$ between lines as much as routing allows.
2. **Minimize height $H$** above ground plane (tight coupling to ground → less coupling to neighbors). While keeping target impedance.
3. Use **differential routing** for critical nets (e.g., system clock).
4. Route signals on different layers **orthogonally** to each other.
5. Use **stripline or embedded microstrip** to eliminate velocity variations.
6. **Minimize parallel run lengths** between coupled nets.
7. Place components to minimize trace congestion.
8. Use **slower edge rates** (with caution — negative side effects on timing).
