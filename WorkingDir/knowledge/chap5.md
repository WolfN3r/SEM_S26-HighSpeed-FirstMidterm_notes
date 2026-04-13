# Chapter 5: Nonideal Interconnect Issues

## Outline
- Transmission Line Losses
- Variations in the Dielectric Constant
- Serpentine Traces
- Intersymbol Interference
- Effects of 90° Bends
- Effect of Topology

---

## 1. Transmission Line Losses

### 1.1 Introduction — Why Losses Are Important
*(chap5.pdf, p.3)*

- Development of high-speed digital systems → requirement for smaller dimensions and faster signal rates (high-frequency content) → **resistive losses become more severe**
- Result: signal amplitude is decreased → affects noise margins, slows edge rates → affects timing margins
- Two types of dispersion:
  1. **Loss dispersion**: caused by loss variations with frequency
  2. **Phase dispersion**: caused by phase (velocity) variations with frequency

### 1.2 DC Losses — Conductor
*(chap5.pdf, p.4)*

DC conductor resistance is significant for:
- Small-geometry conductors
- Very long lines
- Multiload buses

DC loss depends on **resistivity** and **cross-sectional area** in which current flows.

$$R = \frac{\rho L}{A} = \frac{\rho L}{Wt} \quad \text{ohms}$$
*(chap5.pdf, p.4)*

where $\rho$ = resistivity, $L$ = length, $W$ = width, $t$ = thickness.

- Ground return path losses are usually **negligible at DC** because the ground plane has very large cross-sectional area.

> **Figure description (p.4):** Cross-section of a rectangular PCB trace showing width $W$ and thickness $t$. The ground plane below is shown as a thick line.

### 1.3 DC Losses — Dielectric
*(chap5.pdf, p.5)*

- Dielectric losses at DC for conventional substrates are **very negligible** and can be ignored.

> **Important note (p.5):** When frequency increases beyond DC up to 15 GHz, **the substrate (dielectric) loss dominates over the conductor loss** for FR4 substrate.

### 1.4 Skin Effect — Definition
*(chap5.pdf, p.5–6)*

At high frequencies, current flowing in a conductor migrates toward the **periphery (skin)** of the conductor.

**Skin depth** $\delta$: the depth at which the electric field amplitude has decayed by a factor of $e^{-1}$ of its surface value.

$$\delta = \sqrt{\frac{2\rho}{\omega\mu}} = \sqrt{\frac{\rho}{\pi F \mu}} \quad \text{meters}$$
*(chap5.pdf, p.6)*

- Approximately **63% of the total current** flows within one skin depth.

### 1.5 Skin Effect — Frequency-Dependent Resistance
*(chap5.pdf, p.6)*

As frequency increases:
- Current cross-section shrinks → resistance **increases with $\sqrt{F}$** (square root of frequency)
- The transition frequency $F_t$ is where skin depth $\delta = t$ (conductor thickness)
  - Below $F_t$: resistance ≈ DC value
  - Above $F_t$: resistance ∝ $\sqrt{F}$

### 1.6 Skin Effect — Frequency-Dependent Inductance
*(chap5.pdf, p.7)*

As frequency increases, total inductance **falls asymptotically** toward a static value called the **external inductance** (inductance calculated assuming all current flows on the conductor exterior).

- In most high-speed digital systems, frequencies are high enough that the **frequency dependence of inductance can be ignored** (external inductance is a good approximation).

> **Note (p.7):** Inductance is *larger* when current is distributed uniformly through the cross-section (low frequency) — analogous to even-mode excitation where mutual flux is added. At high frequencies, current concentrates on the surface, reducing internal flux linkage.

### 1.7 Skin Effect — Conductor Losses in a Microstrip
*(chap5.pdf, p.8–12)*

In a microstrip:
- Current is concentrated on the **bottom edge** (pulled by fields between signal line and ground plane)
- Current distribution **curves up the sides** (field concentration along thickness $t$)

> **Figure description (p.8):** Cross-section of microstrip trace (width $W$, thickness $t$) showing the skin depth $\delta$ on the bottom and sides. The ground plane below shows current density distribution peaking directly below the trace.

**AC resistance of signal line (approximate, per unit length):**

$$R_{\text{ac signal}} \approx \frac{\rho}{W\delta} = \frac{\sqrt{\rho\pi\mu F}}{W} \quad \Omega/\text{m}$$
*(chap5.pdf, p.9)*

**Combined DC + AC resistance in SPICE:**

$$R_{\text{total}} \approx \sqrt{R_{\text{ac}}^2 + R_{\text{dc}}^2}$$
*(chap5.pdf, p.10)*

**Ground return path current density distribution (approximate):**

$$I(D) \approx \frac{I_o}{\pi H} \cdot \frac{1}{1 + (D/H)^2}$$
*(chap5.pdf, p.10)*

where $D$ = lateral distance from center, $H$ = substrate height.

**79.5% of ground current** is within $\pm 3H$ (6H total width) → approximate ground effective width $W_{\text{eff}} = 6H$:

$$\int_{-3H}^{3H} \frac{I_o}{\pi H}\frac{1}{1+(D/H)^2} = \frac{2I_o}{\pi}\tan^{-1}(3) \approx 0.795 I_o$$
*(chap5.pdf, p.11)*

**Ground return AC resistance:**

$$R_{\text{ac ground}} \approx \frac{\rho}{A_{\text{ground}}} = \frac{\rho}{6\delta H} = \frac{\rho}{6H}\sqrt{\frac{\pi\mu F}{\rho}} = \frac{\sqrt{\rho\pi\mu F}}{6H} \quad \Omega/\text{m}$$
*(chap5.pdf, p.11)*

**Total AC resistance of microstrip:**

$$R_{\text{ac microstrip}} = R_{\text{ac signal}} + R_{\text{ac ground}} \approx \sqrt{\rho\pi\mu F}\left(\frac{1}{W} + \frac{1}{6H}\right) \quad \Omega/\text{m}$$
*(chap5.pdf, p.12)*

**More exact formula (conformal mapping):**

$$R_{\text{signal}} = [\text{loss ratio}]\left(\frac{1}{\pi} + \frac{1}{\pi^2}\ln\frac{4\pi W}{t}\right)\frac{\sqrt{\pi\mu F\rho}}{W}$$
*(chap5.pdf, p.12)*

$$\text{Loss ratio} = \begin{cases} 0.94 + 0.132\dfrac{W}{H} - 0.0062\left(\dfrac{W}{H}\right)^2 & \text{for } 0.5 < \dfrac{W}{H} < 10 \\ 1 & \text{for } \dfrac{W}{H} \leq 0.5 \end{cases}$$
*(chap5.pdf, p.12)*

$$R_{\text{ground}} = \frac{W/H}{W/H + 5.8 + 0.03(H/W)} \cdot \frac{\sqrt{\pi\mu F\rho}}{W} \quad \text{for } 0.1 < \frac{W}{H} < 10$$
*(chap5.pdf, p.12)*

### 1.8 Skin Effect — Conductor Losses in a Stripline
*(chap5.pdf, p.13)*

In a stripline, current density depends on the proximity of **both** ground planes ($H_1$ above, $H_2$ below). The resistance is approximated as the **parallel combination** of two microstrip resistances:

$$R_{\text{ac stripline}} = \frac{R_{(H1)\text{ac microstrip}} \cdot R_{(H2)\text{ac microstrip}}}{R_{(H1)\text{ac microstrip}} + R_{(H2)\text{ac microstrip}}} \quad \Omega/\text{m}$$
*(chap5.pdf, p.13)*

> **Figure description (p.13):** Stripline cross-section: trace (width $W$, thickness $t$, skin depth $\delta$) sandwiched between upper ground plane (distance $H_1$) and lower ground plane (distance $H_2$). Ground plane current density curves shown on both sides, matching the Lorentzian distribution.

### 1.9 Skin Effect — Surface Roughness
*(chap5.pdf, p.14–15)*

In reality, metal surfaces are rough (described by **tooth structure**; magnitude = **tooth size**):
- When mean surface roughness is a significant percentage of skin depth → resistance **increases by 10–50%** above ideal formula values
- Typical FR4 boards: average tooth size of **4 to 7 μm**
- Etched surfaces: smaller tooth size

### 1.10 Surface Resistance ($R_S$)
*(chap5.pdf, p.15–16)*

Since $R_{\text{ac}} = R_s\sqrt{F}$, the surface resistance is:

$$R_s = \frac{L\rho}{W\delta} = \frac{L}{W}\sqrt{\rho\pi\mu} \quad \text{ohms}\cdot\sqrt{\text{seconds}}$$
*(chap5.pdf, p.16)*

For a square ($L = W$):

$$R_{\text{square}} = \frac{\rho L}{A} = \frac{\rho L}{tW} \quad \xrightarrow{L=W} \quad R_{\text{square}} = \frac{\rho}{t}$$
*(chap5.pdf, p.16)*

The AC resistance is obtained by multiplying $R_S$ by length and $\sqrt{F}$, then dividing by width:

$$R_{\text{ac}} = R_s\sqrt{F}$$
*(chap5.pdf, p.15)*

### 1.11 Skin Effect — Effect of AC Losses on Signals
*(chap5.pdf, p.17–19)*

**Fourier expansion of a 50% duty cycle square wave:**

$$f(x) = \frac{2}{\pi} \sum_{n=1,3,5,\ldots} \frac{1}{n}\sin(2\pi n F x)$$
*(chap5.pdf, p.17)*

Only odd harmonics present for 50% duty cycle; even harmonics appear if duty cycle ≠ 50%.

**Attenuation in a matched system** (voltage divider at single frequency):

$$V_1 = V\frac{R_{\text{ac}} + R_2}{R_1 + R_{\text{ac}} + R_2}, \quad V_2 = V\frac{R_2}{R_1 + R_2 + R_{\text{ac}}}$$
*(chap5.pdf, p.18)*

$$\alpha = \frac{V_2}{V_1} = \frac{R_2}{R_{\text{ac}} + R_2}$$
*(chap5.pdf, p.18)*

**Simulation procedure (FFT method):**
1. Take FFT of the input waveform
2. Multiply each frequency component by the attenuation factor $\alpha(F)$
3. Take IFFT to get the output waveform

**Effects observed:**
- **Wave shape is rounded**: high-frequency components are attenuated → edge rate degrades
- **Amplitude is reduced**: low-frequency (and DC) components are also attenuated

> **Figure description (p.19):** Four-panel diagram. (a) Original square wave in time domain. (b) FFT spectrum showing fundamental at 400 MHz and harmonics at 1200 MHz, 2000 MHz, etc. (c) Attenuation factor $\alpha$ vs. frequency (0.65–1.0), decreasing monotonically from DC toward GHz. (d) Time-domain output comparing "No AC losses" (clean square wave) vs. "With AC losses" (rounded, attenuated waveform).

### 1.12 Frequency-Dependent Dielectric Losses
*(chap5.pdf, p.20–27)*

**Physics:** Time-varying electric field causes **polar molecules** to align opposite the applied field (**electric polarization**). The damping mechanisms are frequency-dependent → dielectric losses.

**Complex dielectric constant:**

$$\varepsilon = \varepsilon' - j\varepsilon''$$
*(chap5.pdf, p.20)*

**Loss tangent** (primary characterization method):

$$\tan|\delta_d| = \frac{1}{2\rho\pi F\varepsilon} = \frac{\varepsilon''}{\varepsilon'}$$
*(chap5.pdf, p.21)*

This results in an equivalent **parallel conductance** per unit length:

$$G = \frac{\varepsilon''}{\varepsilon'}(2\pi F C_{11}) \quad \text{siemens/m}$$
*(chap5.pdf, p.21)*

where $C_{11}$ is the self-capacitance per unit length.

> **Figure description (p.22):** FR4 loss tangent vs. frequency (0.01 MHz to 1000 MHz). The curve rises from ~0.010 at low frequencies, peaks at ~0.024 near 1–10 GHz, then decreases. The typical value used (0.02) is a reasonable approximation for frequencies in the hundreds of MHz range.

**Worked example** (symmetric stripline: $W=5$ mils, $H_1=H_2=10$ mils, $t=0.63$ mil, $\varepsilon_r=4.0$):
*(chap5.pdf, p.23–27)*

**Step 1 — Surface resistance and signal/ground AC resistance:**

Since $W/H = 5/10 = 0.5$ → loss ratio = 1.0:

$$R_{\text{signal}} = 0.00172\sqrt{F} \quad \Omega/\text{m}$$
*(chap5.pdf, p.25)*

$$R_{\text{ground}} = 0.0003\sqrt{F} \quad \Omega/\text{m}$$
*(chap5.pdf, p.25)*

$$R_{(H1)\text{ac microstrip}} = R_{\text{signal}} + R_{\text{ground}} = 0.0020\sqrt{F} \quad \Omega/\text{m}$$
*(chap5.pdf, p.25)*

(Since $H_1 = H_2$, $R_{(H2)} = R_{(H1)}$)

$$R_{\text{ac stripline}} = \frac{R_{(H1)} \cdot R_{(H2)}}{R_{(H1)} + R_{(H2)}} = \frac{R_{(H1)}}{2} = 0.0010\sqrt{F} \quad \Omega/\text{m}$$
*(chap5.pdf, p.25)*

$$\Rightarrow R_s = 0.0010 \; \frac{\Omega}{\text{m}\cdot\sqrt{\text{Hz}}}$$
*(chap5.pdf, p.25)*

**Step 2 — Transition frequency** (where skin depth = conductor thickness):

$$\delta = \sqrt{\frac{\rho}{\pi F\mu}} \quad \Rightarrow \quad 0.63 \text{ mil} = \sqrt{\frac{1.72\times10^{-8}}{\pi[12.56\times10^{-7}]F}} \quad \Rightarrow F = 17 \text{ MHz}$$
*(chap5.pdf, p.26)*

- Below 17 MHz: $R_{\text{dc}} = \dfrac{\rho L}{Wt} = 8.5 \; \Omega/\text{m}$
- Above 17 MHz: $R_{\text{ac}} = (0.0010)\sqrt{F} \quad \Omega/\text{m}$

**Step 3 — Series resistance at 400 MHz:**

$$R_{\text{ac}}(400\text{ MHz}) = 0.0010\sqrt{400\times10^6} = 20.2 \; \Omega/\text{m}$$
*(chap5.pdf, p.27)*

**Step 4 — Shunt conductance (dielectric losses) at 400 MHz:**

$$\text{PD} = \frac{\sqrt{\varepsilon_r}}{c} = \frac{\sqrt{4}}{3\times10^8} = 6.67 \text{ ns/m}$$
*(chap5.pdf, p.27)*

$$Z_o = \frac{60}{\sqrt{4.0}}\ln\frac{4(10+10+0.63)}{0.67\pi[0.63+0.8(5)]} = 64 \; \Omega$$
*(chap5.pdf, p.27)*

$$C = \frac{\text{PD}}{Z_o} = \frac{6.67\times10^{-9}}{64} = 104 \text{ pF/m}$$
*(chap5.pdf, p.27)*

$$G = \frac{\varepsilon''}{\varepsilon'}(2\pi F C_{11}) = 0.013 \cdot 2\pi \cdot (400\text{ MHz}) \cdot (104\text{ pF}) = 0.0034 \text{ m}/\Omega$$
*(chap5.pdf, p.27)*

$$\Rightarrow \frac{1}{G} = 294 \; \Omega/\text{m}$$
*(chap5.pdf, p.27)*

---

## 2. Variations in the Dielectric Constant

### 2.1 PCB General Properties
*(chap5.pdf, p.28)*

$\varepsilon_r$ affects: propagation velocity, characteristic impedance, and crosstalk.

The value of $\varepsilon_r$ is **not constant** — it varies with:
- Frequency
- Temperature
- Moisture absorption
- For composite materials: relative proportions of components

### 2.2 FR4 Composition and Equations
*(chap5.pdf, p.29–30)*

FR4 = **epoxy matrix** reinforced by **woven glass cloth** → dielectric properties can **differ substantially** sample-to-sample.

**First-order approximation (volume-weighted):**

$$\varepsilon_r = \varepsilon_{\text{rsn}} V_{\text{rsn}} + \varepsilon_{\text{gls}} V_{\text{gls}}$$
*(chap5.pdf, p.29)*

where subscripts rsn = resin, gls = glass; $V$ = volume fraction.

$$V_{\text{rsn}} \approx 1 - \frac{H_{\text{gls}}}{H}, \qquad V_{\text{gls}} = \frac{H_{\text{gls}}}{H}$$
*(chap5.pdf, p.29)*

**Empirical equation from measurement:**

$$\varepsilon_r(V_{\text{rsn}}, F) = 6.32 - [2.17 + 0.168\log_{10}F(\text{kHz})]V_{\text{rsn}}$$
*(chap5.pdf, p.29)*

The glass cloth reinforcement has **no dielectric constant variation** with frequency in this range → epoxy resin (Vrsn) dominates.

> **Figure description (p.30):** Graph of relative dielectric constant $\varepsilon_r$ vs. frequency (0.01 MHz to 1000 MHz) for FR4. The curve starts at ~4.7 at low frequencies and decreases monotonically to ~3.9 at 1000 MHz. The decrease is gradual and roughly logarithmic.

---

## 3. Serpentine Traces

### 3.1 Why Serpentine Traces Are Used
*(chap5.pdf, p.31)*

Serpentine traces are used when:
- Board **aspect ratios** and **real estate limitations** force routing constraints
- Design specifications require **length equalization** (all traces same electrical length) but PCB area is limited

**Key problem:** Because of coupling between adjacent parallel sections of the serpentine, part of the signal propagates through **crosstalk coupling** (Path 2 = perpendicular shortcut through inter-segment coupling) rather than along the physical trace (Path 1). This **early arrival** reduces the effectiveness of length matching.

> **Figure description (p.31):** Diagram of a serpentine trace with labels: Driver, sections labeled $L_p$ (parallel section length), spacing $S$, and Receiver. Two paths shown: Path 1 (along the physical trace) and Path 2 (through crosstalk, perpendicular shortcut across the parallel sections). Arrow and text note: "Signal will propagate on the trace AND through the crosstalk perpendicular to the coupled sections."

### 3.2 Effects on Signal Integrity and Timing
*(chap5.pdf, p.32)*

- **Duration of ledges** (early-arrival signal steps at the receiver) is proportional to the physical length of the coupled sections $L_P$
- **Voltage magnitude of ledges** depends on the spacing $S$ between parallel sections

> **Figure description (p.32):** Top: Serpentine topology with 1-inch parallel sections and spacing $S$, cross-section showing trace width 5 mils, spacing $S$, $\varepsilon_r = 4.2$. Bottom: Two waveform plots at receiver. Left (edge rate = 30 ps): shows early arrival "ledge" before main step, for $S=5$ mils and $S=15$ mils vs. no serpentine. Right (edge rate = 250 ps): similar effect less visible. The earlier, smaller ledge is circled as "Early arrival."

### 3.3 Serpentine Trace Rules of Thumb
*(chap5.pdf, p.33)*

1. Make **minimum spacing** $S$ between parallel sections at least **3H to 4H** (where $H$ = height of signal conductor above ground plane) → minimizes coupling
2. **Minimize $L_P$** (length of serpentined sections) as much as possible → reduces total coupling magnitude
3. **Embedded microstrips and striplines** exhibit fewer serpentine effects than surface microstrip lines
4. **Do not serpentine clock traces**

---

## 4. Intersymbol Interference (ISI)

### 4.1 Definition
*(chap5.pdf, p.34)*

**ISI**: When reflections, crosstalk, or any other source has **not settled completely** before the next bit transition, the signal launched onto the line will be affected by residual noise from previous bits.

- ISI is especially severe when the **period is smaller than $2 \times$ the delay** of the transmission line
- To fully capture ISI effects: simulate with **long pseudorandom bit patterns** (PRBS)

### 4.2 Effect of ISI on Timing
*(chap5.pdf, p.35)*

ISI causes a **timing difference** between:
- The ideal waveform (starting transition with no noise)
- The noisy waveform (starting transition with unsettled noise on the bus)

> **Figure description (p.35):** Voltage vs. time plot showing two rising edges crossing the receiver switching threshold. The ideal edge (solid line) crosses at time $t_1$; the noisy edge (dashed line, starting from a different initial voltage due to ISI) crosses the threshold at a different time. The horizontal gap is labeled "Timing difference due to ISI." The noisy edge starts from "Different starting point due to ISI."

### 4.3 Alternative Simulation Method
*(chap5.pdf, p.36)*

To capture most timing impacts without full PRBS (which is expensive):

Simulate at three period multiples:
- $1\times$ fastest bus period → pattern: `010101010101010`
- $2\times$ fastest bus period → pattern: `001100110011001`
- $3\times$ fastest bus period → pattern: `000111000111000`

This is much faster than long PRBS while covering the key ISI scenarios.

### 4.4 Effect of ISI on Signal Integrity
*(chap5.pdf, p.37)*

Example: source impedance = 30 Ω, $Z_0 = 65$ Ω (overdriven case). ISI causes the waveform at the probe point to have different voltage levels depending on the previous bit pattern, causing:
- Variable overshoot magnitudes
- Variable settling levels
- Eye closure

> **Figure description (p.37):** Schematic shows voltage source $V$ with 30-ohm series resistor into $Z_0=65$-ohm TX line with probe at far end. Voltage vs. time waveform shows two overlaid bit patterns: 200 MHz (slower, larger swings) and 400 MHz (faster). The 400-MHz waveform shows ISI with varying peak levels and significant undershoots, while the ideal 400 MHz waveform (labeled) is shown for comparison.

### 4.5 ISI Rules of Thumb
*(chap5.pdf, p.38)*

1. **Minimize reflections** by avoiding impedance discontinuities; minimize stub lengths and large parasitics (packages, sockets, connectors)
2. **Keep interconnects short** as possible
3. **Avoid tightly coupled serpentine traces**
4. **Avoid line lengths** that cause signal integrity problems (ringback, ledges, overshoot) to coincide with the bus transition window
5. **Minimize crosstalk effects**

---

## 5. Effects of 90° Bends

### 5.1 Capacitive Effect of a 90° Bend
*(chap5.pdf, p.39)*

A 90° bend in a PCB trace creates **excess capacitance** (more copper area than a straight trace at the corner). For typical 50–65 Ω line widths:

$$C_{90°\text{ bend}} \approx C_{11} w$$
*(chap5.pdf, p.39)*

where $C_{11}$ = self-capacitance per unit length, $w$ = line width.

The excess area (compared to straight trace) is approximately:

$$\text{Excess Area} = \frac{1}{4} - \frac{\pi}{16} \approx 0.054 \text{ squares}$$
*(chap5.pdf, p.39)*

> **Figure description (p.39):** Left: Top-view of a 90° corner trace with dimensions $L_1$, $L_2$, and width $w$. The corner area is highlighted. Right: Zoomed view of the corner showing the square corner ($w$-corner) vs. a 45° chamfer ($w$-chamfer), with the formula for excess area = 0.054 squares.

### 5.2 Ways to Reduce 90° Bend Capacitance
*(chap5.pdf, p.40)*

Three methods:

1. **Rounding**: Round the corners to maintain constant trace width around the bend → virtually eliminates the effect; but round corners cause problems with many layout tools

2. **Chamfering**: Cut the corner at 45° → reduces the excess area by removing the outermost triangle

3. **45° bends**: Completely replace 90° bends with 45° bends → eliminates the problem at the source

> **Figure description (p.40):** Diagram comparing a 90° corner ($w\_corner$) vs. a 45° chamfer ($w\_chamfer$), showing how chamfering reduces the excess corner area.

### 5.3 Two Bends — Different Current Paths
*(chap5.pdf, p.41)*

In a trace with two 90° bends (U-shaped):
- **High-frequency currents** take the shorter diagonal path (hugging the inner corner) → signals **arrive early**
- **Low-frequency currents** take the longer outer path

> **Figure description (p.41):** U-shaped trace with two 90° bends. The outer physical path is shown in solid lines. A dashed diagonal arrow labeled "High frequency currents path" shows the shorter path that high-frequency signals can take through the inner corner area, arriving at the destination earlier than expected from the physical trace length.

---

## 6. Effect of Topology

### 6.1 Balanced T Topology
*(chap5.pdf, p.42)*

A T-topology with **equal leg lengths** $L_1 = L_2$ and equal impedances $Z_{o2}$ for both branches:

**Matched case** ($Z_{o2} = Z_{o1}$): clean step response to final value  
**Mismatched case** ($Z_{o2} = 2Z_{o1}$): initial overshoot, then settles to correct final value (faster settling due to impedance step up)

> **Figure description (p.42):** Circuit: source $V_s$ (0–2V) with $R_s = Z_o$ → main trunk line $Z_0$ → T-junction → two equal legs $Z_{o2}$, $L_1=L_2$ to Receiver 1 and Receiver 2. Voltage at receiver vs. time (0–10 ns): $Z_{o2}=Z_{o1}$ shows smooth step to 2V; $Z_{o2}=2Z_{o1}$ shows a larger initial step then settles at 2V.

### 6.2 Unbalanced T Topology — Matched Load
*(chap5.pdf, p.43–44)*

When leg lengths are **unequal** ($L_1 < L_2$), even with matched loads at each receiver, multiple reflections bounce between the junction and the receivers causing severe signal integrity degradation.

**Lattice diagram analysis for unbalanced T:**

Initial voltage:
$$V_{\text{initial}} = 2V\frac{Z_o}{Z_o + R_s} = 1\text{V}$$
*(chap5.pdf, p.43)*

Reflection coefficient at each branch (branch impedance = $Z_o/2$ = parallel of two $Z_o$ legs):

$$\rho_2 = \rho_3 = \frac{Z_o/2 - Z_o}{Z_o/2 + Z_o} = -\frac{1}{3}$$
*(chap5.pdf, p.43)*

Transmission to each branch:

$$T_2 = T_3 = 1 + \rho = \frac{2}{3}$$
*(chap5.pdf, p.43)*

**Successive voltage levels at Receiver 1** (shorter leg $L_1$):

| Event | Voltage |
|-------|---------|
| A: initial arrival | $2/3 + 2/3 = 4/3 = 1.33$ V |
| B: first reflected arrival | $4/3 + 2/3 - 2/9 - 2/9 = 8/9 = 0.888$ V |
| C: second reflected arrival | $\cdots = 16/9 = 1.77$ V |

**At Receiver 2** (longer leg):
- $A' = 4/3$, $B' = 20/9 = 2.22$ V, then ring around V=2

**Result:** Signal integrity **deteriorates dramatically** with multiple oscillations.

> **Figure description (p.44):** Lattice diagram with 4 vertical lines (A=Receiver 1, B=Junction, C=Junction, D=Receiver 2) showing bouncing waves. Voltage vs. time plot at receiver showing oscillating waveform peaking at 20/9 = 2.22 V initially, then oscillating around 2 V and never cleanly settling. Source = 0-2V, $R_s = Z_o$, unequal legs $L_1 < L_2$.

### 6.3 Lessons Learned from Topology Analysis
*(chap5.pdf, p.44)*

1. **Symmetry topology is critical**: leg lengths AND loading at each branch must be equal
2. **Minimize discontinuities** at topology junctions (impedance mismatches at the T-point)

---

## Key Equations Summary

| Quantity | Formula | Reference |
|----------|---------|-----------|
| DC resistance | $R = \rho L / (Wt)$ | *(chap5.pdf, p.4)* |
| Skin depth | $\delta = \sqrt{\rho/(\pi F\mu)}$ | *(chap5.pdf, p.6)* |
| AC signal resistance | $R_{\text{ac sig}} \approx \sqrt{\rho\pi\mu F}/W$ | *(chap5.pdf, p.9)* |
| Ground return AC resistance | $R_{\text{ac gnd}} \approx \sqrt{\rho\pi\mu F}/(6H)$ | *(chap5.pdf, p.11)* |
| Total AC microstrip resistance | $R_{\text{ac}} \approx \sqrt{\rho\pi\mu F}(1/W + 1/6H)$ | *(chap5.pdf, p.12)* |
| AC stripline resistance | $R_{\text{ac strip}} = R_{H1}\|R_{H2}$ (parallel) | *(chap5.pdf, p.13)* |
| Surface resistance | $R_s = \sqrt{\rho\pi\mu}$ (ohms·$\sqrt{\text{s}}$/square) | *(chap5.pdf, p.16)* |
| AC resistance from $R_s$ | $R_{\text{ac}} = R_s\sqrt{F}$ | *(chap5.pdf, p.15)* |
| Square wave Fourier series | $f(x)=\frac{2}{\pi}\sum_{n=1,3,5}\frac{1}{n}\sin(2\pi nFx)$ | *(chap5.pdf, p.17)* |
| Attenuation factor | $\alpha = R_2/(R_{\text{ac}}+R_2)$ | *(chap5.pdf, p.18)* |
| Complex dielectric constant | $\varepsilon = \varepsilon' - j\varepsilon''$ | *(chap5.pdf, p.20)* |
| Loss tangent | $\tan\delta_d = \varepsilon''/\varepsilon'$ | *(chap5.pdf, p.21)* |
| Dielectric conductance | $G = (\varepsilon''/\varepsilon')(2\pi F C_{11})$ | *(chap5.pdf, p.21)* |
| FR4 dielectric constant | $\varepsilon_r(V_{\text{rsn}},F) = 6.32 - [2.17+0.168\log_{10}F(\text{kHz})]V_{\text{rsn}}$ | *(chap5.pdf, p.29)* |
| 90° bend capacitance | $C_{90°} \approx C_{11}w$ | *(chap5.pdf, p.39)* |
| Unbalanced T: $\rho$ at branch | $\rho = (Z_o/2 - Z_o)/(Z_o/2+Z_o) = -1/3$ | *(chap5.pdf, p.43)* |
| Unbalanced T: transmission | $T = 1+\rho = 2/3$ | *(chap5.pdf, p.43)* |
