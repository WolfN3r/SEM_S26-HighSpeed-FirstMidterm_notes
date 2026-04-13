# Chapter 2: Ideal Transmission Line Fundamentals

## Outline
- Transmission Line Structures on a PCB or MCM
- Wave Propagation
- Transmission Line Parameters
- Launching Initial Wave and Transmission Line Reflections
- Additional Examples

---

## 1. Transmission Line Structures on a PCB or MCM

### 1.1 PCB Layer Overview
*(chap2.pdf, p.3)*

- **Typical conductor**: copper
- **Typical dielectric**: FR4
- **Microstrip line**: located on the **outer layer** of the PCB
- **Stripline**: located on the **inner layer** of the PCB

For AC signals, both Ground and Power planes act as **AC ground**.

> **Figure description (p.3):** 3D view of a PCB showing a signal trace (microstrip) on the outer surface and a stripline trace embedded in the interior. Below, a cross-section of the same PCB shows the stack-up: Signal (microstrip) / Ground-Power / Signal (stripline) / Signal (stripline) / Ground-Power / Signal (microstrip), with copper traces and FR4 dielectric. Width W and thickness T are labeled.

---

## 2. Wave Propagation

### 2.1 Transmission Line Propagation
*(chap2.pdf, p.4)*

- Used when the **rise time or fall time is small** compared to the **propagation delay** down the trace.
- Wave propagation is analogous to a **waterfront**:
  - Voltage = height of the water
  - Current = flow of the water
- $V_s$ and $Z_s$: source voltage and impedance (output buffer)
- The initial voltage wave $V_i$ travels from source (A) toward the load end.

> **Figure description (p.4):** Circuit diagram showing a source $V_s$ in series with $Z_s$, connected to a transmission line (shaded rectangle representing signal path with a current return path below). A voltage step $V_i$ is shown propagating to the right along the signal path.

---

## 3. Transmission Line Parameters

### 3.1 Introduction
*(chap2.pdf, p.5)*

Three key parameters:

1. **Characteristic Impedance** ($Z_0$): the ratio $V/I$ for a matched load — the impedance the traveling wave "sees"
2. **Propagation Velocity** ($v$): the speed at which the wave travels
3. **Relationship between $(V, I)$ and $(E, H)$**: transmission lines actually transfer energy via electromagnetic fields $E$ and $H$

> **Figure description (p.5):** Cross-section of a transmission line (signal path on top, ground return path on bottom). Electric field lines (solid) extend vertically between the conductors; magnetic field lines (dotted) loop horizontally around the signal conductor. Coordinate axes Y (vertical), X (horizontal), Z (into page) are shown.

### 3.2 Equivalent Circuit Model
*(chap2.pdf, p.6)*

A transmission line segment of length $dz$ is modeled as a **distributed RLCG circuit**:

- **R** ($R\,dz$): losses due to **finite conductivity** of the conductor (series resistance)
- **L** ($L\,dz$): energy stored in the **magnetic field** (series inductance)
- **C** ($C\,dz$): energy stored in the **electric field** (shunt capacitance)
- **G** ($G\,dz$): losses due to **finite resistance of the dielectric** separating conductor and ground plane (shunt conductance)

**TEM mode**: when no components of $E$ or $H$ propagate in the $z$-direction (transverse electromagnetic).

> **Figure description (p.6):** One-section lumped-element model: series $R\,dz$ and $L\,dz$ (resistor and inductor in series), with $C\,dz$ (capacitor) and $G\,dz$ (conductance) in parallel to ground. Ground symbol shown at bottom.

### 3.3 Derivation of Characteristic Impedance
*(chap2.pdf, p.7–8)*

Two equivalent representations:
- **(a)** Distributed RLCG model (infinite cascade of segments)
- **(b)** Lossless model with $Z_0$ and $\beta$

The series impedance and shunt admittance per unit length are:

$$Z\Delta z = [j\omega L + R]\,\Delta z \quad \text{(series impedance for length } \Delta z\text{)}$$
*(chap2.pdf, p.8)*

$$Y\Delta z = [j\omega C + G]\,\Delta z \quad \text{(parallel admittance for length } \Delta z\text{)}$$
*(chap2.pdf, p.8)*

Setting the input impedance of the cascade equal to $Z_0$ (since an infinite line looks the same with one more section added):

$$Z(\text{input}) = Z_o = \frac{(Z_o + Z\Delta z)(1/Y\Delta z)}{Z_o + Z\Delta z + 1/Y\Delta z}$$
*(chap2.pdf, p.8)*

Taking $\Delta z \to 0$ yields:

$$\lim_{\Delta z \to 0} [Z] = Z_o^2 Y$$
*(chap2.pdf, p.8)*

Therefore:

$$Z_o = \sqrt{\frac{Z}{Y}} = \sqrt{\frac{R + j\omega L}{G + j\omega C}}$$
*(chap2.pdf, p.9)*

For a **lossless line** ($R = 0$, $G = 0$):

$$Z_o = \sqrt{\frac{L}{C}}$$
*(chap2.pdf, p.9)*

> Note: R and G only become significant at very high frequencies or with very lossy lines.

> **Figure description (p.7):** Two diagrams side by side. Top: single-segment distributed model (labeled "a") with source $V_s$, $Z_s$, then cascaded RLCG segments, terminated in $Z_0$. Bottom: equivalent multi-section LC ladder (labeled "b") going to infinity, showing voltages $V_1 \ldots V_n$ and currents $I(1) \ldots I(n)$. Arrow shows equivalence between the two representations.

### 3.4 Approximations for Typical Transmission Lines

#### Microstrip Line
*(chap2.pdf, p.9)*

> **Figure description (p.9):** Cross-section diagram of a microstrip: copper trace of width $W$ and thickness $T$ on top of a dielectric of height $H$ above a ground plane.

$$Z_o \approx \frac{87}{\sqrt{\varepsilon_r + 1.41}} \ln\!\left(\frac{5.98H}{0.8W + T}\right) \quad \text{Ohms}$$
*(chap2.pdf, p.9)*

*Valid when $0.1 < W/H < 2.0$ and $1 < \varepsilon_r < 15$.*

#### Symmetric Stripline
*(chap2.pdf, p.10)*

> **Figure description (p.10):** Cross-section of a symmetric stripline: signal trace of width $W$ and thickness $T$ centered between two ground planes separated by $2H$ (distance from each ground plane to trace center = $H$).

$$Z_{o_\text{sym}} \approx \frac{60}{\sqrt{\varepsilon_r}} \ln\!\left(\frac{4H}{0.67\pi(T + 0.8W)}\right) \quad \text{Ohms}$$
*(chap2.pdf, p.10)*

*Valid when $W/H < 0.35$ and $T/H < 0.25$.*

#### Offset Stripline
*(chap2.pdf, p.10)*

For an asymmetrically placed trace (distances $A$ and $B$ to the two ground planes):

$$Z_{o_\text{offset}} \approx 2 \cdot \frac{Z_{o_\text{sym}}(2A, W, T, \varepsilon_r) \cdot Z_{o_\text{sym}}(2B, W, T, \varepsilon_r)}{Z_{o_\text{sym}}(2A, W, T, \varepsilon_r) + Z_{o_\text{sym}}(2B, W, T, \varepsilon_r)}$$
*(chap2.pdf, p.10)*

This averages the symmetric stripline formula evaluated at both spacings.

### 3.5 Propagation Velocity, Time Delay, and Distance
*(chap2.pdf, p.11)*

$$v = \frac{c}{\sqrt{\varepsilon_r}}$$
*(chap2.pdf, p.11)*

$$\text{PD} = \frac{1}{v} = \frac{\sqrt{\varepsilon_r}}{c}$$
*(chap2.pdf, p.11)*

$$\text{TD} = \frac{x\sqrt{\varepsilon_r}}{c}$$
*(chap2.pdf, p.11)*

where:
- $v$ = propagation velocity (m/s)
- $c$ = speed of light in vacuum ($3 \times 10^8$ m/s)
- $\varepsilon_r$ = dielectric constant
- PD = propagation delay (seconds per meter)
- TD = time delay for signal to propagate down a line of length $x$
- $x$ = length of the transmission line (meters)

The time delay can also be expressed as:

$$\text{TD} = \sqrt{LC}$$
*(chap2.pdf, p.11)*

$$\text{PD} = \sqrt{L_\text{unit} C_\text{unit}}$$
*(chap2.pdf, p.11)*

where $L$ = total series inductance and $C$ = total shunt capacitance of length $x$.

### 3.6 Stripline vs. Microstrip — Propagation Speed Comparison
*(chap2.pdf, p.12)*

For the same FR4 board:
- **Stripline**: effective dielectric constant is **larger** → signal speed **slower** → TD **larger**
- **Microstrip line**: effective dielectric constant is **smaller** → signal speed **faster** → TD **smaller**

#### Effective Dielectric Constant of a Microstrip Line
*(chap2.pdf, p.12)*

$$\varepsilon_e = \frac{\varepsilon_r + 1}{2} + \frac{\varepsilon_r - 1}{2}\left(1 + \frac{12H}{W}\right)^{-1/2} + F - 0.217(\varepsilon_r - 1)\frac{T}{\sqrt{WH}}$$
*(chap2.pdf, p.12)*

where:

$$F = \begin{cases} 0.02(\varepsilon_r - 1)\left(1 - \frac{W}{H}\right)^2 & \text{for } W/H < 1 \\ 0 & \text{for } W/H > 1 \end{cases}$$
*(chap2.pdf, p.12)*

### 3.7 Equivalent Circuit Models for SPICE Simulation
*(chap2.pdf, p.13–14)*

Since it is impractical to model a TX line with infinite elements, a sufficient number of segments is chosen based on the **minimum rise or fall time**:

- TD per segment must be $\leq T_r / 10$ (where $T_r$ = minimum system rise/fall time)
- Rise times measured between 10% and 90% of maximum swing

**Number of segments required:**

$$\text{segments} \geq 10\left(\frac{x}{T_r v}\right)$$
*(chap2.pdf, p.14)*

**Parameters per segment:**

$$C_\text{segment} = \frac{(x)(C/\text{meter})}{\text{segments}}$$
*(chap2.pdf, p.14)*

$$L_\text{segment} = \frac{(x)(L/\text{meter})}{\text{segments}}$$
*(chap2.pdf, p.14)*

$$R_\text{segment} = \frac{(x)(R/\text{meter})}{\text{segments}}$$
*(chap2.pdf, p.14)*

$$G_\text{segment} = \frac{(x)(G/\text{meter})}{\text{segments}}$$
*(chap2.pdf, p.14)*

**Verification check:**

$$\text{TD}_\text{segment} = \sqrt{L_\text{segment} C_\text{segment}} \leq \frac{T_r}{10}$$
*(chap2.pdf, p.14)*

### 3.8 Example 2.1: Creating a TX Line Model
*(chap2.pdf, p.15–16)*

**Given:** $Z_0 = 50\,\Omega$, line length $x = 5\,\text{in.}$, $\tau_r = 2.5\,\text{ns}$, $\varepsilon_r = 4.5$

**Geometry (stripline):** $H = 14.7\,\text{mils}$, $T = 0.7\,\text{mil}$, $W = 5\,\text{mils}$

**Step 1 — Verify impedance:**

$$Z_o \approx \frac{60}{\sqrt{\varepsilon_r}} \ln\frac{4H}{0.67\pi(T + 0.8W)} = \frac{60}{\sqrt{4.5}} \ln\frac{4(14.7)}{0.67\pi[0.7 + 0.8(5)]} = 50\,\Omega$$
*(chap2.pdf, p.15)*

**Step 2 — Time delay and velocity:**

$$\text{TD} = \frac{x\sqrt{\varepsilon_r}}{c} = 5\,\text{in.}(0.0254\,\text{m/in.})\frac{\sqrt{4.5}}{3 \times 10^8\,\text{m/s}} = 898\,\text{ps}$$
*(chap2.pdf, p.15)*

$$v = \frac{c}{\sqrt{\varepsilon_r}} = \frac{3 \times 10^8}{\sqrt{4.5}} = 1.41 \times 10^8\,\text{m/s}$$
*(chap2.pdf, p.15)*

**Step 3 — Total L and C:**

Using $\text{TD} = \sqrt{LC}$ and $Z_o = \sqrt{L/C}$:

$$L_\text{total} = (\text{TD})(Z_o) = (898 \times 10^{-12})(50\,\Omega) = 44.9\,\text{nH}$$
*(chap2.pdf, p.15)*

$$C_\text{total} = \frac{\text{TD}}{Z_o} = \frac{898 \times 10^{-12}\,\text{s}}{50\,\Omega} = 17.9\,\text{pF}$$
*(chap2.pdf, p.15)*

**Step 4 — Number of segments:**

$$\text{segments} \geq 10\left(\frac{X}{T_r v}\right) = 10\left[\frac{5\,\text{in.}(0.0254\,\text{m/in.})}{2.5\,\text{ns}(1.41 \times 10^8\,\text{m/s})}\right] = 3.6 \to 4\,\text{segments}$$
*(chap2.pdf, p.16)*

**Step 5 — Per-segment values:**

$$C_\text{segment} = \frac{C_\text{total}}{\text{segments}} = \frac{17.9\,\text{pF}}{4} = 4.48\,\text{pF}$$
*(chap2.pdf, p.16)*

$$L_\text{segment} = \frac{L_\text{total}}{\text{segments}} = \frac{44.9\,\text{nH}}{4} = 11.23\,\text{nH}$$
*(chap2.pdf, p.16)*

**Verification:**

$$\text{TD}_\text{segment} = \sqrt{L_\text{segment} C_\text{segment}} = \sqrt{(4.48\,\text{pF})(11.23\,\text{nH})} = 0.224\,\text{ns} \leq \frac{T_r}{10} = 0.25\,\text{ns} \checkmark$$
*(chap2.pdf, p.16)*

> **Figure description (p.16):** Resulting equivalent circuit showing 4 identical LC sections in series. Each section has $L_\text{segment} = 11.23\,\text{nH}$ in series and $C_\text{segment} = 4.48\,\text{pF}$ to ground.

---

## 4. Launching Initial Wave and Transmission Line Reflections

### 4.1 Launching a Wave onto a Long TX Line
*(chap2.pdf, p.17)*

The initial voltage wave $V_i$ launched onto the line is determined by the **voltage divider** between source impedance $Z_s$ and line characteristic impedance $Z_0$:

$$V_i = V_s \frac{Z_o}{Z_o + Z_s}$$
*(chap2.pdf, p.17)*

- When $Z_L = Z_0$: no reflection occurs; $V_i$ equals the **DC steady-state value**
- The wave takes a time delay TD to travel from source to load

> **Figure description (p.17):** Circuit showing source $V_s$, series $Z_s$, and a long transmission line $Z_0$. Voltage step $V_i$ shown propagating right from node A toward open end. Annotation: "How long does it take? A time delay: TD."

### 4.2 Reflection Coefficient
*(chap2.pdf, p.18)*

When the incident wave reaches an impedance discontinuity (**junction**), a reflected wave is generated:

$$\rho = \frac{V_\text{reflected}}{V_\text{incident}} = \frac{Z_t - Z_o}{Z_t + Z_o}$$
*(chap2.pdf, p.18)*

where $Z_t$ is the terminating (load) impedance.

- Reflection and counter-reflection **continue** until the line reaches stable (DC steady-state) condition.

> **Figure description (p.18):** TX line with source ($V_s$, $Z_s$), line $Z_0$, and load $Z_t$. Annotations show: forward wave $V_i$, reflected wave $(V_i)(\rho)$ returning leftward. Equations for $V_i$ and $\rho$ shown at right.

### 4.3 Special Cases: Matched, Shorted, and Open Loads
*(chap2.pdf, p.19)*

| Load | Impedance | Reflection Coefficient |
|------|-----------|------------------------|
| Matched | $Z_t = Z_0$ | $\rho = \frac{Z_0 - Z_0}{Z_0 + Z_0} = 0$ |
| Shorted | $Z_t = 0$ | $\rho = \frac{0 - Z_0}{0 + Z_0} = -1$ |
| Open | $Z_t = \infty$ | $\rho = \frac{\infty - Z_0}{\infty + Z_0} = +1$ |

*(chap2.pdf, p.19)*

> **Figure description (p.19):** Three diagrams (a), (b), (c) showing matched ($Z_0$ at load), shorted (no load/wire), and open (nothing at end) terminations, with the $\rho$ formula and result for each.

### 4.4 Multiple Reflections
*(chap2.pdf, p.20)*

When termination is not matched, **multiple reflections** bounce between source and load:

$$V_i = V_s Z_o / (Z_o + R_s)$$
*(chap2.pdf, p.20)*

- At $t = 0$: initial wave $V_i$ leaves source
- At $t = \text{TD}$: wave arrives at load; $V = V_i + \rho_B V_i$
- At $t = 2\text{TD}$: reflection returns to source; $V = V_i + \rho_B(V_i) + \rho_A(\rho_B)(V_i)$

where $\rho_A$ = source reflection coefficient, $\rho_B$ = load reflection coefficient.

> **Figure description (p.20):** Space-time diagram. Source at left (A), load at right (B), time increasing downward. Forward wave shown at $t=0$; reflected wave bouncing back at $t=TD$; second forward wave at $t=2TD$. Voltage values accumulated at each bounce are labeled.

### 4.5 Lattice (Bounce) Diagrams
*(chap2.pdf, p.21)*

A **lattice diagram** (bounce diagram) is a graphical tool for tracking multiple reflections:

- **Diagonal lines** represent waves traveling between source and load
- **Time increases downward** in increments of TD
- **Voltage at any node** = cumulative sum of all arriving wave increments

**Notation** (with $a = V_\text{initial}$):

| Increment | Value |
|-----------|-------|
| $a$ | $V_\text{initial}$ |
| $b$ | $a \cdot \rho_\text{load}$ |
| $c$ | $b \cdot \rho_\text{source}$ |
| $d$ | $c \cdot \rho_\text{load}$ |

**Source node voltages** (cumulative):
- $A = a$
- $B = a + b + c$
- $C = a + b + c + d + e$

**Load node voltages** (cumulative):
- $A' = a + b$
- $B' = a + b + c + d$
- $C' = a + b + c + d + e + f$

*(chap2.pdf, p.21)*

**DC steady-state voltage:**

$$V_\text{SS} = V_s \frac{R_t}{R_t + R_s}$$
*(chap2.pdf, p.21)*

> **Figure description (p.21):** Full lattice diagram for a TX line (TD = N ps). Two vertical lines (V(source) left, V(load) right) with diagonal lines showing wave bounces. Time marks at 0, N ps, 2N ps, 3N ps, 4N ps, 5N ps. Reflection coefficient symbols $\rho_\text{source}$ and $\rho_\text{load}$ labeled at top. Cumulative voltage values $A$, $B$, $C$ at source and $A'$, $B'$, $C'$ at load are tabulated.

### 4.6 Example 2.2: Underdriven TX Line ($Z_0 < Z_S$)
*(chap2.pdf, p.22)*

**Given:** $Z_s = 75\,\Omega$, $Z_0 = 50\,\Omega$, $V_s = 0\to 2\,\text{V}$, $\text{TD} = 250\,\text{ps}$, open-circuit load

**Calculations:**

$$V_\text{initial} = V_s \frac{Z_0}{Z_s + Z_0} = (2)\left(\frac{50}{75 + 50}\right) = 0.8\,\text{V}$$
*(chap2.pdf, p.22)*

$$\rho_\text{source} = \frac{Z_s - Z_0}{Z_s + Z_0} = \frac{75 - 50}{75 + 50} = 0.2$$
*(chap2.pdf, p.22)*

$$\rho_\text{load} = \frac{Z_l - Z_0}{Z_l + Z_0} = \frac{\infty - 50}{\infty + 50} = 1$$
*(chap2.pdf, p.22)*

**Lattice result:** Voltage at load rises slowly in steps (0.8 V → 1.6 V → 1.92 V → …) converging to 2 V. The waveform at the source shows a staircase rising slowly.

> **Figure description (p.22):** Lattice diagram with time axis (0, 250 ps, 500 ps, 750 ps, 1000 ps, 1250 ps) and step voltages labeled at each node. Two graphs at right: top is SPICE simulation waveform showing V(Source), V(Load), and $V_s$ vs. time; bottom is response from lattice diagram showing source (dashed) and load (solid) staircase waveforms converging to 2 V.

### 4.7 Example 2.2: Overdriven TX Line ($Z_0 > Z_S$)
*(chap2.pdf, p.23)*

**Given:** $Z_s = 25\,\Omega$, $Z_0 = 50\,\Omega$, $V_s = 0\to 2\,\text{V}$, $\text{TD} = 250\,\text{ps}$, open-circuit load

**Calculations:**

$$V_\text{initial} = V_s \frac{Z_0}{Z_s + Z_0} = (2)\left(\frac{50}{25 + 50}\right) = 1.333\,\text{V}$$
*(chap2.pdf, p.23)*

$$\rho_\text{source} = \frac{Z_s - Z_0}{Z_s + Z_0} = \frac{25 - 50}{25 + 50} = -0.333$$
*(chap2.pdf, p.23)*

$$\rho_\text{load} = \frac{\infty - 50}{\infty + 50} = 1$$
*(chap2.pdf, p.23)*

**Result:** Load voltage overshoots to 2.66 V then rings (2.66 → 1.77 → 2.07 → …), converging to 2 V.

- This is the **ringing effect** — characteristic of overdriven lines.

> **Figure description (p.23):** Lattice diagram and corresponding waveforms. The load (solid) overshoots and rings around 2 V; the source (dashed) shows a similar damped oscillation. "Ringing effect" is annotated on the lower graph.

### 4.8 Two Segments of TX Lines
*(chap2.pdf, p.24)*

For two connected TX line segments ($Z_{01}$, $Z_{02}$) with equal lengths TD:

At the junction between $Z_{01}$ and $Z_{02}$:
- Part of the signal is **reflected** with coefficient $\rho$
- Part is **transmitted** with transmission coefficient $T = 1 + \rho$

Reflection coefficients:

$$\rho_1 = \frac{R_s - Z_{o1}}{R_s + Z_{o1}}, \quad \rho_2 = \frac{Z_{o2} - Z_{o1}}{Z_{o2} + Z_{o1}}, \quad \rho_3 = \frac{Z_{o1} - Z_{o2}}{Z_{o1} + Z_{o2}}, \quad \rho_4 = \frac{R_t - Z_{o2}}{R_t + Z_{o2}}$$
*(chap2.pdf, p.24)*

Transmission coefficients:

$$T_2 = 1 + \rho_2, \quad T_3 = 1 + \rho_3$$
*(chap2.pdf, p.24)*

Initial wave:

$$v_i = V_s \frac{Z_{o1}}{R_s + Z_{o1}}$$
*(chap2.pdf, p.24)*

> **Figure description (p.24):** TX line with two segments $Z_{01}$ and $Z_{02}$ (each of length TD = X), source $R_s$, load $R_t$. Lattice diagram shows 4 vertical lines ($\rho_1$, $\rho_2$, $\rho_3$, $\rho_4$ labeled). Wave interactions at the internal junction are shown with both transmitted and reflected components. Cumulative voltages $A$, $B$, $C$ at source and $A'$, $B'$, $C'$ at load are tabulated.

### 4.9 Bergeron Diagrams (Nonlinear Loads)
*(chap2.pdf, p.25–26)*

Used when **nonlinear loads and sources** exist (e.g., diodes, transistors).

**Method:**
1. Plot the source I-V characteristic (slope $= -1/R_s$; x-intercept at $V_{CC}$)
2. Plot the load I-V characteristic (e.g., diode equation)
3. Intersect source line with load line via lines of slope $\pm 1/Z_0$
4. Alternately solve for source intersection (points a, b, ...) and load intersection (points c, d, ...)

**Bergeron line slopes:**
- From source: slope $= -1/Z_0$
- To load: slope $= +1/Z_0$ (or $-1/Z_0$ depending on direction)

*(chap2.pdf, p.25)*

> **Figure description (p.25):** Current (I) vs. Voltage (V) graph. Source line has slope $-1/R_s$; TX line bounce lines have slope $\pm 1/Z_0$. Points $V_1$, $I_1$ through $V_7$, $I_7$ trace the successive intersections until convergence at steady state. At right: TX line circuit diagram and a time-domain table showing V(source) and V(load) at each time step (0, N, 2N, ... 8N), with annotation "Steady state point."

#### Bergeron Diagram Example
*(chap2.pdf, p.26)*

**Given:** $V_S = 3\,\text{V}$, $\text{TD} = 500\,\text{ps}$, $Z_0 = 50\,\Omega$, $R_S = 25\,\Omega$; diode load:

$$I = 10^{-15}\left(e^{\frac{V}{1(25.4\,\text{mV})}} - 1\right)$$
*(chap2.pdf, p.26)*

> **Figure description (p.26):** I-V plot showing source line (slope $-1/R_s$, x-intercept = $V_{CC} = 3.0\,\text{V}$) and diode curve. Bounce lines of slope $\pm 1/Z_0$ connect successive operating points. At right: time-domain response showing source (dashed) and load (solid) voltages; load rises rapidly and saturates at ~3 V (diode forward voltage clamp); source remains at ~2 V DC steady state.

### 4.10 Effect of Rise Time on Reflections
*(chap2.pdf, p.27)*

**Critical criterion:**

$$\tau_r < 2\,\text{TD}$$
*(chap2.pdf, p.27)*

- When $\tau_r < 2\,\text{TD}$: rise time has a **significant effect** on the waveform — discrete reflections are visible
- When $\tau_r > 2\,\text{TD}$: reflections return during the **transition region** and do not affect steady-state value

> **Figure description (p.27):** Two sets of waveforms. Left (overdriven, $R_s = 10\,\Omega$, $Z_0 = 50\,\Omega$, TD = 300 ps): three curves for rise times 100 ps, 300 ps, 1000 ps showing that shorter rise time → more severe ringing. Right (underdriven, $R_s = 150\,\Omega$, $Z_0 = 50\,\Omega$, TD = 300 ps): similar set showing that with slower rise times the staircase effect smooths out.

### 4.11 Reflections from Capacitive Loads (Lossless)
*(chap2.pdf, p.28)*

When the load is a capacitor $C_L$:
- Initially ($t \to 0^+$ after arrival): capacitor appears as a **short circuit** → $\rho = -1$
- At steady state: capacitor is fully charged → appears as an **open circuit** → $\rho = +1$

**Voltage at the capacitor:**

$$V_\text{capacitor} = 2V_i\left(1 - e^{-(t - \text{TD})/\tau}\right), \quad t > \text{TD}$$
*(chap2.pdf, p.28)*

$$\tau = C Z_o$$
*(chap2.pdf, p.28)*

General form (when source is matched $Z_S = Z_0$):

$$v(t) = V_\text{oc} + (v(0) - V_\text{oc})e^{-t/(R_t C)}$$
*(chap2.pdf, p.28)*

- Adding $C_L$ **slows down** the signal data rate (slows rise time)
- At $t = 2\,\text{TD}$ the reflected wave arrives back at source — voltage at source is almost zero

> **Figure description (p.28):** TX line with $V_s = 2\,\text{V}$, $Z_s = 50\,\Omega$, $Z_0 = 50\,\Omega$, $\text{TD} = 500\,\text{ps}$, capacitor $C_L$ at load. Graph shows V(B) (at capacitor) rising as exponential, and V(A) (at source) showing a brief positive pulse then returning near zero at $t = 2\,\text{TD}$.

### 4.12 Reflections from Capacitive Loads (Lossy — RC Termination)
*(chap2.pdf, p.29)*

When load is a **parallel resistor-capacitor** ($R_L \parallel C_L$):

$$V_\text{capacitor} = 2V_i \frac{R_L}{R_L + Z_o}\left(1 - e^{-(t-\text{TD})/\tau_1}\right), \quad t > \text{TD}$$
*(chap2.pdf, p.29)*

$$\tau_1 = \frac{C_L Z_o R_L}{R_L + Z_o}$$
*(chap2.pdf, p.29)*

*(assumes $Z_S = Z_0$)*

- Adding $R_L$ makes $\tau_1$ smaller → faster signal edge
- The time constant depends on $C_L$ and the **parallel combination** of $R_L$ and $Z_0$

> **Figure description (p.29):** TX line with $Z_s$ source, $Z_0$ line, and $R_L \parallel C_L$ load at far end. Key formulas boxed. Annotation: "By adding $R_L$, $\tau_1$ could be made smaller."

### 4.13 Reflections from Inductive Loads
*(chap2.pdf, p.30)*

When the load is a series inductor $L$:
- At $t = 0$ (arrival): inductor appears as an **open circuit** → $\rho = +1$
- At steady state: inductor discharges at a rate governed by time constant $\tau = L/Z_0$

> **Figure description (p.30):** TX line ($V_s = 0\text{-}2\,\text{V}$, $\text{TD} = 300\,\text{ps}$, $Z_0 = 50\,\Omega$) with series inductor at load end connected to $\infty$ (open). Graph shows V(A) waveforms for $L = 5\,\text{nH}$, $10\,\text{nH}$, $20\,\text{nH}$, $100\,\text{nH}$. All show a large initial spike at $t = 2\,\text{TD}$ (overshoot) followed by exponential decay. Larger $L$ → larger spike and slower decay. Annotation asks: "What if the series L was replaced with a parallel C?"

---

## 5. Termination Schemes to Eliminate Reflections

### 5.1 Overview of Methods
*(chap2.pdf, p.31)*

Three general approaches:

1. **Method 1** (impractical): Decrease system frequency so reflections reach steady state before next signal transition
2. **Method 2** (impractical): Shorten PCB traces so reflections settle faster
3. **Method 3** (practical): **Terminate** TX line with impedance equal to characteristic impedance
   - **Source termination** (at driver end)
   - **Load (parallel) termination** (at receiver end)

### 5.2 On-Die Source Termination
*(chap2.pdf, p.32)*

**Concept:** The I-V curve of the output buffer is designed to be linear with impedance close to $Z_0$.

- **Advantages:** No additional components; no added board area or cost
- **Disadvantages:** Difficult to achieve good match due to: silicon fabrication process variations, voltage, temperature, power delivery factors, simultaneous switching noise (SSN)

Steady-state voltage = $V_s$.

> **Figure description (p.32):** TX line circuit where source (on die) buffer impedance is matched to $Z_0$. Load is open. Steady-state voltage annotated as $V_s$.

### 5.3 Series Source Termination
*(chap2.pdf, p.33)*

**Concept:** Add a discrete resistor $R$ in series with the (low-impedance) output buffer:

$$Z_s = Z_\text{buffer} + R = Z_0$$

- Buffer designed for **very low impedance** so matching is dominated by resistor $R$
- **Advantages:** Total impedance variation is small (precision resistor controls match)
- **Disadvantages:** Resistors add cost; consume board area

Steady-state voltage = $V_s$.

> **Figure description (p.33):** TX line with source buffer ($Z_s$) in series with added resistor $R$; combined source impedance matched to $Z_0$.

### 5.4 Load Termination with Resistive Load
*(chap2.pdf, p.34)*

**Concept:** Place a resistor $R = Z_0$ at the load end, shunting to ground.

- **Advantages:** Eliminates unknown buffer impedance variables; low-impedance output buffers can be used
- **Disadvantages:** Large DC current shunted to ground → **power dissipation** increases → thermal and cost problems

Steady-state voltage:

$$V_\text{SS} = V_s \frac{R}{Z_s + R}$$
*(chap2.pdf, p.34)*

> **Figure description (p.34):** TX line with source buffer and load resistor $R = Z_0$ connected to ground at far end. Steady-state voltage formula annotated.

### 5.5 AC Load Termination
*(chap2.pdf, p.35)*

**Concept:** Place a series $R$-$C$ combination at the load (AC termination):

- $R = Z_0$
- $RC_L = 1\sim 2\,\tau_r$

$$R = Z_0, \quad RC_L = 1\sim 2\tau_r$$
*(chap2.pdf, p.35)*

- **Advantages:** Power only dissipated during **transition region** → **no DC power dissipation**
- **Disadvantages:** Capacitive loading slows rise/fall times; additional components add cost and area

Steady-state voltage = $V_s$.

> **Figure description (p.35):** TX line with AC termination: series $R_L = Z_0$ and $C_L$ at load end. Steady-state voltage annotated.

### 5.6 Common Termination Problems
*(chap2.pdf, p.36)*

1. **Fabrication Variation:** PCB production variations cause significant $Z_0$ variation → bigger impact on **source termination**
2. **Crosstalk:** Introduces additional impedance variations
3. **Different Line Lengths:**
   - **Short lines** → prefer **source termination** (no DC power wasted in resistor)
   - **Long lines** → prefer **load termination** (prevent wave from reflecting back to source)

---

## 6. Additional Examples

### 6.1 Example: Design of a Trace (Full Worked Problem)
*(chap2.pdf, p.37–43)*

**Problem Statement:**
- Driver (U1): $Z_s = 30\,\Omega$, edge rate $= 100\,\text{ps}$, swing $= 0\to 2\,\text{V}$
- PCB trace: $Z_0 = 50\,\Omega$, length $= 5\,\text{in.}$
- $\varepsilon_r = 4.0$, perfect conductor, receiver capacitance negligible

**Goal 1: Cross-Sectional Geometry of Microstrip Trace**
*(chap2.pdf, p.39)*

Using the microstrip formula with $t = 1.0\,\text{mil}$, $W = 5\,\text{mil}$:

$$Z_{o_\text{microstrip}} = \frac{87}{\sqrt{\varepsilon_r + 1.41}} \ln\frac{5.98H}{0.8W + t}$$
*(chap2.pdf, p.39)*

$$50 = \frac{87}{\sqrt{4.0 + 1.41}} \ln\frac{5.98H}{0.8(5.0) + 1.0} \implies H = 3.2\,\text{mils}$$
*(chap2.pdf, p.39)*

PCB stack-up: outer metal $t = 1.0\,\text{mil}$, inner metal $t = 0.7\,\text{mil}$, total board thickness = 62 mils → dielectric thickness = $52.2\,\text{mils}$.

**Goal 2: Propagation Delay**
*(chap2.pdf, p.40)*

Effective dielectric constant (with $W/H = 5/3.2 > 1$, so $F = 0$):

$$\varepsilon_e = \frac{4.0 + 1}{2} + \frac{4.0 - 1}{2}\left[1 + \frac{12(3.2)}{5.0}\right]^{-1/2} + 0 - 0.217(4.0 - 1)\frac{1.0}{\sqrt{5.0(3.2)}} = 2.84$$
*(chap2.pdf, p.40)*

$$v = \frac{c}{\sqrt{\varepsilon_e}} = \frac{3.0 \times 10^8}{\sqrt{2.84}} = 1.78 \times 10^8\,\text{m/s}$$
*(chap2.pdf, p.40)*

$$\text{TD} = \frac{\text{length} \cdot \sqrt{\varepsilon_e}}{c} = \frac{5.0\,\text{in.}}{1.78\,\text{m/s}}\left(\frac{0.0254\,\text{m}}{1.0\,\text{in.}}\right) = 713\,\text{ps}$$
*(chap2.pdf, p.40)*

**Goal 3: Wave Shape at Receiver (Lattice Diagram)**
*(chap2.pdf, p.41)*

Assuming $R_\text{load} = \infty$:

$$V_\text{initial} = V_\text{in} \frac{Z_{o_\text{PCB}}}{Z_{o_\text{PCB}} + R_s} = 2.0\left(\frac{50}{50 + 30}\right) = 1.25\,\text{V}$$
*(chap2.pdf, p.41)*

$$\rho_\text{source} = \frac{R_s - Z_{o_\text{PCB}}}{R_s + Z_{o_\text{PCB}}} = \frac{30 - 50}{30 + 50} = -0.25$$
*(chap2.pdf, p.41)*

$$\rho_\text{load} = \frac{R_\text{load} - Z_{o_\text{PCB}}}{R_\text{load} + Z_{o_\text{PCB}}} = \frac{\infty - 50}{\infty + 50} = 1.0$$
*(chap2.pdf, p.41)*

Lattice result (time steps in multiples of 713 ps):

| Time | V(source) | V(load) |
|------|-----------|---------|
| 0 | 0 V | 0 V |
| 713 ps | 1.25 V | 0 V |
| 713 ps+ | 1.25 V | 2.50 V |
| 1426 ps | 1.25 V | — |
| 1426 ps+ | 1.25 - 0.3125 = ~0.9375 V → converges | — |
| ... | ... → 2.0 V | ... → 2.0 V |

> **Figure description (p.41):** Lattice diagram showing steps at 713 ps, 1426 ps, 2139 ps, 2852 ps, 3565 ps. V(source) and V(load) converge to 2.0 V. Right graph: SPICE simulation showing load voltage (solid) jumping to 2.5 V at 713 ps, then oscillating down and converging to 2.0 V. Time axis to 20,000 ps.

**Goal 4: Equivalent Circuit**
*(chap2.pdf, p.42–43)*

Velocity: $v = 5.0\,\text{in.} / 713\,\text{ps} = 0.0070\,\text{in./ps}$

$$\text{segments} \geq 10\left(\frac{\text{length}}{T_r v}\right) = 10\left[\frac{5\,\text{in.}}{(100\,\text{ps})(0.0070\,\text{in./ps})}\right] = 71.4 \to 72\,\text{segments}$$
*(chap2.pdf, p.42)*

Per-unit capacitance and inductance:

$$C = \frac{\text{TD}/\text{inch}}{Z_o} = \frac{142.6\,\text{ps}}{50\,\Omega} = 2.85\,\text{pF/in.}$$
*(chap2.pdf, p.42)*

$$L = (\text{TD}/\text{inch})(Z_o) = (142.6\,\text{ps})(50\,\Omega) = 7.130\,\text{nH/in.}$$
*(chap2.pdf, p.42)*

Per-segment values:

$$C_\text{segment} = \frac{5.0\,\text{in.}(2.85\,\text{pF/in.})}{72} = 0.198\,\text{pF/segment}$$
*(chap2.pdf, p.42)*

$$L_\text{segment} = \frac{5.0\,\text{in.}(7.13\,\text{nH/in.})}{72} = 0.495\,\text{nH/segment}$$
*(chap2.pdf, p.42)*

**Verification:**

$$\text{delay/segment} = \frac{713\,\text{ps}}{72} = 9.9\,\text{ps} \approx \sqrt{(0.198\,\text{pF})(0.495\,\text{nH})} = 9.9\,\text{ps} \checkmark$$
*(chap2.pdf, p.43)*

$$\text{impedance/segment} = \sqrt{\frac{0.495\,\text{nH}}{0.198\,\text{pF}}} = 50\,\Omega \checkmark$$
*(chap2.pdf, p.43)*

> **Figure description (p.43):** Equivalent SPICE circuit with 72 LC sections. Each segment: $L_\text{segment} = 0.5\,\text{nH}$ in series, $C_\text{segment} = 0.2\,\text{pF}$ to ground. Source is 0–2 V step with 30 Ω series resistance. Load end is $1 \times 10^6\,\Omega$ (approximating open circuit). Segments 1, 2, …, 71, 72 labeled.

---

## Key Equations Summary

| Quantity | Formula | Page |
|----------|---------|------|
| Characteristic impedance (general) | $Z_0 = \sqrt{(R+j\omega L)/(G+j\omega C)}$ | p.9 |
| Characteristic impedance (lossless) | $Z_0 = \sqrt{L/C}$ | p.9 |
| Microstrip $Z_0$ | $\frac{87}{\sqrt{\varepsilon_r+1.41}}\ln\!\left(\frac{5.98H}{0.8W+T}\right)$ | p.9 |
| Symmetric stripline $Z_0$ | $\frac{60}{\sqrt{\varepsilon_r}}\ln\!\left(\frac{4H}{0.67\pi(T+0.8W)}\right)$ | p.10 |
| Propagation velocity | $v = c/\sqrt{\varepsilon_r}$ | p.11 |
| Time delay | $\text{TD} = x\sqrt{\varepsilon_r}/c = \sqrt{LC}$ | p.11 |
| Initial wave voltage | $V_i = V_s Z_0/(Z_0+Z_s)$ | p.17 |
| Reflection coefficient | $\rho = (Z_t - Z_0)/(Z_t + Z_0)$ | p.18 |
| Transmission coefficient | $T = 1 + \rho$ | p.24 |
| DC steady-state voltage | $V_\text{SS} = V_s R_t/(R_t+R_s)$ | p.21 |
| Capacitive load voltage | $V_C = 2V_i(1-e^{-(t-\text{TD})/\tau})$, $\tau = CZ_0$ | p.28 |
| RC load voltage | $V_C = 2V_i\frac{R_L}{R_L+Z_0}(1-e^{-(t-\text{TD})/\tau_1})$ | p.29 |
| Number of SPICE segments | $\text{segments} \geq 10(x/T_r v)$ | p.14 |
| Rise-time criterion | $\tau_r < 2\,\text{TD}$ for significant effect | p.27 |
