# HSDSD Midterm Study Notes

**Audience:** Student with EM fields and intro radio-wave background.
**Source:** NTUST HSDSD lecture slides, chap1–5.

---

## Chapter 1 — Why Interconnect Design Matters

### The core problem

At high data rates, PCB traces can no longer be treated as simple wires. A signal with rise time $t_r = 100\,\text{ps}$ has a highest frequency of interest:

$$f_2 = \frac{1}{\pi t_r} = \frac{0.32}{t_r}$$
*(chap1.pdf, p.6)*

At 100 ps rise time, $f_2 \approx 3.2\,\text{GHz}$ — the corresponding wavelength in FR4 is only a few centimetres. Any trace longer than $\lambda/10$ must be treated as a **transmission line**, not a lumped wire.

### Transmission line criterion

A conductor must be modelled as a TX line when its electrical length $\geq \lambda/10$:

$$\lambda_l = \frac{\lambda}{10} \quad \Leftrightarrow \quad TD_l \geq \frac{t_r}{10}$$
*(chap1.pdf, p.7)*

**Practical rule:** if trace delay $\geq t_r / 10$, use TX-line model.

### Trapezoidal spectrum

A clock waveform with rise time $t_r$, pulse width $\tau$, and period $T$ has a three-region spectral envelope:

| Frequency range | Slope |
|---|---|
| $0$ to $f_1 = 1/(\pi\tau)$ | 0 dB/decade (flat) |
| $f_1$ to $f_2 = 1/(\pi t_r)$ | −20 dB/decade |
| above $f_2$ | −40 dB/decade |

*(chap1.pdf, p.6)*

Key takeaway: faster edges raise $f_2$, increase spectral content, and worsen every interconnect effect.

---

## Chapter 2 — Transmission Line Fundamentals

### Characteristic impedance

For a general (lossy) line:

$$Z_o = \sqrt{\frac{R + j\omega L}{G + j\omega C}}$$
*(chap2.pdf, p.4)*

For a lossless line ($R=G=0$):

$$Z_o = \sqrt{\frac{L}{C}}$$
*(chap2.pdf, p.4)*

### Practical impedance formulas

**Microstrip** (trace on outer layer, one ground plane):

$$Z_o \approx \frac{87}{\sqrt{\varepsilon_r + 1.41}} \ln\!\left(\frac{5.98H}{0.8W + T}\right)$$
*(chap2.pdf, p.7)*

**Symmetric stripline** (trace buried between two ground planes, equal spacing $H/2$ each side):

$$Z_o \approx \frac{60}{\sqrt{\varepsilon_r}} \ln\!\left(\frac{4H}{0.67\pi(T + 0.8W)}\right)$$
*(chap2.pdf, p.8)*

where $H$ = total dielectric height, $W$ = trace width, $T$ = trace thickness.

### Propagation velocity and delay

$$v = \frac{c}{\sqrt{\varepsilon_r}}, \qquad TD = \frac{x\sqrt{\varepsilon_r}}{c}$$
*(chap2.pdf, p.10)*

For microstrip the field is partly in air, so an **effective dielectric constant** $\varepsilon_{eff} < \varepsilon_r$ applies — microstrip is faster than stripline for the same $\varepsilon_r$.

### SPICE modelling rule

Segment the line so each segment's time delay $\leq t_r/10$:

$$\text{segments} \geq \frac{10x}{v t_r}$$
*(chap2.pdf, p.13)*

### Reflections

When a wave reaches an impedance discontinuity $Z_t$:

$$\rho = \frac{Z_t - Z_o}{Z_t + Z_o}, \qquad V_\text{reflected} = \rho\, V_\text{incident}$$
*(chap2.pdf, p.18)*

The first wave launched onto the line (voltage divider at source):

$$V_i = V_s \frac{Z_o}{Z_o + Z_s}$$
*(chap2.pdf, p.17)*

Use a **lattice diagram** to track successive reflections at each end of the line.

---

## Chapter 3 — Crosstalk

### Physical origin

Two adjacent traces couple through mutual inductance $L_m$ and mutual capacitance $C_m$:

$$V_{\text{noise},L_m} = L_m \frac{dI_\text{driver}}{dt}, \qquad I_{\text{noise},C_m} = C_m \frac{dV_\text{driver}}{dt}$$
*(chap3.pdf, p.4–5)*

Inductive noise adds at the near end and subtracts at the far end. Capacitive noise adds at both ends (but in opposite polarity relative to inductive at far end).

### NEXT and FEXT formulas (Case 1 — matched, long line)

**Near-End CrossTalk (NEXT):**

$$A = \frac{V_\text{input}}{4}\left(\frac{L_M}{L} + \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

NEXT is a **flat-top pulse** of duration $2\,TD$ (round-trip time), magnitude $A$.

**Far-End CrossTalk (FEXT):**

$$B = -\frac{V_\text{input}\, X\sqrt{LC}}{2T_r}\left(\frac{L_M}{L} - \frac{C_M}{C}\right)$$
*(chap3.pdf, p.13)*

FEXT is a **pulse** of duration $T_r$ arriving at time $TD$. It is zero in a symmetric stripline (where $L_M/L = C_M/C$).

### Mismatch correction

If the victim line is terminated with $R \neq Z_0$:

$$V_x = V_\text{crosstalk}\left(1 + \frac{R - Z_0}{R + Z_0}\right)$$
*(chap3.pdf, p.15)*

### Coupling factor

$$K = \frac{L_{12}}{\sqrt{L_{11}L_{22}}}$$
*(chap3.pdf, p.21)*

$K$ quantifies how tightly two lines are coupled (0 = no coupling, 1 = perfect coupling).

### Odd- and Even-mode impedances

When two lines switch together in phase (even mode) or in opposite phase (odd mode):

| Mode | Inductance | Capacitance | Impedance |
|---|---|---|---|
| Odd | $L_{11} - L_{12}$ (↓) | $C_{11} + C_m$ (↑) | $Z_\text{odd} < Z_0$ |
| Even | $L_{11} + L_{12}$ (↑) | $C_{11} - C_m$ (↓) | $Z_\text{even} > Z_0$ |

*(chap3.pdf, p.25–29)*

- Odd mode: underdriven (source impedance too high) → slow settling  
- Even mode: overdriven (source impedance too low) → ringing possible  
- Stripline: $TD_\text{odd} = TD_\text{even}$ → no velocity variation  
- Microstrip: $TD_\text{odd} \neq TD_\text{even}$ → different propagation speeds

### SLEM — Single-Line Equivalent Model

For a three-line bus, line 2 effective impedance depends on its switching pattern relative to neighbours:

**All in phase (common mode):**
$$Z_{2,\text{eff}} = \sqrt{\frac{L_{22}+L_{12}+L_{23}}{C_{22}-C_{12}-C_{23}}}$$
*(chap3.pdf, p.33)*

**Center out of phase with both neighbours (differential mode):**
$$Z_{2,\text{eff}} = \sqrt{\frac{L_{22}-L_{12}-L_{23}}{C_{22}+C_{12}+C_{23}}}$$

These two modes produce the **worst-case** impedance extremes.

### Termination for differential pairs

**Pi-termination** ($R_1 = R_2 = Z_\text{even}$ to ground, $R_3$ between lines):

$$R_3 = \frac{2 Z_\text{even} Z_\text{odd}}{Z_\text{even} - Z_\text{odd}}$$
*(chap3.pdf, p.39)*

**T-termination** ($R_1 = R_2 = Z_\text{odd}$ in series, $R_3$ to ground):

$$R_3 = \frac{1}{2}(Z_\text{even} - Z_\text{odd})$$
*(chap3.pdf, p.40)*

### Crosstalk minimisation rules

1. Widen spacing $S$ between traces (most effective)
2. Minimise height $H$ above ground plane for lower impedance → less coupling
3. Route on stripline to eliminate FEXT velocity effect
4. Keep parallel run lengths short
5. Route critical signals on orthogonal layers

---

## Chapter 4 — Coupled Microstrip Line and Decoupling Techniques

### Why FEXT exists in microstrip but not ideal stripline

In a microstrip, even-mode and odd-mode waves travel at **different speeds** because $\varepsilon_{eff}$ is different for each mode:

$$T_d = TD_{even} - TD_{odd} > 0$$

The FEXT voltage is proportional to this time difference:

$$|V_4(TD_{even})| = V_{max} \cdot \min\!\left(\frac{T_d}{t_r},\, 1\right)$$
*(chap4.pdf, p.14)*

$$V_{max} = \frac{Z_0}{Z_{even} + 2Z_0 + Z_{odd}}\,V_s$$
*(chap4.pdf, p.14)*

In an ideal stripline $T_d = 0$, so FEXT $= 0$.

### Even- and odd-mode time delays

$$TD_{even} = l\sqrt{(L_s + L_m)C_s}$$
*(chap4.pdf, p.10)*

$$TD_{odd} = l\sqrt{(L_s - L_m)(C_s + 2C_m)}$$
*(chap4.pdf, p.10)*

### Front-end decoupling capacitor $C_f$

Place a capacitor $C_f$ between the two lines at the source end. This adds $2C_f/l$ per unit length to the odd-mode circuit only, slowing the odd mode to match the even mode:

$$TD^c_{odd} = l\sqrt{\left(C_s + 2C_m + \frac{2C_f}{l}\right)(L_s - L_m)}$$
*(chap4.pdf, p.23)*

**Design goal:** choose $C_f$ so $TD^c_{odd} = TD_{even}$ ($T_d = 0$).

**Trade-off:** a lumped $C_f$ reduces FEXT but **increases NEXT** (the capacitor charging current appears as a near-end spike) and degrades eye diagram at high bit rates.

### RC time constant of the $C_f$ circuit

$$\tau = 2R_t C_f, \qquad R_t = \frac{Z_0 Z_{odd}}{Z_0 + Z_{odd}}$$
*(chap4.pdf, p.28)*

### Distributed decoupling capacitors

Distributing $C_f$ as $N$ smaller capacitors spaced $\Delta l = \lambda/10$ apart:

- Eliminates FEXT ($\approx 0$)
- Reduces NEXT (no large spike — gradual charging)
- Restores $|S_{11}|$ and eye diagram performance
- Much better than lumped $C_f$ at high frequencies

The optimal spacing is at or below $\lambda/10$ at the signal's 3-dB bandwidth:

$$f_{3\text{dB}} = \frac{0.35}{t_r}, \qquad \lambda = \frac{3\times10^8}{f_{3\text{dB}}\sqrt{\varepsilon_{eff}}}$$
*(chap4.pdf, p.39)*

---

## Chapter 5 — Nonideal Interconnect Issues

### DC resistance

$$R = \frac{\rho L}{Wt} \quad \Omega$$
*(chap5.pdf, p.4)*

Significant only for long lines, narrow traces, or multiload buses.

### Skin effect

At high frequencies, current crowds to the conductor surface. The skin depth is:

$$\delta = \sqrt{\frac{2\rho}{\omega\mu}} = \sqrt{\frac{\rho}{\pi F\mu}} \quad \text{(meters)}$$
*(chap5.pdf, p.6)*

**63% of current** flows within one skin depth $\delta$.

Resistance increases as $\sqrt{F}$ above the transition frequency $F_t$ (where $\delta = t$).

### AC resistance — microstrip signal conductor

$$R_{\text{ac signal}} \approx \frac{\rho}{W\delta} = \frac{\sqrt{\rho\pi\mu F}}{W} \quad \Omega/\text{m}$$
*(chap5.pdf, p.9)*

### Ground return AC resistance

The ground return current follows a Lorentzian distribution. 79.5% is within $\pm 3H$, so effective ground width $\approx 6H$:

$$R_{\text{ac ground}} \approx \frac{\sqrt{\rho\pi\mu F}}{6H} \quad \Omega/\text{m}$$
*(chap5.pdf, p.11)*

### Total microstrip AC resistance

$$R_{\text{ac microstrip}} \approx \sqrt{\rho\pi\mu F}\!\left(\frac{1}{W} + \frac{1}{6H}\right) \quad \Omega/\text{m}$$
*(chap5.pdf, p.12)*

### SPICE combined resistance

$$R_\text{total} \approx \sqrt{R_\text{ac}^2 + R_\text{dc}^2}$$
*(chap5.pdf, p.10)*

### Surface resistance

$$R_s = \frac{L}{W}\sqrt{\rho\pi\mu} \quad \text{ohms}\cdot\sqrt{\text{s}}$$
*(chap5.pdf, p.16)*

so that $R_\text{ac} = R_s\sqrt{F}$. *(chap5.pdf, p.15)*

### Stripline AC resistance

Parallel combination of the microstrip resistance seen from the top ground plane ($H_1$) and the bottom ground plane ($H_2$):

$$R_{\text{ac stripline}} = \frac{R_{(H1)} \cdot R_{(H2)}}{R_{(H1)} + R_{(H2)}} \quad \Omega/\text{m}$$
*(chap5.pdf, p.13)*

### Dielectric losses

The dielectric constant becomes complex under a time-varying field:

$$\varepsilon = \varepsilon' - j\varepsilon''$$
*(chap5.pdf, p.20)*

**Loss tangent** (easier to look up in data sheets than $\varepsilon''$):

$$\tan\delta_d = \frac{\varepsilon''}{\varepsilon'}$$
*(chap5.pdf, p.21)*

This adds a **shunt conductance** per unit length to the TX-line model:

$$G = \frac{\varepsilon''}{\varepsilon'}(2\pi F C_{11}) \quad \text{S/m}$$
*(chap5.pdf, p.21)*

**Important:** For FR4 up to 15 GHz, dielectric loss dominates over conductor loss. *(chap5.pdf, p.5)*

### FR4 dielectric constant variation

FR4 is not a constant-$\varepsilon_r$ material. First-order model:

$$\varepsilon_r = \varepsilon_\text{rsn}V_\text{rsn} + \varepsilon_\text{gls}V_\text{gls}$$
*(chap5.pdf, p.29)*

Empirical formula (frequency in kHz):

$$\varepsilon_r(V_\text{rsn}, F) = 6.32 - [2.17 + 0.168\log_{10}F\,(\text{kHz})]\,V_\text{rsn}$$
*(chap5.pdf, p.29)*

$\varepsilon_r$ decreases with frequency (4.7 at low MHz → 3.9 at 1 GHz for typical FR4).

### Serpentine traces

Due to coupling between adjacent parallel sections, part of the signal shortcuts through crosstalk (Path 2) and arrives **early**:

- Duration of "ledge" $\propto$ parallel section length $L_p$
- Ledge voltage $\propto$ spacing $S$

**Rules:** $S \geq 3H$ to $4H$; minimise $L_p$; do not serpentine clock traces. *(chap5.pdf, p.33)*

### Intersymbol Interference (ISI)

ISI occurs when reflections or noise from a previous bit have not settled before the next transition. Worst when:

$$T_\text{period} < 2 \times TD_\text{line}$$

**Rules:** minimise reflections; keep traces short; avoid tightly coupled serpentines; minimise crosstalk. *(chap5.pdf, p.38)*

### 90° bends

Excess capacitance at a corner (area $\approx 0.054$ squares):

$$C_{90°\text{ bend}} \approx C_{11}\,w$$
*(chap5.pdf, p.39)*

Mitigation: use 45° bends or chamfer the corner.

### Topology effects

- **Balanced T** (equal leg lengths, equal loading): clean step response.
- **Unbalanced T** ($L_1 \neq L_2$): severe ringing from multiple reflections bouncing between junction and receivers.

**Rules:** symmetric topology (equal length and loading on every branch); minimise discontinuity at the junction. *(chap5.pdf, p.44)*

---

## Quick Reference — Key Formulas

| Concept | Formula | Source |
|---|---|---|
| Highest frequency | $f_2 = 0.32/t_r$ | chap1.pdf, p.6 |
| TX line criterion | trace delay $\geq t_r/10$ | chap1.pdf, p.7 |
| Lossless $Z_o$ | $\sqrt{L/C}$ | chap2.pdf, p.4 |
| Microstrip $Z_o$ | $\frac{87}{\sqrt{\varepsilon_r+1.41}}\ln\frac{5.98H}{0.8W+T}$ | chap2.pdf, p.7 |
| Stripline $Z_o$ | $\frac{60}{\sqrt{\varepsilon_r}}\ln\frac{4H}{0.67\pi(T+0.8W)}$ | chap2.pdf, p.8 |
| Propagation delay | $TD = x\sqrt{\varepsilon_r}/c$ | chap2.pdf, p.10 |
| Reflection coeff. | $\rho = (Z_t-Z_o)/(Z_t+Z_o)$ | chap2.pdf, p.18 |
| NEXT (matched) | $A = \frac{V}{4}(L_M/L+C_M/C)$ | chap3.pdf, p.13 |
| FEXT (matched) | $B = -\frac{VX\sqrt{LC}}{2T_r}(L_M/L-C_M/C)$ | chap3.pdf, p.13 |
| Odd-mode $Z$ | $\sqrt{(L_{11}-L_{12})/(C_{11}+C_m)}$ | chap3.pdf, p.27 |
| Even-mode $Z$ | $\sqrt{(L_{11}+L_{12})/(C_{11}-C_m)}$ | chap3.pdf, p.29 |
| Skin depth | $\delta = \sqrt{\rho/(\pi F\mu)}$ | chap5.pdf, p.6 |
| AC resistance | $R_s\sqrt{F}$ | chap5.pdf, p.15 |
| Loss tangent | $\tan\delta_d = \varepsilon''/\varepsilon'$ | chap5.pdf, p.21 |
| Dielectric conductance | $G = (\varepsilon''/\varepsilon')(2\pi FC_{11})$ | chap5.pdf, p.21 |
