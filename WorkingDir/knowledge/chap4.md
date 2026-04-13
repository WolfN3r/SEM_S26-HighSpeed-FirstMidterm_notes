# Chapter 4: Coupled Microstrip Line

## Outline
- Literature Examples
- Motivations
- Coupled Microstrip Line
- Coupled Microstrip Line Using Front-End Decoupling Capacitor
- Coupled Microstrip Line Using Distributed Decoupling Capacitors
- Conclusions

---

## 1. Literature Examples

*(chap4.pdf, p.3–7)*

Four prior art approaches to reduce far-end crosstalk (FEXT) on coupled microstrip lines are summarized below.

### 1.1 Guard Trace [Ref. 1]
*(chap4.pdf, p.3)*

A floating guard trace is placed between the aggressor (active line) and victim (quiet line) on the PCB surface.

- **Advantage:** Easy implementation with standard PCB process
- **Disadvantage:** Only a *slight* reduction of far-end crosstalk noise

> **Figure description (p.3):** 3-D view of three parallel PCB traces on FR4 substrate: aggressor (left), guard (center), victim (right). All sit on top of the dielectric. No vias present.

### 1.2 Grounded Guard Trace [Ref. 2]
*(chap4.pdf, p.4)*

A guard trace with via connections to ground is placed between aggressor and victim.

- **Advantage:** Efficient reduction of far-end crosstalk noise
- **Disadvantage:** Layout area is limited due to via placement constraints

> **Figure description (p.4):** Top-view schematic showing three horizontal traces (ports 1–4 at ends). The middle (guard) trace has periodic circular via symbols connecting it to ground.

### 1.3 Grounded Guard Trace with Dielectric Overlay [Ref. 3]
*(chap4.pdf, p.5)*

A grounded guard trace plus a dielectric superstrate (overlay) placed on top of the PCB structure.

- **Advantage:** Efficient FEXT reduction using only two vias
- **Disadvantage:** Additional cost of the dielectric overlay

> **Figure description (p.5):** 3-D cross-section view showing Active Line, Guard Trace, and Victim Line on FR4 substrate with $\varepsilon_r$, overlaid with a dielectric layer of height $h_l$. Vias at each end of the guard trace connect to ground.

### 1.4 Serpentine Guard Trace [Ref. 4]
*(chap4.pdf, p.6)*

A serpentine-shaped guard trace (no vias, no dielectric overlay) placed between the two signal lines.

- **Advantage:** Efficient FEXT reduction without vias or dielectric overlay
- **Disadvantage:** Large PCB area required for the serpentine pattern

> **Figure description (p.6):** 3-D view showing aggressor and victim parallel traces with a meandering serpentine trace between them, all on FR4.

### 1.5 Alternately Open-Circuited Stubs [Ref. 5]
*(chap4.pdf, p.7)*

Open-circuited stubs placed alternately along both the aggressor and victim lines.

- **Advantage:** Reduces the area compared to serpentine guard trace
- **Disadvantage:** Causes large reflections on the signal line

> **Figure description (p.7):** Schematic showing two parallel transmission lines (Aggressor Line and Victim Line) each with alternating T-stub branches that are open-circuited. Source with $V_{s1}$ and termination resistors $R_0$ at each end.

---

## 2. Motivations

*(chap4.pdf, p.8)*

The chapter proposes a new solution that addresses all the disadvantages of prior work simultaneously:

| Goal | What to Eliminate |
|------|-------------------|
| Save cost | Eliminate dielectric overlay |
| Increase routing flexibility | Eliminate vias |
| Save PCB area | Eliminate serpentine guard trace |
| Reduce reflections | Eliminate alternately open-circuited stubs |

---

## 3. Coupled Microstrip Line (Baseline)

### 3.1 Topology and Parameters
*(chap4.pdf, p.9)*

- **Substrate:** FR4, $\varepsilon_r = 4.4$, $\tan\delta = 0.02$
- **Structure:** Active Line and Quiet Line as parallel microstrip traces

**Dimensions:**

| $w$ (mm) | $s$ (mm) | $h$ (mm) | $l$ (mm) |
|----------|----------|----------|----------|
| 1.42 | 0.7 | 0.8 | 40 |

where $w$ = trace width, $s$ = spacing between traces, $h$ = substrate height, $l$ = trace length.

**Equivalent circuit per unit length:**
- Self inductance $L_s$ per line
- Mutual inductance $L_m$ between lines
- Self capacitance $C_s$ per line (to ground)
- Mutual capacitance $C_m$ between lines

> **Figure description (p.9):** Left: 3-D view of two parallel orange traces on grey FR4, with labels "Active Line," "Quiet Line," "Near End," "Far End," rise time $t_r$, and length $l$. Center-right: cross-sectional view showing trace width $w$, spacing $s$, substrate height $h$, and $\varepsilon_r$. Far right: lumped equivalent circuit segment with series $L_s$ and $L_m$ (mutual) and shunt $C_s$ and $C_m$.

### 3.2 Even- and Odd-Mode Equivalent Circuits
*(chap4.pdf, p.10)*

**Even-mode equivalent circuit:** Both lines driven in phase. Mutual inductor adds ($L_s + L_m$), no current through $C_m$.

$$TD_{even} = l\sqrt{(L_s + L_m)(C_s)}$$
*(chap4.pdf, p.10)*

**Odd-mode equivalent circuit:** Lines driven out of phase. Mutual inductor subtracts ($L_s - L_m$), capacitance doubles ($C_s + 2C_m$).

$$TD_{odd} = l\sqrt{(L_s - L_m)(C_s + 2C_m)}$$
*(chap4.pdf, p.10)*

> **Figure description (p.10):** Left circuit (even): each line has series inductor $L_s + L_m$ and shunt capacitor $C_s$ to ground; no coupling between lines. Right circuit (odd): each line has series inductor $L_s - L_m$ and shunt capacitors $C_s$ (to ground) plus $2C_m$ (between lines). The two circuits are labeled "Active Line" and "Quiet Line."

### 3.3 FEXT and NEXT — Even/Odd Decomposition
*(chap4.pdf, p.11)*

The four-port system (Active: Port 1→Port 3; Quiet: Port 2→Port 4) is analyzed by superimposing even- and odd-mode excitations:

- **Direct excitation:** source $V_s$ on active line only, $Z_0$ terminates all ports.
- **Even-mode excitation:** source $V_s/2$ on each line with same polarity; each line sees $Z_{even}$.
- **Odd-mode excitation:** source $+V_s/2$ on active and $-V_s/2$ on quiet line; each line sees $Z_{odd}$.

$$V_4(t) = V_{4e}(t) + V_{4o}(t)$$
*(chap4.pdf, p.11)*

$$V_2(t) = V_{2e}(t) + V_{2o}(t)$$
*(chap4.pdf, p.11)*

> **Figure description (p.11):** Three circuit diagrams stacked. Top (direct): single source $V_s$ feeding Port 1 of Active Line through $Z_0$, Quiet Line grounded through $Z_0$ at Port 2; both far ends terminated in $Z_0$. Middle (even): sources $V_s/2$ on both lines, lines modeled as $Z_{even}$, $\varepsilon_{even}$. Bottom (odd): source $+V_s/2$ on active, $-V_s/2$ on quiet; lines modeled as $Z_{odd}$, $\varepsilon_{odd}$.

### 3.4 FEXT and NEXT — Ideal Coupled Line Results
*(chap4.pdf, p.12–13)*

**Simulation results for the baseline structure:**

| $TD_{even}$ (ps) | $TD_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|----------------|------------|
| 253.614 | 229.202 | 24.412 |

where $T_d = TD_{even} - TD_{odd}$ is the time difference between modes.

- **Far-end crosstalk noise (FEXT):** 0.076 V
- **Near-end crosstalk noise (NEXT):** 0.019 V

The FEXT waveform is a negative pulse of duration $T_d$ arriving at $t = TD_{odd}$.

> **Figure description (p.12):** Left graph shows even-mode (positive ramp) and odd-mode (negative ramp) signals at far end vs. time; $TD_{even}$ and $TD_{odd}$ arrows show their respective arrival times, with $T_d$ as the gap. Right graph shows the resulting FEXT $V_4(t)$: a negative spike of ~-0.076 V near $t = 0.27$ ns followed by a return to zero.

> **Figure description (p.13):** NEXT $V_2(t)$ plot: a trapezoidal positive pulse starting at $t = 0$, plateauing at ~0.019 V, lasting from 0 to ~0.5 ns (= $2 \times TD$), then decaying.

### 3.5 FEXT and NEXT Estimation Equations
*(chap4.pdf, p.14)*

**Peak of NEXT occurs at $t = t_r$:**

$$V_2(t_r) = V_{2e}(t_r) + V_{2o}(t_r)$$
*(chap4.pdf, p.14)*

$$V_{2e}(t_r) = \frac{V_s}{2}\left(\frac{Z_{even}}{Z_{even} + Z_0}\right)$$
*(chap4.pdf, p.14)*

$$V_{2o}(t_r) = -\frac{V_s}{2}\left(\frac{Z_{odd}}{Z_{odd} + Z_0}\right)$$
*(chap4.pdf, p.14)*

**Peak of FEXT occurs at $t = TD_{even}$:**

$$V_4(t) = V_{4o}(t) + V_{4e}(t)$$
*(chap4.pdf, p.14)*

$$|V_4(TD_{even})| = V_{max} \cdot \min\!\left(\frac{T_d}{t_r},\, 1\right)$$
*(chap4.pdf, p.14)*

$$V_{max} = \frac{Z_0}{Z_{even} + 2Z_0 + Z_{odd}} V_s$$
*(chap4.pdf, p.14)*

> **Figure description (p.14):** Equations annotated on two boxed formulas. The NEXT box highlights $V_2(t_r) = V_{2e}(t_r) + V_{2o}(t_r)$. The FEXT box highlights $|V_4(TD_{even})| = V_{max}\min(T_d/t_r, 1)$.

### 3.6 Lossless Coupled Microstrip Line
*(chap4.pdf, p.15–16)*

When dispersion is included (lossless model with frequency-dependent $\varepsilon_{eff}$):

| $TD_{even}$ (ps) | $TD_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|----------------|------------|
| 254.414 | 234.002 | 20.412 |

- **FEXT:** 0.0641 V
- **NEXT:** 0.0169 V

> **Figure description (p.15):** Left graph: even and odd mode waveforms at far end, showing slight temporal shift due to dispersion (dashed "with dispersion" vs. solid "without dispersion"). Right graph: FEXT $V_4(t)$ showing close match between direct simulation and sum of even/odd components.

> **Figure description (p.16):** NEXT $V_2(t)$ for lossless case: plateau at ~0.0169 V from $t=0$ to ~$2 \times TD$ ≈ 0.5 ns.

### 3.7 Lossy Coupled Microstrip Line
*(chap4.pdf, p.17–18)*

Including conductor and dielectric losses ($\tan\delta = 0.02$):

| $TD_{even}$ (ps) | $TD_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|----------------|------------|
| 258.814 | 238.202 | 20.612 |

| | FEXT (V) | NEXT (V) |
|---|---|---|
| Simulation (ADS source) | 0.063 | 0.0180 |
| Simulation (measured source) | — | — |
| Measurement | 0.055 | 0.0163 |

> **Figure description (p.17):** Left: even/odd mode time waveforms showing amplitude reduction due to loss (dashed "With Loss" curves are smaller than solid "Without Loss"). Right: FEXT $V_4(t)$ comparing ADS simulation, simulation with measured source, and physical measurement — all closely match.

> **Figure description (p.18):** NEXT $V_2(t)$ for lossy case with photo of real PCB circuit (two SMA connectors on each end of FR4 board with two parallel copper traces visible). Plot shows flat-top NEXT pulse agreeing between simulation and measurement.

### 3.8 Eye Diagram — Baseline
*(chap4.pdf, p.19–21)*

**Simulation Setup:** PRBS source $V_s$ on active line; observe $V_3$ (far end of active line).

**Eye diagram performance vs. bit rate:**

| Bit Rate | $t_r$ | Eye High (%) | Eye Width (%) | Jitter (%) |
|----------|--------|--------------|---------------|------------|
| 2 Gbps | 50 ps | 97.2 | 99.6 | 4.44 |
| 4 Gbps | 25 ps | 95.2 | 99.6 | 4.44 |
| 8 Gbps | 12.5 ps | 94 | 99.76 | 4.432 |
| **16 Gbps** | **6.25 ps** | **79.6** | **99.2** | **13.36** |

At 16 Gbps the eye height degrades noticeably (79.6%) and jitter increases significantly (13.36%).

> **Figure description (p.20):** Four eye diagram plots (voltage vs. time) for 2, 4, 8, and 16 Gbps. At lower rates the eye is wide open; at 16 Gbps the eye begins to close with visible jitter spreading.

---

## 4. Coupled Microstrip Line Using Front-End Decoupling Capacitor

### 4.1 Topology
*(chap4.pdf, p.22)*

**Same FR4 substrate and trace dimensions as baseline** ($\varepsilon_r=4.4$, $\tan\delta=0.02$, $w=1.42$ mm, $s=0.7$ mm, $h=0.8$ mm, $l=40$ mm), but a capacitor $C_f$ is added between the two lines at the near end (source end).

In the equivalent circuit, the front-end capacitor appears as a distributed element $C_f/l$ added in parallel with $C_m$ across the entire line length.

> **Figure description (p.22):** Same 3-D and cross-sectional views as baseline, but the 3-D view shows a lumped capacitor $C_f$ connected between the Active Line and Quiet Line at the Near End. The equivalent circuit segment now shows $C_f/l$ in parallel with $C_m$.

### 4.2 Even- and Odd-Mode Equivalent Circuits with $C_f$
*(chap4.pdf, p.23)*

The even-mode circuit is **unchanged** (the capacitor $C_f$ appears as a differential element and does not affect even mode):

$$TD_{even} = l\sqrt{(L_s + L_m)(C_s)}$$
*(chap4.pdf, p.23)*

The odd-mode circuit gains extra capacitance from $2C_f/l$ per unit length:

$$TD^c_{odd} = l\sqrt{\left(C_s + 2C_m + \frac{2C_f}{l}\right)(L_s - L_m)}$$
*(chap4.pdf, p.23)*

> **Figure description (p.23):** Left (even): unchanged from baseline — $L_s+L_m$ series inductor, $C_s$ shunt capacitor, no $C_f$. Right (odd): $L_s-L_m$ series inductor, shunt capacitors $C_s$ + $2C_m$ + $2C_f/l$ in parallel.

### 4.3 Design Concept — Making $TD_{even} = TD^c_{odd}$
*(chap4.pdf, p.24)*

The key idea: choose $C_f$ so that the modified odd-mode time delay equals the even-mode time delay, i.e., $T_d = 0$.

Define:
- $TD_{even}$: even-mode delay (same with or without $C_f$)
- $TD_{odd}$: odd-mode delay *without* $C_f$
- $TD^c_{odd}$: odd-mode delay *with* $C_f$
- $T_d$: original time difference = $TD_{even} - TD_{odd}$

**Condition for zero FEXT:**

$$T_d = TD_{even} - TD_{odd} = TD^c_{odd} - TD_{odd}$$
*(chap4.pdf, p.24)*

**Solving for required $C_f$:**

$$T_d = l\sqrt{L_s - L_m}\left(\sqrt{C_s + 2C_m + \frac{2C_f}{l}} - \sqrt{C_s + 2C_m}\right)$$
*(chap4.pdf, p.24)*

Rearranging to find the needed $C_f$ that makes $TD^c_{odd} = TD_{even}$.

### 4.4 FEXT and NEXT — Even/Odd Decomposition with $C_f$
*(chap4.pdf, p.25)*

The decomposition is the same as before, but in the odd-mode circuit the front-end capacitor becomes $2C_f$ (one at each port of the odd-mode equivalent).

**Design example:** $T_d = 24.412$ ps → requires $C_f = 0.6$ pF.

> **Figure description (p.25):** Three circuit diagrams showing direct excitation (with $C_f$ between ports), even-mode excitation (no $C_f$ — unchanged), and odd-mode excitation (with $2C_f$ capacitors at both the source and far end of each line).

### 4.5 FEXT and NEXT — Ideal Coupled Line with $C_f$
*(chap4.pdf, p.26–27)*

With $C_f = 0.6$ pF, $T_d = 0$:

| $TD_{even}$ (ps) | $TD^c_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|------------------|------------|
| 253.614 | 253.614 | **0** |

- **FEXT:** reduced from 0.076 V → **0.027 V**
- **NEXT:** increased from 0.019 V → **0.080 V**

The FEXT is not zero even though $T_d = 0$ because of residual reflections from the lumped capacitor.

> **Figure description (p.26):** Left: even-mode signal (positive ramp) and odd-mode (negative step + exponential decay due to $C_f$ RC effect) at far end — they arrive at the same time ($T_d = 0$) but have different shapes due to the capacitor. Right: FEXT $V_4(t)$ shows a much smaller disturbance (≈0.027 V peak) compared to baseline.

> **Figure description (p.27):** NEXT $V_2(t)$ with $C_f$ shows a sharp initial spike to 0.080 V (due to the lumped capacitor charging current) followed by exponential decay.

### 4.6 FEXT and NEXT Estimation Equations with $C_f$
*(chap4.pdf, p.28–29)*

**Odd-mode equivalent circuit at near end (Port 2):**

The source $-V_s(t)/2$ charges capacitor $2C_f$ through the parallel combination of $Z_0$ and $Z_{odd}$. Defining:

$$V_{oc} = -\frac{V_s}{2t_r}\left(\frac{Z_{odd}}{Z_0 + Z_{odd}}\right), \qquad R_t = \frac{Z_0 Z_{odd}}{Z_0 + Z_{odd}}, \qquad \tau = 2R_t C_f$$
*(chap4.pdf, p.28)*

The near-end odd-mode voltage:

$$V_{2o}(t) = V_{oc}\tau\left[(e^{-t/\tau}-1)u(t) - (e^{-(t-t_r)/\tau}-1)u(t-t_r)\right] + V_{oc}(t)$$
*(chap4.pdf, p.28)*

**Peak of NEXT at $t = t_r$:**

$$V_2(t_r) = \frac{V_s}{2}\left(\frac{Z_{even}}{Z_{even}+Z_0}\right) + V_{oc}\tau(e^{-t_r/\tau}-1) + V_{oc}t_r, \quad \tau = 2R_tC_f$$
*(chap4.pdf, p.29)*

**Peak of FEXT at $t = TD_{odd} + T_d + t_r$:**

$$V_4(t) = V_{4o}(t) + V_{4e}(t)$$
*(chap4.pdf, p.29)*

$$V_{4o}(t) = \left(\frac{2Z_0}{Z_0+Z_{odd}}\right)V_{2o}(t - TD_{odd})$$
*(chap4.pdf, p.29)*

$$V_4(TD_{odd}+T_d+t_r) = \left(\frac{2Z_0}{Z_0+Z_{odd}}\right)\left[V_{oc}\tau(e^{-(t_r+T_d)/\tau} - e^{-T_d/\tau}) + V_{oc}t_r\right] + V_{max}$$
*(chap4.pdf, p.29)*

### 4.7 FEXT and NEXT — Lossless Coupled Microstrip with $C_f$
*(chap4.pdf, p.30–31)*

With $T_d = 20.412$ ps (lossless case) → $C_f = 0.5$ pF:

| $TD_{even}$ (ps) | $TD^c_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|------------------|------------|
| 254.414 | 254.414 | **0** |

- **FEXT:** reduced from 0.0641 V → **0.018 V**
- **NEXT:** 0.071 V (increased vs. baseline 0.0169 V)

### 4.8 FEXT and NEXT — Lossy Coupled Microstrip with $C_f$
*(chap4.pdf, p.32–33)*

With $T_d = 20.612$ ps (lossy) → $C_f = 0.5$ pF:

| $TD_{even}$ (ps) | $TD^c_{odd}$ (ps) | $T_d$ (ps) |
|-----------------|------------------|------------|
| 258.814 | 258.814 | **0** |

| | FEXT (V) | NEXT (V) |
|---|---|---|
| Simulation | 0.0257 | 0.0710 |
| Measurement | 0.0268 | 0.0636 |

> **Figure description (p.33):** Photo of real circuit with front-end $C_f$ (slightly longer PCB board with surface-mount capacitor visible near one end). NEXT $V_2(t)$ shows the sharp initial spike characteristic of the charging $C_f$.

### 4.9 Eye Diagram with Front-End $C_f$
*(chap4.pdf, p.34–36)*

| Bit Rate | $t_r$ | Eye High (%) | Eye Width (%) | Jitter (%) |
|----------|--------|--------------|---------------|------------|
| 2 Gbps | 50 ps | 97.2 | 99.6 | 4.44 |
| 4 Gbps | 25 ps | 88.8 | 99.6 | 4.44 |
| 8 Gbps | 12.5 ps | 86 | 99.2 | **8.88** |
| **16 Gbps** | **6.25 ps** | **64.4** | **97.44** | **31.2** |

**Comparison with baseline at 16 Gbps:** Eye height worsens (64.4% vs. 79.6%), jitter worsens (31.2% vs. 13.36%). The front-end $C_f$ reduces FEXT but *degrades* the eye diagram due to the NEXT spike and impedance mismatch.

### 4.10 S-Parameters with Front-End $C_f$
*(chap4.pdf, p.37–38)*

S-parameter comparison among: Coupled Microstrip Line (baseline), Front-End $C_f$, and Stub-Alternated [Ref. 5].

**Reflection ($|S_{11}|$) and Near-End Coupling ($|S_{21}|$):**
- Front-End $C_f$ shows much higher $|S_{11}|$ and $|S_{21}|$ (worse) than baseline or stub-alternated design across 0–6 GHz.
- The baseline coupled microstrip line shows periodic notches (deep nulls) in both $S_{11}$ and $S_{21}$.

**Transmission ($|S_{31}|$) and Far-End Coupling ($|S_{41}|$):**
- Front-End $C_f$ has slightly more insertion loss ($|S_{31}|$) than baseline due to the shunt capacitor.
- $|S_{41}|$ (FEXT in frequency domain): Front-End $C_f$ significantly improves (lowers) the far-end coupling compared to baseline.

> **Figure description (p.37):** Two frequency plots (0–6 GHz). Left: $|S_{11}|$ — baseline has oscillating notches (good), Front-End $C_f$ is nearly flat near −10 dB (poor), Stub-Alternated has notches. Right: $|S_{21}|$ — similar pattern.

> **Figure description (p.38):** Two frequency plots. Left: $|S_{31}|$ (transmission) — both lines similar, Front-End $C_f$ slightly lower. Right: $|S_{41}|$ (FEXT) — Front-End $C_f$ shows much lower coupling than baseline (−20 to −40 dB range vs. baseline −5 to −15 dB range).

---

## 5. Coupled Microstrip Line Using Distributed Decoupling Capacitors

### 5.1 Concept and Topology
*(chap4.pdf, p.39)*

Instead of one lumped $C_f$ at the front end, the total capacitance $C_f = 0.5$ pF is distributed along the line as $N$ smaller capacitors $\Delta C_f = C_f / N$ spaced at intervals $\Delta l$.

**Design rule for spacing $\Delta l$:** Use the guided wavelength at the 3-dB bandwidth frequency.

$$f_{3\text{dB}} = \frac{0.35}{t_r}$$
*(chap4.pdf, p.39)*

$$\lambda = \frac{3\times10^8}{f_{3\text{dB}}} \cdot \frac{1}{\sqrt{\varepsilon_{eff}}}$$
*(chap4.pdf, p.39)*

**Distributed capacitor configurations (for $C_f = 0.5$ pF total):**

| $\Delta l$ (mm) | Fraction of $\lambda$ | Number of caps | $\Delta C_f$ (pF) each |
|-----------------|----------------------|----------------|----------------------|
| 9.2 | $\lambda/2$ | 4 | 0.1250 |
| 4.6 | $\lambda/4$ | 8 | 0.0625 |
| 1.9 | $\lambda/10$ | 20 | 0.0250 |

> **Figure description (p.39):** Circuit schematic showing Active Line and Quiet Line with multiple small capacitors $\Delta C_f$ placed at regular intervals $\Delta l$ along the coupled region. Same $Z_0$ source and terminations as before.

### 5.2 FEXT and NEXT — Distributed $C_f$ Results
*(chap4.pdf, p.40)*

Comparison of near- and far-end crosstalk for different $\Delta l$ spacings vs. lumped $C_f$:

| Configuration | FEXT (V) | NEXT (V) |
|---------------|----------|----------|
| Lumped $C_f$ | 0.0257 | 0.071 |
| $\Delta l = \lambda/10$ | **0** | **0.028** |

The $\lambda/10$ distributed case achieves:
- FEXT → effectively **0** (eliminated)
- NEXT reduced from 0.071 V (lumped) to **0.028 V** (much improved)

> **Figure description (p.40):** Left: NEXT $V_2(t)$ for lumped $C_f$, $\lambda/2$, $\lambda/4$, $\lambda/10$ spacings — as spacing decreases, the initial spike flattens and approaches the unmodified crosstalk shape but at much lower amplitude. Right: FEXT $V_4(t)$ — the $\lambda/10$ distributed case shows essentially zero far-end crosstalk.

### 5.3 S-Parameters — Distributed $C_f$
*(chap4.pdf, p.41–42)*

**Reflection ($|S_{11}|$) and Near-End Coupling ($|S_{21}|$):**
- As spacing $\Delta l$ decreases (more capacitors, finer distribution), $|S_{11}|$ improves (approaches baseline coupled microstrip performance).
- The $\lambda/10$ distributed case nearly matches the baseline in reflection performance.

**Transmission ($|S_{31}|$) and Far-End Coupling ($|S_{41}|$):**
- Distributed $\Delta C_f$ at $\lambda/10$ shows significantly better transmission (less insertion loss) than lumped $C_f$.
- $|S_{41}|$ (far-end coupling) for $\lambda/10$ distributed case shows very deep notches (better FEXT suppression) across the 0–6 GHz band compared to all other configurations.

> **Figure description (p.41):** S-parameter plots comparing 5 configurations: baseline, front-end $C_f$, $\lambda/2$, $\lambda/4$, $\lambda/10$ distributed, and Stub-Alternated [5]. The $\lambda/10$ distributed case tracks closely to the baseline for both $|S_{11}|$ and $|S_{21}|$.

> **Figure description (p.42):** $|S_{31}|$ (transmission): distributed cases nearly identical to baseline. $|S_{41}|$ (far-end coupling): distributed $\lambda/10$ case achieves −50 to −80 dB suppression with periodic notches — significantly better than all prior art.

---

## 6. Conclusions

*(chap4.pdf, p.43)*

**Final comparison table (lossy microstrip, $t_r = 40$ ps):**

| Configuration | FEXT (V) Meas. | FEXT (V) Sim. | NEXT (V) Meas. | NEXT (V) Sim. |
|--------------|---------------|--------------|---------------|--------------|
| Conventional | 0.0550 | 0.0630 | 0.0163 | 0.0180 |
| Front-end $C_f$ | 0.0268 | 0.0257 | 0.0636 | 0.0710 |
| Distributed $C_f$ | X (not meas.) | **0** | X (not meas.) | **0.0280** |

**Key conclusions:**

1. **FEXT and NEXT:**
   - Front-end $C_f$ reduces FEXT (by ~52%) but increases NEXT (by ~4×)
   - Distributed $C_f$ ($\lambda/10$) reduces FEXT to **zero** and limits NEXT to 0.028 V

2. **Eye Diagram:**
   - Performance is *degraded* when a front-end (lumped) decoupling capacitor is used due to the large NEXT spike and impedance discontinuity.
   - Distributed capacitors restore eye performance closer to baseline.

3. **S-Parameters:**
   - Reflection and transmission performance are *restored* when using distributed (finer-spacing) capacitors.
   - The $\lambda/10$ distributed case achieves far-end coupling ($|S_{41}|$) suppression to −50 dB or better across 0–6 GHz.

---

## Key Equations Summary

| Quantity | Formula | Reference |
|----------|---------|-----------|
| Even-mode TD (no $C_f$) | $TD_{even} = l\sqrt{(L_s+L_m)C_s}$ | *(chap4.pdf, p.10)* |
| Odd-mode TD (no $C_f$) | $TD_{odd} = l\sqrt{(L_s-L_m)(C_s+2C_m)}$ | *(chap4.pdf, p.10)* |
| Odd-mode TD (with $C_f$) | $TD^c_{odd} = l\sqrt{(C_s+2C_m+2C_f/l)(L_s-L_m)}$ | *(chap4.pdf, p.23)* |
| NEXT peak | $V_2(t_r)=\frac{V_s}{2}\frac{Z_{even}}{Z_{even}+Z_0}-\frac{V_s}{2}\frac{Z_{odd}}{Z_{odd}+Z_0}$ | *(chap4.pdf, p.14)* |
| FEXT peak magnitude | $\|V_4(TD_{even})\| = V_{max}\min(T_d/t_r,1)$ | *(chap4.pdf, p.14)* |
| $V_{max}$ for FEXT | $V_{max}=\frac{Z_0}{Z_{even}+2Z_0+Z_{odd}}V_s$ | *(chap4.pdf, p.14)* |
| Required $T_d$ compensation | $T_d=l\sqrt{L_s-L_m}\!\left(\sqrt{C_s+2C_m+\frac{2C_f}{l}}-\sqrt{C_s+2C_m}\right)$ | *(chap4.pdf, p.24)* |
| 3-dB frequency | $f_{3\text{dB}} = 0.35/t_r$ | *(chap4.pdf, p.39)* |
| Guided wavelength | $\lambda = \frac{3\times10^8}{f_{3\text{dB}}\sqrt{\varepsilon_{eff}}}$ | *(chap4.pdf, p.39)* |
| RC time constant ($C_f$ circuit) | $\tau = 2R_tC_f$, where $R_t = Z_0 Z_{odd}/(Z_0+Z_{odd})$ | *(chap4.pdf, p.28)* |
