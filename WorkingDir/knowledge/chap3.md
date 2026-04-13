# Chapter 3: Crosstalk

## Outline
- Mutual Inductance and Mutual Capacitance
- Inductance and Capacitance Matrix
- Field Simulators
- Crosstalk-Induced Noise
- Simulating Crosstalk Using Equivalent Circuit Models
- Crosstalk-Induced Flight Time and Signal Integrity Variations
- Crosstalk Trends
- Termination of Odd- and Even-Mode Transmission Line Pairs
- Minimization of Crosstalk
- Additional Examples

---

## 1. Introduction

### 1.1 Influences of Crosstalk
*(chap3.pdf, p.3)*

**Disadvantages:**
1. Crosstalk changes the **impedance** and **propagation velocity** of a line → adversely affects system-level timing and signal integrity
2. Crosstalk **induces noise** onto neighboring lines → degrades signal integrity and reduces noise margins

**Influence Factors:** Data patterns, line-to-line spacing, and switching rates.

---

## 2. Mutual Inductance and Mutual Capacitance

### 2.1 Mutual Inductance
*(chap3.pdf, p.4)*

- The coupling of current via the **magnetic field** is modeled by mutual inductance $L_m$
- $L_m$ injects a **voltage noise** onto the victim line proportional to the **rate of change of current** on the driver line:

$$V_{\text{noise},L_m} = L_m \frac{dI_\text{driver}}{dt}$$
*(chap3.pdf, p.4)*

### 2.2 Mutual Capacitance
*(chap3.pdf, p.5)*

- The coupling due to the **electric field** is modeled by mutual capacitance $C_m$
- $C_m$ injects a **current noise** onto the victim line proportional to the **rate of change of voltage** on the driver line:

$$I_{\text{noise},C_m} = C_m \frac{dV_\text{driver}}{dt}$$
*(chap3.pdf, p.5)*

---

## 3. Inductance and Capacitance Matrix

### 3.1 Introduction
*(chap3.pdf, p.6)*

The inductance and capacitance matrices are collectively called the **transmission line matrices**.

### 3.2 Inductance Matrix
*(chap3.pdf, p.6)*

For an $N$-conductor system:

$$\text{Inductance matrix} = \begin{bmatrix} L_{11} & L_{12} & \cdots & L_{1N} \\ L_{21} & L_{22} & & \\ \vdots & & \ddots & \\ L_{N1} & & & L_{NN} \end{bmatrix}$$
*(chap3.pdf, p.6)*

- $L_{NN}$: **self-inductance** of line $N$
- $L_{MN}$: **mutual inductance** between lines $M$ and $N$

### 3.3 Capacitance Matrix
*(chap3.pdf, p.7)*

$$\text{Capacitance matrix} = \begin{bmatrix} C_{11} & C_{12} & \cdots & C_{1N} \\ C_{21} & C_{22} & & \\ \vdots & & \ddots & \\ C_{N1} & & & C_{NN} \end{bmatrix}$$
*(chap3.pdf, p.7)*

- $C_{NN}$: **total capacitance seen by line $N$** = capacitance to ground + all mutual capacitances to other lines
- $C_{NM}$: **mutual capacitance** between conductors $N$ and $M$

### 3.4 Example 3.1: Two-Conductor TX Line Matrices
*(chap3.pdf, p.8)*

For a two-conductor system, the charge-voltage relation is:

$$\begin{bmatrix} Q_1 \\ Q_2 \end{bmatrix} = \begin{bmatrix} C_{11} & C_{12} \\ C_{21} & C_{22} \end{bmatrix} \begin{bmatrix} V_1 \\ V_2 \end{bmatrix}$$
*(chap3.pdf, p.8)*

Key relationships:
- $C_{11} = C_{1g} + C_m$ (self-capacitance: capacitance to ground + mutual)
- $C_{12} = C_{21} = -C_m$ (mutual capacitance is negative in this convention)

$C_{11}$ is obtained by setting $V_2 = 0$ (grounding line 2).

The inductance matrix is:
$$\text{Inductance matrix} = \begin{bmatrix} L_{11} & L_{12} \\ L_{21} & L_{22} \end{bmatrix}$$
*(chap3.pdf, p.8)*

> **Figure description (p.8):** Cross-section diagram showing two adjacent signal traces above a ground plane. Mutual capacitor $C_m$ connects the two traces; $C_{1g}$ and $C_{2g}$ are individual capacitances to the ground plane.

---

## 4. Field Simulators

### 4.1 Electrostatic (2D) Simulators
*(chap3.pdf, p.9)*

- **Advantages:** Very easy to use; fast computation
- **Disadvantages:**
  - Only simulate relatively simple geometries
  - Based on static electric field calculations
  - Do not calculate frequency-dependent effects (internal inductance, skin-effect resistance)
  - Alternative methods exist for frequency-dependent R and L

### 4.2 Full-Wave (3D) Simulators
*(chap3.pdf, p.10)*

- **Advantages:**
  - Simulate complex 3D geometries
  - Predict frequency-dependent losses, internal inductance, dispersion, radiation, and most other EM phenomena
- **Disadvantages:**
  - Very difficult to use; simulations take **hours or days**
  - Output is often S-parameters, which are **not directly useful** for digital interconnect simulations

---

## 5. Crosstalk-Induced Noise

### 5.1 NEXT and FEXT Categories
*(chap3.pdf, p.11)*

**Near-End Crosstalk (NEXT) — Backward Crosstalk:**

$$I_\text{near} = I(L_m) + I_\text{near}(C_m)$$
*(chap3.pdf, p.11)*

The near-end current is the **sum** of inductance-induced and capacitance-induced currents.

**Far-End Crosstalk (FEXT) — Forward Crosstalk:**

$$I_\text{far} = I_\text{far}(C_m) - I(L_m)$$
*(chap3.pdf, p.11)*

The far-end current is the **difference** of capacitance-induced and inductance-induced currents.

> **Figure description (p.11):** Two parallel traces (Line 1 = driver, Line 2 = victim). Driver current flows right on Line 1. Mutual capacitance $C_m$ (or $C_{12}$) connects the two lines. Arrows on Line 2 show: $I(L_m)$ directed backward (near end), $I_\text{near}(C_m)$ directed backward, and $I_\text{far}(C_m)$ directed forward (far end).

### 5.2 Timing of Crosstalk Pulses
*(chap3.pdf, p.12)*

- **Near-end crosstalk:** begins at $t = 0$, duration = $2\,\text{TD}$ (twice the electrical length of the line)
- **Far-end crosstalk:** occurs at $t = \text{TD}$, duration ≈ signal rise or fall time

The magnitude and shape depend on the amount of coupling and the termination.

> **Figure description (p.12):** Three snapshots of the coupled two-line system showing wave propagation. (Top) Signal injected at beginning: near-end crosstalk pulse propagates backward, far-end crosstalk pulse propagates forward. (Middle) Signal at midpoint (t = TD/2): partial crosstalk pulses visible. (Bottom) Signal at end (t = TD): far-end crosstalk arrives at far end.

### 5.3 Matched Terminations — When $T_r < 2\,\text{TD}$
*(chap3.pdf, p.13)*

For matched terminations ($R = Z_0$ at both ends):

$$\text{TD} = X\sqrt{LC}$$
*(chap3.pdf, p.13)*

where $X$ = line length, $L$ and $C$ = self-inductance and capacitance per unit length.

**Case 1** (driver terminated, victim terminated at both ends — $R = Z_0$ everywhere):

Near-end magnitude:

$$A = \frac{V(\text{input})}{4}\left(\frac{L_M}{L} + \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

Far-end magnitude:

$$B = -\frac{V(\text{input})\,X\sqrt{LC}}{2T_r}\left(\frac{L_M}{L} - \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

**Case 2** (victim only terminated at far end — $R = Z_0$ at far end only):
$$A = \frac{V(\text{input})}{4}\left(\frac{L_M}{L} + \frac{C_M}{C}\right), \quad B = \frac{1}{2}C, \quad C = -\frac{V(\text{input})\,X\sqrt{LC}}{T_r}\left(\frac{L_M}{L} - \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

**Case 3** (victim not terminated at either end):
$$A = \frac{V(\text{input})}{2}\left(\frac{L_M}{L} + \frac{C_M}{C}\right), \quad B = \frac{V(\text{input})\,X\sqrt{LC}}{2T_r}\left(\frac{L_M}{L} - \frac{C_M}{C}\right), \quad C = \frac{V}{4}\left(\frac{L_M}{L} - \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

> **Figure description (p.13):** Left column: three circuit diagrams (Case 1, 2, 3) with different termination configurations. Right column: corresponding near-end V(near) and far-end V(far) waveforms for each case, showing trapezoidal pulses with widths $2X\sqrt{LC}$ (near end) and $X\sqrt{LC}$ (far end) labeled.

### 5.4 Matched Terminations — When $T_r > 2\,\text{TD}$
*(chap3.pdf, p.14)*

- **Near-end crosstalk** fails to reach its maximum amplitude → multiply by $2\,\text{TD}/T_r$:

$$V_\text{near,adjusted} = V_\text{near,max} \times \frac{2\,\text{TD}}{T_r}$$
*(chap3.pdf, p.14)*

- **Far-end crosstalk** equations do **not** need adjustment.

**Key conclusions:**
- Near-end magnitude is **independent of length** when $T_r < 2\,\text{TD}$ (long-line case)
- Far-end magnitude **always depends on rise time and length**

### 5.5 Mismatched Terminations — Only Victim Mismatched
*(chap3.pdf, p.15)*

When the victim termination $R \neq Z_0$, the crosstalk is modified by a reflection factor:

$$V_x = V_\text{crosstalk}\left(1 + \frac{R - Z_o}{R + Z_o}\right)$$
*(chap3.pdf, p.15)*

where:
- $V_x$: adjusted crosstalk at near or far end of victim line
- $R$: termination impedance
- $Z_0$: characteristic impedance of TX line
- $V_\text{crosstalk}$: matched-case crosstalk value

> Note: Near-end noise is modified by the reflection coefficient at the near end; far-end noise is modified by the reflection coefficient at the far end.

### 5.6 Example 3.2: Matched Terminations
*(chap3.pdf, p.17–18)*

**Given:** $Z_0 \approx 70\,\Omega$, termination resistors $= 70\,\Omega$, $V(\text{input}) = 1.0\,\text{V}$, $T_r = 100\,\text{ps}$, $X = 2\,\text{in.}$

$$L/\text{in.} = \begin{bmatrix} 9.869\,\text{nH} & 2.103\,\text{nH} \\ 2.103\,\text{nH} & 9.869\,\text{nH} \end{bmatrix}, \quad C/\text{in.} = \begin{bmatrix} 2.051\,\text{pF} & -0.239\,\text{pF} \\ -0.239\,\text{pF} & 2.051\,\text{pF} \end{bmatrix}$$
*(chap3.pdf, p.17)*

**Near-end crosstalk (Case 1):**

$$V(1) = \frac{V(\text{input})}{4}\left[\frac{L_M}{L} + \frac{C_M}{C}\right] = \frac{1}{4}\left(\frac{2.103\,\text{nH}}{9.869\,\text{nH}} + \frac{0.239\,\text{pF}}{2.051\,\text{pF}}\right) = 0.082\,\text{V}$$
*(chap3.pdf, p.18)*

**Far-end crosstalk (Case 1):**

$$V(2) = -\frac{V(\text{input})\,X\sqrt{LC}}{2T_r}\left[\frac{L_M}{L} - \frac{C_M}{C}\right] = -0.137\,\text{V}$$
*(chap3.pdf, p.18)*

### 5.7 Example 3.3: Mismatched Victim Terminations
*(chap3.pdf, p.19)*

**Given:** Same setup as Example 3.2, but $R_1 = 45\,\Omega$ (near end), $R_2 = 100\,\Omega$ (far end)

$$Z_o = \sqrt{\frac{L_{11}}{C_{11}}} = \sqrt{\frac{9.869\,\text{nH}}{2.051\,\text{pF}}} = 69.4\,\Omega$$
*(chap3.pdf, p.19)*

$$V(1) = 0.082\left(1 + \frac{45 - 69.4}{45 + 69.4}\right) = 0.0645\,\text{V}$$
*(chap3.pdf, p.19)*

$$V(2) = -0.137\left(1 + \frac{100 - 69.4}{100 + 69.4}\right) = -0.162\,\text{V}$$
*(chap3.pdf, p.19)*

---

## 6. Simulating Crosstalk Using Equivalent Circuit Models

### 6.1 N-Segment Coupled Line Model
*(chap3.pdf, p.20)*

An $N$-segment SPICE model for coupled lines includes:
- Line a (upper): $L_a$, $C_a$, $R_a$, $G_a$ per segment
- Line b (lower): $L_b$, $C_b$, $R_b$, $G_b$ per segment
- Mutual coupling capacitors $C_m$ between lines at each node
- Inductive coupling represented by coupling factor $K$

> **Figure description (p.20):** Schematic of N-segment coupled-line model. Upper trace has series $L_a$, shunt $C_a \parallel G_a$, series $R_a$ per segment. Lower trace similarly. Between the two traces: $C_m$ capacitors at each node. Mutual inductor coupling $K_1 \ldots K_N$ shown between inductors of the two lines.

### 6.2 Inductive Coupling Factor K
*(chap3.pdf, p.21)*

The mutual inductance is modeled as a coupling factor:

$$K = \frac{L_{12}}{\sqrt{L_{11} L_{22}}}$$
*(chap3.pdf, p.21)*

where $L_{12}$ = mutual inductance between lines 1 and 2.

### 6.3 Example 3.4: Creating a Coupled Line Model
*(chap3.pdf, p.21–23)*

**Given:** 5 in. long coupled pair, rise time $= 100\,\text{ps}$

$$C/\text{in.} = \begin{bmatrix} 2\,\text{pF} & -0.1\,\text{pF} \\ -0.1\,\text{pF} & 2\,\text{pF} \end{bmatrix}, \quad L/\text{in.} = \begin{bmatrix} 9\,\text{nH} & 0.7\,\text{nH} \\ 0.7\,\text{nH} & 9\,\text{nH} \end{bmatrix}$$
*(chap3.pdf, p.21)*

**Characteristic impedance:**

$$Z_o = \sqrt{\frac{L_{11}}{C_{11}}} = \sqrt{\frac{9\,\text{nH}}{2\,\text{pF}}} = 67.09\,\Omega$$
*(chap3.pdf, p.22)*

**Total propagation delay:**

$$\text{TD} = \sqrt{L_{11}C_{11}} = \sqrt{(9\,\text{nH})(2\,\text{pF})} = 134\,\text{ps/in.} \times 5\,\text{in.} = 670\,\text{ps}$$
*(chap3.pdf, p.22)*

**Inductive coupling factor:**

$$K = \frac{L_{12}}{\sqrt{L_{11}L_{22}}} = \frac{0.7\,\text{nH}}{9\,\text{nH}} = 0.078$$
*(chap3.pdf, p.22)*

**Number of segments:**

$$N = \text{segments} = 10\frac{X}{vT_r} = 10\frac{(5\,\text{in.})(134\,\text{ps/in.})}{100\,\text{ps}} = 67$$
*(chap3.pdf, p.23)*

**Per-segment values** (multiply by $5/67$ in./segment):
- $L(N) = 0.67\,\text{nH}$
- $C_{1g}(N) = C_{11}(N) - C_m(N) = 0.1425\,\text{pF}$
- $C_m(N) = 0.0075\,\text{pF}$

---

## 7. Crosstalk-Induced Flight Time and Signal Integrity Variations

### 7.1 Odd-Mode Analysis
*(chap3.pdf, p.24–27)*

**Definition:** Odd mode — two lines carry **equal and opposite** signals: $I_2 = -I_1$, $V_2 = -V_1$

Applying KVL to the coupled inductor circuit ($L_{11} = L_{22} = L_0$):

$$V_1 = L_0 \frac{dI_1}{dt} + L_m \frac{dI_2}{dt}$$
*(chap3.pdf, p.24)*

Substituting odd-mode conditions:

$$V_1 = (L_0 - L_m)\frac{dI_1}{dt}$$
*(chap3.pdf, p.25)*

**Odd-mode inductance:**

$$L_\text{odd} = L_{11} - L_m = L_{11} - L_{12}$$
*(chap3.pdf, p.25)*

The odd mode inductance is **reduced**.

Applying KCL with $C_{1g} = C_{2g} = C_0$, for odd mode ($V_2 = -V_1$):

$$I_1 = (C_{1g} + 2C_m)\frac{dV_1}{dt}$$
*(chap3.pdf, p.26)*

**Odd-mode capacitance:**

$$C_\text{odd} = C_{1g} + 2C_m = C_{11} + C_m$$
*(chap3.pdf, p.26)*

The odd mode capacitance is **increased**.

**Odd-mode impedance and time delay:**

$$Z_\text{odd} = \sqrt{\frac{L_\text{odd}}{C_\text{odd}}} = \sqrt{\frac{L_{11} - L_{12}}{C_{11} + C_m}}$$
*(chap3.pdf, p.27)*

$$\text{TD}_\text{odd} = \sqrt{L_\text{odd} C_\text{odd}} = \sqrt{(L_{11} - L_{12})(C_{11} + C_m)}$$
*(chap3.pdf, p.27)*

The odd-mode characteristic impedance is **reduced**; time delay effect is not obvious.

### 7.2 Even-Mode Analysis
*(chap3.pdf, p.28–29)*

**Definition:** Even mode — two lines carry **identical** signals: $I_1 = I_2$, $V_1 = V_2$

Substituting even-mode conditions:

$$V_1 = (L_0 + L_m)\frac{dI_1}{dt}$$
*(chap3.pdf, p.28)*

**Even-mode inductance:**

$$L_\text{even} = L_{11} + L_m$$
*(chap3.pdf, p.28)*

The even mode inductance is **increased**.

For even-mode capacitance ($V_1 = V_2$, so $V_1 - V_2 = 0$, no current through $C_m$):

$$C_\text{even} = C_0 = C_{11} - C_m$$
*(chap3.pdf, p.29)*

The even mode capacitance is **reduced**.

**Even-mode impedance and time delay:**

$$Z_\text{even} = \sqrt{\frac{L_\text{even}}{C_\text{even}}} = \sqrt{\frac{L_{11} + L_{12}}{C_{11} - C_m}}$$
*(chap3.pdf, p.29)*

$$\text{TD}_\text{even} = \sqrt{L_\text{even} C_\text{even}} = \sqrt{(L_{11} + L_{12})(C_{11} - C_m)}$$
*(chap3.pdf, p.29)*

The even-mode impedance is **increased**; time delay effect is not obvious.

### 7.3 Field Patterns of Odd and Even Modes
*(chap3.pdf, p.30)*

> **Figure description (p.30):** Four diagrams showing field patterns. Top row (electric field): Odd mode — E-field lines bow between the two conductors (increased capacitance); Even mode — E-field lines go symmetrically to ground (decreased capacitance). Bottom row (magnetic field): Odd mode — two separate tight loops (decreased inductance); Even mode — one large combined loop (increased inductance).

### 7.4 Switching Pattern Effects on Performance
*(chap3.pdf, p.31)*

- **Odd mode:** $Z_S = Z_0 > Z_\text{odd}$ → **underdriven** behavior
- **Even mode:** $Z_S = Z_0 < Z_\text{even}$ → **overdriven** (ringing) behavior

> **Figure description (p.31):** Waveform plot showing V(source) and V(load) for three traces (V1, V2, V3). Even mode (all rising together): rises slowly and settles at 2 V (underdriven staircase). Odd mode (center trace out of phase): overshoot and ringing. Annotation: "Why does odd-mode arrive early?" — because reduced inductance leads to faster wave propagation in odd mode.

### 7.5 Conclusions on Odd/Even Mode Effects
*(chap3.pdf, p.32)*

1. **Odd-mode impedance** is always **lower** than the single-line $Z_0$
2. **Even-mode impedance** is always **higher** than the single-line $Z_0$
3. Time delay effects for odd/even mode are **not obvious** (opposite effects partially cancel)
4. Crosstalk **will** induce velocity variations in a **microstrip**
5. Crosstalk **will not** induce velocity variations in a **stripline**

### 7.6 Single-Line Equivalent Model (SLEM) — All Signals In Phase
*(chap3.pdf, p.33)*

For a three-line bus (lines 1, 2, 3) with all signals in phase (even mode with respect to center line 2):

$$Z_{2,\text{eff}} = \sqrt{\frac{L_{22} + L_{12} + L_{23}}{C_{22} - C_{12} - C_{23}}}$$
*(chap3.pdf, p.33)*

$$\text{TD}_{2,\text{eff}} = \sqrt{(L_{22} + L_{12} + L_{23})(C_{22} - C_{12} - C_{23})}$$
*(chap3.pdf, p.33)*

### 7.7 SLEM — One Signal Out of Phase
*(chap3.pdf, p.34)*

When line 2 is out of phase with its neighbors (differential mode — center bit different):

**Equivalent capacitance of conductor 2:**
- Even-mode $C$ with 1: $C_{22} - C_{12}$
- Odd-mode $C$ with 3: $C_{22} + C_{23}$
- Equivalent: $C_{22} - C_{12} + C_{23}$

**Equivalent inductance of conductor 2:**
- Even-mode $L$ with 1: $L_{22} + L_{12}$
- Odd-mode $L$ with 3: $L_{22} - L_{23}$
- Equivalent: $L_{22} + L_{12} - L_{23}$

$$Z_{2,\text{eff}} = \sqrt{\frac{L_{22} + L_{12} - L_{23}}{C_{22} - C_{12} + C_{23}}}$$
*(chap3.pdf, p.34)*

$$\text{TD}_{2,\text{eff}} = \sqrt{(L_{22} + L_{12} - L_{23})(C_{22} - C_{12} + C_{23})}$$
*(chap3.pdf, p.34)*

### 7.8 SLEM Conclusions
*(chap3.pdf, p.35)*

- **Nearest neighbors** have the greatest crosstalk effect; effects fall off **exponentially** with distance
- **SLEM** is a fast early-design tool; fully coupled simulations should always be done for the final design
- **Common mode** (all bits in phase) and **differential mode** (target bit out of phase with neighbors) produce the **worst-case** impedance and velocity variations
- SLEM accuracy falls off when edge-to-edge spacing/height ratio is less than 1

---

## 8. Crosstalk Trends

### 8.1 From Impedance Perspective
*(chap3.pdf, p.36)*

- **Lower-impedance traces** (wider trace or thinner dielectric) exhibit **less crosstalk-induced impedance variation**
- Lower-impedance lines confine the electromagnetic field more tightly to the ground plane → less coupling to adjacent signals
- Even when a line is not actively driven, its proximity to another trace **influences the impedance** of the active line (by increasing self-capacitance)

> **Figure description (p.36):** Graph of stripline impedance (ohms) vs. edge-to-edge spacing S (mils) for two line impedances (50 Ω and 65 Ω). Shows single-line $Z_0$, even-mode, and odd-mode curves diverging as spacing decreases. Higher-impedance lines show more variation.

### 8.2 From Mutual Inductance/Capacitance Perspective
*(chap3.pdf, p.37)*

- Mutual parasitics drop off **exponentially with spacing**
- Mutual inductance and capacitance for **lower-impedance lines are smaller** than for higher-impedance lines

> **Figure description (p.37):** Two graphs: left shows mutual inductance $L_m$ (nH/inch) vs. edge-to-edge spacing for 50 Ω (lower) and 65 Ω (higher) lines — both decrease exponentially, with higher-impedance lines having larger $L_m$. Right shows same for mutual capacitance $C_m$ (pF/inch) with similar trends.

### 8.3 Crosstalk Trends Summary
*(chap3.pdf, p.38)*

1. For a given dielectric constant, **low-impedance lines** produce **less impedance variation** from crosstalk
2. A single line's impedance is influenced by nearby traces even when they are **not actively driven**
3. Mutual parasitics fall off **exponentially** with trace-to-trace spacing

---

## 9. Termination of Odd- and Even-Mode Transmission Line Pairs

### 9.1 Pi-Termination Network
*(chap3.pdf, p.39)*

Circuit: Two parallel lines with $R_1$ (line 1 to ground), $R_2$ (line 2 to ground), and $R_3$ (between the two lines) at the load.

**Even mode** ($V_1 = V_2 = V_e$, no current through $R_3$):

$$R_1 = R_2 = Z_\text{even}$$
*(chap3.pdf, p.39)*

**Odd mode** ($V_1 = -V_2 = V_o$, $R_3$ splits as $\frac{1}{2}R_3$ to virtual ground):

$$Z_\text{odd} = \left(\frac{1}{2}R_3\right) \| R_1$$
*(chap3.pdf, p.39)*

Solving for $R_3$:

$$R_3 = \frac{2(Z_\text{even})(Z_\text{odd})}{Z_\text{even} - Z_\text{odd}}$$
*(chap3.pdf, p.39)*

> **Figure description (p.39):** Pi-termination schematic. Two lines connect to $R_1$ and $R_2$ (each to ground), with $R_3$ bridging between the two lines. A differential receiver is connected across the two lines. Below: equivalent odd-mode circuit showing the virtual ground at the midpoint of $R_3$.

### 9.2 T-Termination Network
*(chap3.pdf, p.40)*

Circuit: $R_1$ in series on line 1, $R_2$ in series on line 2, $R_3$ between the midpoints of the two series resistors (connected to ground/reference).

**Odd mode** ($V_1 = -V_2 = V_o$):

$$R_1 = R_2 = Z_\text{odd}$$
*(chap3.pdf, p.40)*

**Even mode** ($V_1 = V_2 = V_e$, no current through $R_3$):

$$Z_\text{even} = R_1 + 2R_3$$
*(chap3.pdf, p.40)*

Solving for $R_3$:

$$R_3 = \frac{1}{2}(Z_\text{even} - Z_\text{odd})$$
*(chap3.pdf, p.40)*

> **Figure description (p.40):** T-termination schematic. Series $R_1$ on line 1 and $R_2$ on line 2; $R_3$ bridges between the two series resistors to ground. Single-ended receivers at the output. Below: equivalent even-mode circuit showing $R_1 + 2R_3$ to ground.

---

## 10. Minimization of Crosstalk

### 10.1 Rules of Thumb
*(chap3.pdf, p.41–42)*

1. **Widen the spacing $S$** between lines as much as routing allows
2. **Minimize $H$** (trace height above ground plane) while achieving target impedance — couples the trace tightly to ground, reducing coupling to adjacent signals
3. Use **differential routing** for critical nets (e.g., system clock)
4. Route signals on **different layers orthogonal** to each other to reduce inter-layer coupling
5. Route on **stripline or embedded microstrip** to eliminate velocity variations due to crosstalk
6. **Minimize parallel run lengths** between signals; avoid long coupled sections
7. Place components to **minimize trace congestion**
8. Use **slower edge rates** (with caution — has negative timing consequences)

---

## 11. Additional Examples

### 11.1 8-Bit Bus Design Problem
*(chap3.pdf, p.43–50)*

**Setup:**
- U1 driver: $Z_s = 30\,\Omega$, swing $= 0\to 2\,\text{V}$
- PCB: 5 in. long traces, center-to-center spacing 15 mils, $Z_0 = 50\,\Omega$, $\varepsilon_r = 4.0$
- Stack-up: $W = 5\,\text{mils}$, $S = 10\,\text{mils}$, $T = 1.0\,\text{mil}$, $H = 3.2\,\text{mils}$
- Parasitics: $L_M = 0.54\,\text{nH/in.}$, $C_M = 0.079\,\text{pF/in.}$, $L_{11} = 7.13\,\text{nH/in.}$, $C_{11} = 2.85\,\text{pF/in.}$

*(chap3.pdf, p.43–45)*

**Goal 1: Maximum impedance variation (common mode and differential mode)**

**Common-mode propagation** (all 8 bits in phase):

$$Z_{2,\text{common}} = \sqrt{\frac{L_{22} + L_{12} + L_{23}}{C_{22} - C_{12} - C_{23}}} = \sqrt{\frac{7.13 + 0.54 + 0.54}{2.85 - 0.079 - 0.079}} = 55.26\,\Omega$$
*(chap3.pdf, p.47)*

$$\text{TD}_{2,\text{common}} = \sqrt{(7.13 + 0.54 + 0.54)(2.85 - 0.079 - 0.079)} = 148.6\,\text{ps/in.}$$
*(chap3.pdf, p.47)*

**Differential-mode propagation** (center bit out of phase with both neighbors):

$$Z_{2,\text{differential}} = \sqrt{\frac{L_{22} - L_{12} - L_{23}}{C_{22} + C_{12} + C_{23}}} = \sqrt{\frac{7.13 - 0.54 - 0.54}{2.85 + 0.079 + 0.079}} = 44.8\,\Omega$$
*(chap3.pdf, p.49)*

$$\text{TD}_{2,\text{differential}} = \sqrt{(7.13 - 0.54 - 0.54)(2.85 + 0.079 + 0.079)} = 135\,\text{ps/in.}$$
*(chap3.pdf, p.49)*

**Results:**

$$44.8\,\Omega < Z_o < 55.26\,\Omega$$
*(chap3.pdf, p.49)*

$$135\,\text{ps/in.} < \text{TD} < 148.6\,\text{ps/in.}$$
*(chap3.pdf, p.49)*

**Goal 2: Maximum velocity difference**

Velocity range corresponds to the TD range: $135\,\text{ps/in.}$ to $148.6\,\text{ps/in.}$

**Goal 3: Check for false triggering (common mode, overdriven)**

Using the higher common-mode impedance ($Z_0 = 55.26\,\Omega$), with $Z_s = 30\,\Omega$:

$$V_\text{initial} = V_s \frac{Z_o}{R_s + Z_o} = (2)\left(\frac{55}{30 + 55}\right) = 1.29\,\text{V}$$
*(chap3.pdf, p.50)*

$$\rho_\text{source} = \frac{30 - 55}{30 + 55} = -0.29, \quad \rho_\text{load} = \frac{\infty - 55}{\infty + 55} = 1$$
*(chap3.pdf, p.50)*

Lattice diagram shows the load voltage starts at $1.29\,\text{V}$ → jumps to $2.58\,\text{V}$ → oscillates but stays above 1 V.

**Conclusion:** No false triggers since the voltage never drops below $V_\text{TH} = 1\,\text{V}$.

> **Figure description (p.50):** Lattice diagram showing V(source) and V(load) for common-mode propagation. The load initially jumps to 2.58 V, then rings above 1.0 V. A worst-case waveform at U2 shows the load voltage vs. time — the undershoot at ~$3 \times 10^{-9}$ s is circled as the concern, but it stays above 1 V.

---

## Key Equations Summary

| Quantity | Formula | Page |
|----------|---------|------|
| Inductive crosstalk noise | $V_{\text{noise}} = L_m \frac{dI}{dt}$ | p.4 |
| Capacitive crosstalk noise | $I_{\text{noise}} = C_m \frac{dV}{dt}$ | p.5 |
| NEXT current | $I_\text{near} = I(L_m) + I_\text{near}(C_m)$ | p.11 |
| FEXT current | $I_\text{far} = I_\text{far}(C_m) - I(L_m)$ | p.11 |
| Near-end magnitude (matched, long line) | $A = \frac{V_\text{in}}{4}\left(\frac{L_M}{L} + \frac{C_M}{C}\right)$ | p.13 |
| Far-end magnitude (matched) | $B = -\frac{V_\text{in} X\sqrt{LC}}{2T_r}\left(\frac{L_M}{L} - \frac{C_M}{C}\right)$ | p.13 |
| Mismatched victim adjustment | $V_x = V_\text{crosstalk}\left(1 + \frac{R - Z_0}{R + Z_0}\right)$ | p.15 |
| Coupling factor K | $K = L_{12}/\sqrt{L_{11}L_{22}}$ | p.21 |
| Odd-mode inductance | $L_\text{odd} = L_{11} - L_{12}$ | p.25 |
| Odd-mode capacitance | $C_\text{odd} = C_{11} + C_m$ | p.26 |
| Odd-mode impedance | $Z_\text{odd} = \sqrt{(L_{11}-L_{12})/(C_{11}+C_m)}$ | p.27 |
| Even-mode inductance | $L_\text{even} = L_{11} + L_m$ | p.28 |
| Even-mode capacitance | $C_\text{even} = C_{11} - C_m$ | p.29 |
| Even-mode impedance | $Z_\text{even} = \sqrt{(L_{11}+L_{12})/(C_{11}-C_m)}$ | p.29 |
| Pi-termination center resistor | $R_3 = 2Z_\text{even}Z_\text{odd}/(Z_\text{even}-Z_\text{odd})$ | p.39 |
| T-termination bridge resistor | $R_3 = \frac{1}{2}(Z_\text{even} - Z_\text{odd})$ | p.40 |
