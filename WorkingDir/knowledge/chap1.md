# Chapter 1: The Importance of Interconnect Design

## Outline
- The Basics
- The Past and the Future

---

## 1. The Basics

### 1.1 Trace Length Compared with Wavelength
*(chap1.pdf, p.3)*

- In **100 ps**, light in free space travels about **30 mm (1.2 inches)**.
- PCB traces or silicon-level traces may be **larger than or comparable with** this length → the speed of light is "too slow" to treat the line as a simple wire.
- When trace length ≥ the wavelength of the highest frequency of interest, it must be treated as a **transmission line** (incorporating wave effects).
- If transmission lines are not handled properly, the **system timing** can be unintentionally ruined.

### 1.2 Interconnect and Its Influence on Waveform
*(chap1.pdf, p.4)*

- **Interconnect**: conductive paths carrying digital signals. Includes chip packages, connectors, sockets, and additional structures.
- A group of interconnects = a **bus**.
- The designer must guarantee that high voltages do not fall below $V_{ih}$ and low voltages remain below $V_{il}$ under all conditions.
- **Threshold region**: the region between $V_{ih}$ and $V_{il}$ where the logic level cannot be determined.

> **Figure description (p.4):** A waveform diagram shows a digital signal with the threshold region highlighted between $V_{ih}$ (upper dashed line) and $V_{il}$ (lower dashed line). Waveform segments that dip into this region create ambiguous logic levels.

### 1.3 Limitations of Rise and Fall Times
*(chap1.pdf, p.5)*

- To **maximize operating speed**, timing uncertainty in the threshold region must be minimized → rise/fall times must be as fast as possible.
- BUT faster rise/fall times → **higher spectral content** → capacitance, inductance, and frequency-dependent resistance of the wire must be considered.
- The wire then exhibits **delay** and **transient impedance** that cause distortions and glitches.

> **Figure description (p.5):** Timing uncertainty is shown as the horizontal spread of the waveform crossing the threshold band. Faster edges reduce this spread.

### 1.4 Spectrum of Trapezoidal (Clock) Waveforms
*(chap1.pdf, p.6)*

- **Periodic trapezoidal pulse train** with equal rise/fall times ($\tau_r = \tau_f$).
- **Key parameters:**
  - $\tau_r$: rise time, 10–90% of amplitude
  - $\tau_f$: fall time, 10–90% of amplitude
  - $\tau$: pulse width (at midpoints)
  - $T$: period

- **Spectral envelope** has three regions:
  - **0 dB/decade** (flat) up to $f_1 = 1/(\pi\tau)$
  - **−20 dB/decade** from $f_1$ to $f_2$
  - **−40 dB/decade** above $f_2$

- **Highest frequency of interest:**

$$f_2 = \frac{1}{\pi \tau_r} = \frac{0.32}{\tau_r}$$
*(chap1.pdf, p.6)*

- The peak spectral amplitude at DC is $\frac{2A\tau}{T}$ (where A = signal amplitude).

> **Figure description (p.6):** Left: trapezoidal pulse train in time domain showing parameters $t_r$, $t_f$, $\tau$, $T$, amplitude $A$ (with 0.5A marked). Right: corresponding frequency spectrum envelope on log scale, showing the three slope regions and breakpoints $f_1 = 1/\pi\tau$ and $f_2 = 1/\pi t_r$.

### 1.5 When Conductors Must Be Treated as Transmission Lines
*(chap1.pdf, p.7)*

- Rule: when physical circuit size **approaches the wavelength** of the highest frequency of interest.
- Practical criterion: **any circuit length ≥ 1/10 of the electrical length** corresponding to the rise time must be treated as a TX line.

**Derivation:**

For a signal with rise time $t_r$:

$$f = \frac{0.35}{t_r}, \quad \lambda = \frac{c}{f}$$
*(chap1.pdf, p.7)*

For a circuit with time delay $TD_l$:

$$f_l = \frac{0.35}{TD_l} = \frac{0.35}{t_r/10} = 10 \cdot \frac{0.35}{t_r} = 10f$$
*(chap1.pdf, p.7)*

$$\lambda_l = \frac{c}{f_l} = \frac{c}{10f} = \frac{\lambda}{10}$$
*(chap1.pdf, p.7)*

→ A conductor of electrical length ≥ $\lambda/10$ must be modeled as a TX line.

> **Figure description (p.7):** Diagram of a driver–receiver pair connected by a PCB trace. "Rise time" arrow spans the edge, "Delay length of circuit" arrow spans the full trace. Annotations show the two sets of equations for the signal and circuit.

---

## 2. The Past and the Future

### 2.1 Moore's Law
*(chap1.pdf, p.8)*

- Gordon Moore (co-founder of Intel) predicted that **computer performance doubles every 18 months**.
- Historical data (4004 → Pentium III, 1971–1999) shows CPU speed rising from ~0 MHz to ~800 MHz.

> **Figure description (p.8):** Bar chart of processor speed (MHz) vs. processor type (4004 through Pentium III). An exponential-looking increase is visible, consistent with Moore's Law.

### 2.2 Bus Speed is the Bottleneck (Revised Law)
*(chap1.pdf, p.9)*

- As **core frequency increases**, faster data rates are demanded from buses.
- **Decreased timing budgets** → even more critical to properly account for bus effects.
- At high frequencies, **new variables and effects** arise that challenge digital system design.

> **Figure description (p.9):** Dual-axis graph. Left y-axis: bus speed (Mega-transfers); right y-axis: interconnect budget (ps). The "interconnect budget" (dashed) decreases over time while "bus speed" (solid) increases, and "increasing processor speeds" arrow shows the driver. The two curves converge, indicating the bottleneck.
