---
title: HSDSD Midterm Study Notes
subtitle: Chapters 1–5
date: 2026-04-13
---

# HSDSD Midterm Study Notes

---

# Chapter 1 — Why Interconnect Design Matters

## What is an Interconnect?

Any conductive path carrying a digital signal — PCB traces, chip packages, connectors, sockets — is called an **interconnect**. A group of interconnects sharing data forms a **bus**.

For the system to work correctly, the interconnect must deliver:
- **High voltage** above $V_{ih}$ (logic-high threshold)
- **Low voltage** below $V_{il}$ (logic-low threshold)

The region between $V_{il}$ and $V_{ih}$ is the **threshold region** — an undefined state. The narrower (shorter) the signal spends there, the more robust the system.

## When Does a Trace Become a Transmission Line?

In 100 ps, light travels ~30 mm in free space. PCB traces can be that long or longer, so the speed of light matters.

**Rule:** Any conductor $\geq \lambda/10$ (one-tenth of the wavelength at the highest significant frequency) must be treated as a transmission line.

In terms of timing:

$$T_D \geq \frac{t_r}{10} \implies \text{treat as TX line}$$

*(chap1.pdf, p.7)*

## Highest Frequency of Interest

For a trapezoidal signal with rise time $\tau_r$ (10–90%):

$$f_{\max} = \frac{0.32}{\tau_r}$$

*(chap1.pdf, p.6)*

Faster edges → higher $f_{\max}$ → shorter critical length → more interconnects behave as transmission lines.

## The Bottleneck Problem

Moore's Law predicts performance doubles every 18 months. As the processor core speeds up, the **bus** that feeds it must keep up. At high frequencies, effects like reflections, crosstalk, and conductor losses — collectively the subject of HSDSD — become the design challenge.

---

# Chapter 2 — Ideal Transmission Line Fundamentals

## Microstrip vs. Stripline

| Property | Microstrip | Stripline |
|---|---|---|
| Layer | Outer (surface) | Inner |
| Ground reference | One plane below | Planes above and below |
| Effective $\varepsilon_r$ | Smaller (partial air) | Larger (fully embedded) |
| Speed | Faster (smaller TD) | Slower (larger TD) |
| Crosstalk velocity variation | Yes | No |

## The RLCG Equivalent Circuit

A transmission line is modeled as a ladder of infinitesimal elements per unit length:

- **R** (Ω/m): conductor resistance (finite conductivity)
- **L** (H/m): magnetic-field energy storage
- **C** (F/m): electric-field energy storage
- **G** (S/m): dielectric leakage

The mode of propagation is **TEM** (Transverse Electromagnetic) — no E or H field components in the direction of propagation.

## Characteristic Impedance

For a lossless line (R = G = 0, valid for most practical cases):

$$Z_0 = \sqrt{\frac{L}{C}}$$

*(chap2.pdf, p.9)*

**Microstrip empirical formula** (valid for $0.1 < W/H < 2$, $1 < \varepsilon_r < 15$):

$$Z_0 \approx \frac{87}{\sqrt{\varepsilon_r + 1.41}} \ln\!\left(\frac{5.98H}{0.8W + T}\right) \quad \Omega$$

*(chap2.pdf, p.9)*

**Symmetric stripline empirical formula** (valid for $W/H < 0.35$, $T/H < 0.25$):

$$Z_0 \approx \frac{60}{\sqrt{\varepsilon_r}} \ln\!\left(\frac{4H}{0.67\pi(T + 0.8W)}\right) \quad \Omega$$

*(chap2.pdf, p.10)*

## Propagation Velocity and Time Delay

$$v = \frac{c}{\sqrt{\varepsilon_r}}, \quad \text{TD} = \frac{x\sqrt{\varepsilon_r}}{c} = \sqrt{LC}$$

*(chap2.pdf, p.11)*

where $c = 3 \times 10^8$ m/s, $x$ = line length.

**Effective dielectric constant for microstrip** (partial air exposure):

$$\varepsilon_e = \frac{\varepsilon_r+1}{2} + \frac{\varepsilon_r-1}{2}\left(1+\frac{12H}{W}\right)^{-1/2} + F - 0.217(\varepsilon_r-1)\frac{T}{\sqrt{WH}}$$

*(chap2.pdf, p.12)*

where $F = 0.02(\varepsilon_r-1)(1-W/H)^2$ for $W/H<1$, else $F=0$.

## SPICE Lumped Segment Model

To simulate a TX line in SPICE, break it into $N$ lumped-LC segments:

$$N \geq 10\left(\frac{x/v}{T_r}\right), \quad \text{TD}_{\text{seg}} = \sqrt{L_{\text{seg}}C_{\text{seg}}} \leq \frac{T_r}{10}$$

*(chap2.pdf, p.14)*

## Launching Waves and Reflections

When the source drives the line at $t=0$, the initial voltage is set by a voltage divider between the source impedance $Z_s$ and the line impedance $Z_0$:

$$V_i = V_s \frac{Z_0}{Z_0 + Z_s}$$

*(chap2.pdf, p.17)*

At any **junction** (impedance change), a reflection is generated:

$$\rho = \frac{Z_t - Z_0}{Z_t + Z_0}$$

*(chap2.pdf, p.18)*

**Key cases:**

| Load | $\rho$ | Behavior |
|---|---|---|
| Matched ($Z_t = Z_0$) | 0 | No reflection |
| Open ($Z_t = \infty$) | +1 | Wave doubles |
| Short ($Z_t = 0$) | −1 | Wave inverts |

## Lattice (Bounce) Diagrams

A visual tool tracking wave amplitude vs. time. Each step = one TD. After each bounce:
- Multiply reflected wave by $\rho$ at that end
- Add to cumulative voltage at that point

**Overdriven** ($Z_0 > Z_s$, i.e., $V_i > V_{ss}$): initial overshoot → ringing above steady state.  
**Underdriven** ($Z_0 < Z_s$, i.e., $V_i < V_{ss}$): gradual rise to steady state.

**Rise time effect:** When $\tau_r < 2\text{TD}$, reflections arrive before the input transition is complete — they appear as glitches.

## Reactive Loads

| Load | Initial behavior | Long-term behavior | Effect |
|---|---|---|---|
| Capacitor $C_L$ | Short ($\rho = -1$) | Open ($\rho = +1$) | Slows data rate |
| Inductor $L$ | Open ($\rho = +1$) | Short ($\rho = -1$) | Spike at $t=2$TD |

## Termination Schemes

| Method | Mechanism | Pros | Cons |
|---|---|---|---|
| Series source | $R_s$ in series with driver | Small variation | Extra component |
| Load (parallel) | $R_L = Z_0$ at far end | No reflections reaching source | DC current, power |
| AC load | $R = Z_0$, series $C$ at load; $RC = 1\text{–}2\tau_r$ | No DC dissipation | Slows edges |

---

# Chapter 3 — Crosstalk

## Physical Mechanism

Two parallel conductors exchange energy through their electromagnetic fields:

- **Mutual inductance $L_m$** (magnetic field coupling) → voltage noise proportional to $dI/dt$:

$$V_{\text{noise},L_m} = L_m \frac{dI_{\text{driver}}}{dt}$$

*(chap3.pdf, p.4)*

- **Mutual capacitance $C_m$** (electric field coupling) → current noise proportional to $dV/dt$:

$$I_{\text{noise},C_m} = C_m \frac{dV_{\text{driver}}}{dt}$$

*(chap3.pdf, p.5)*

## Near-End vs. Far-End Crosstalk

| Type | Location | Composed of | Timing |
|---|---|---|---|
| **NEXT** (backward) | Near end | Sum: $I(L_m) + I(C_m)$ | Begins at $t=0$, lasts $2$TD |
| **FEXT** (forward) | Far end | Difference: $I(C_m) - I(L_m)$ | Arrives at $t=$TD, lasts $\approx\tau_r$ |

*(chap3.pdf, pp.11–12)*

## Crosstalk Magnitudes (Matched Terminations, $T_r < 2$TD)

$$A_{\text{NEXT}} = \frac{V_{\text{in}}}{4}\left(\frac{L_m}{L} + \frac{C_m}{C}\right)$$

$$B_{\text{FEXT}} = -\frac{V_{\text{in}} \cdot X\sqrt{LC}}{2T_r}\left(\frac{L_m}{L} - \frac{C_m}{C}\right)$$

*(chap3.pdf, p.13)*

**Key insight:** NEXT is **length-independent** in the long-line case; FEXT always **depends on both rise time and length**.

For $T_r > 2$TD (short-line): $A_{\text{NEXT}} \times \frac{2\text{TD}}{T_r}$; FEXT unchanged.

## The L and C Matrices

For an $N$-conductor system, the L-matrix has self-inductances on the diagonal and mutual inductances off the diagonal. The C-matrix has total capacitances on the diagonal (positive) and mutual capacitances off the diagonal (negative):
$C_{NN}$ = total cap of line $N$; $C_{NM} = -C_m$ between lines $N$ and $M$.

## Odd and Even Mode Analysis

When two identical lines are driven simultaneously:

**Odd mode** (opposite polarity, $V_2 = -V_1$):

$$Z_{\text{odd}} = \sqrt{\frac{L_{11} - L_{12}}{C_{11} + C_m}}, \quad \text{TD}_{\text{odd}} = \sqrt{(L_{11}-L_{12})(C_{11}+C_m)}$$

*(chap3.pdf, p.27)*

**Even mode** (same polarity, $V_2 = V_1$):

$$Z_{\text{even}} = \sqrt{\frac{L_{11} + L_{12}}{C_{11} - C_m}}, \quad \text{TD}_{\text{even}} = \sqrt{(L_{11}+L_{12})(C_{11}-C_m)}$$

*(chap3.pdf, p.29)*

**Always true:**
- $Z_{\text{odd}} < Z_0 < Z_{\text{even}}$
- Odd mode → underdriven; Even mode → overdriven
- Crosstalk does **not** cause velocity variations in striplines (TDs equal), but **does** in microstrips.

## SLEM (Single-Line Equivalent Model)

For a target line surrounded by neighbors switching out of phase (worst case differential):

$$C_{\text{eq}} = C_{22} - C_{12} + C_{23}, \quad L_{\text{eq}} = L_{22} + L_{12} - L_{23}$$

*(chap3.pdf, p.34)*

Use SLEM early in design; full coupled simulation for final verification.

## Crosstalk Minimization Rules

1. Widen spacing $S$ between lines.
2. Minimize height $H$ above ground plane.
3. Use differential routing for critical signals.
4. Route signals on adjacent layers orthogonally.
5. Use stripline or embedded microstrip.
6. Minimize parallel run lengths.
7. Use slower edge rates (with caution).

---

# Chapter 4 — Coupled Microstrip and FEXT Suppression

## Why FEXT Exists in Microstrips (but not Striplines)

In a microstrip, the even-mode and odd-mode waves travel at **different velocities**:

$$\text{TD}_{\text{even}} = \ell\sqrt{(L_s+L_m)C_s} \neq \text{TD}_{\text{odd}} = \ell\sqrt{(L_s-L_m)(C_s+2C_m)}$$

*(chap4.pdf, p.10)*

The time difference $T_d = \text{TD}_{\text{even}} - \text{TD}_{\text{odd}}$ causes the even and odd mode components of FEXT to arrive at different times, producing a net FEXT pulse. In a stripline, both modes are fully embedded in the dielectric, so $T_d = 0$ and FEXT cancels.

## FEXT Magnitude Estimate

$$|V_4(\text{TD}_{\text{even}})| \approx V_{\max} \cdot \min\!\left(\frac{T_d}{t_r},\, 1\right)$$

*(chap4.pdf, p.14)*

## Front-End Decoupling Capacitor

Add $C_f$ at the near end of the quiet line to **increase** $\text{TD}_{\text{odd}}$ until $\text{TDc}_{\text{odd}} = \text{TD}_{\text{even}}$, making $T_d = 0$.

**Required $C_f$** is found by solving $T_d = \ell\sqrt{(L_s-L_m)(C_s+2C_m+2C_f/\ell)} - \text{TD}_{\text{even}} = 0$.

**Trade-off:** FEXT is reduced, but **NEXT increases** and eye quality degrades at high bit rates.

**Fix:** Distribute the capacitance as $\Delta C_f$ at $\lambda/10$ intervals → FEXT ≈ 0, good eye, better S-parameters.

---

# Chapter 5 — Non-ideal Interconnect Issues

## Types of Transmission Line Losses

| Type | Source | Effect |
|---|---|---|
| DC conductor | Resistivity, small cross-section | Amplitude drop |
| Skin effect (AC conductor) | Current concentrates on skin at high $f$ | $R \propto \sqrt{F}$, rounding of edges |
| Dielectric | Loss tangent of substrate | Additional shunt conductance |

## Skin Effect

At high frequency, current crowds to a depth $\delta$ (skin depth) below the conductor surface:

$$\delta = \sqrt{\frac{\rho}{\pi F \mu}} \quad \text{meters}$$

*(chap5.pdf, p.6)*

~63% of current flows within one skin depth. As $F$ increases, $\delta$ decreases → $R \propto \sqrt{F}$.

**AC resistance of a microstrip:**

$$R_{\text{ac}} \approx \sqrt{\rho\pi\mu F}\left(\frac{1}{W} + \frac{1}{6H}\right) \quad \Omega/\text{m}$$

*(chap5.pdf, p.12)*

## Surface Resistance

$$R_{\text{ac}} = R_S \sqrt{F}, \quad R_S = \sqrt{\rho\pi\mu} \quad \Omega\cdot\sqrt{\text{s}}/\text{square}$$

*(chap5.pdf, p.15–16)*

$R_S$ depends only on the conductor material and geometry — not frequency. Roughness (tooth structure) can increase losses by 10–50%.

## Dielectric Loss Tangent

$$\tan\delta_d = \frac{\varepsilon''}{\varepsilon'} = \frac{1}{2\rho\pi F\varepsilon}$$

*(chap5.pdf, p.21)*

This results in a shunt conductance per unit length:

$$G = \tan\delta_d \cdot 2\pi F C_{11} \quad \text{S/m}$$

*(chap5.pdf, p.21)*

For FR4: $\tan\delta \approx 0.02$.

## Effect on Signal Waveforms

A square wave contains harmonics at $f_0, 3f_0, 5f_0, \ldots$ Higher harmonics are attenuated more by $R \propto \sqrt{F}$:
- **Edges round** (loss of high-frequency content)
- **Amplitude decreases** (even fundamental is attenuated over long lines)

## Variations in FR4 Dielectric Constant

$\varepsilon_r$ of FR4 varies with frequency, temperature, moisture, and sample-to-sample variations due to the woven glass cloth construction. First-order estimate:

$$\varepsilon_{r,\text{FR4}} \approx V_{\text{gls}}\varepsilon_{r,\text{gls}} + (1-V_{\text{gls}})\varepsilon_{r,\text{epoxy}}$$

*(chap5.pdf, p.29)*

## Serpentine Traces

Used for length equalization when real estate is limited. **Problem:** the parallel sections couple to each other, causing part of the signal to arrive early → **ledges** on the waveform.

**Rules:**
- Spacing between parallel sections $S \geq 3H$ to $4H$
- Minimize parallel section length $L_p$
- **Never serpentine clock traces**

## Intersymbol Interference (ISI)

When unsettled reflections, crosstalk, or ringing **corrupts the next bit**. Most severe when **period < 2 × TD**.

Efficiently simulate with three periodic patterns: `010101...`, `001100...`, `000111...`.

## 90° Bends

A 90° corner adds excess capacitance:

$$C_{90°} \approx C_{11} \cdot w$$

*(chap5.pdf, p.39)*

Mitigation: chamfer (45° cut) or use 45° bends. Rounding works best but may conflict with layout tools.

## Topology Effects

- **Balanced T**: symmetric topology preserves signal integrity.
- **Unbalanced T**: asymmetric stub lengths or loads → severe waveform distortion.
- Lessons: keep T-junction stubs equal in length and loading; minimize discontinuities at junctions.
