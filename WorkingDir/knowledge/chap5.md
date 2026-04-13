# Non-ideal Interconnect Issues

> Source: `chap5_HSDSD.pdf`  
> Instructor: Chun-Long Wang, National Taiwan University of Science and Technology

---

## 5.1 Why Losses Matter *(p.3)*

As digital systems push to higher speeds:
- Smaller geometries + higher signal rates → **frequency content rises**
- Resistive losses become more severe
- **Signal amplitude decreases** → reduced noise margins and slower edge rates → timing degradation

Two types of **dispersion** arise:
1. Loss varies with frequency
2. Phase velocity varies with frequency

Both are caused by the non-ideal characteristics of real transmission lines.

---

## 5.2 DC Conductor Losses *(p.4)*

DC resistance depends on:
- **Resistivity** of the conductor material
- **Cross-sectional area** of the current path

$$R_{\text{DC}} = \frac{\rho \cdot L}{A}$$

*(chap5.pdf, p.4)*

- Primarily a concern for very small geometry conductors, very long lines, and multiload buses.
- Ground return path losses are usually **negligible** at DC (large cross-sectional area).

**Note:** For FR4 substrates, when frequency increases beyond DC up to 15 GHz, the **substrate (dielectric) loss dominates** over the conductor loss. *(p.5)*

---

## 5.3 Skin Effect *(pp.5–12)*

### Definition *(p.6)*

At high frequencies, current **migrates toward the periphery** (skin) of the conductor. The skin depth is defined as the depth at which the electric field amplitude decays to $e^{-1}$ of its surface value:

$$\delta = \sqrt{\frac{2\rho}{\omega\mu}} = \sqrt{\frac{\rho}{\pi F \mu}} \quad \text{meters}$$

*(chap5.pdf, p.6)*

where $\rho$ = resistivity (Ω·m), $\mu$ = permeability (H/m), $F$ = frequency (Hz).

**~63% of the total current flows within one skin depth.**

As $F$ increases, $\delta$ decreases → effective cross-section shrinks → **resistance increases as $\sqrt{F}$**.

### Frequency-Dependent Inductance *(p.7)*

At DC, current fills the conductor uniformly (including the interior) → **internal inductance** adds to external inductance.  
At high frequencies, current is confined to the skin → only **external inductance** remains. The total inductance decreases asymptotically to the external inductance value.

For most high-speed digital applications, the frequency is high enough that internal inductance can be **ignored**.

### Conductor Loss in a Microstrip *(pp.8–12)*

Current concentrates on the **bottom edge** of the signal line (pulled toward the ground plane by the E-field). Also curves up the sides due to the thickness $t$.

**Approximate total AC resistance (microstrip):**

$$R_{\text{ac, microstrip}} = \sqrt{\rho\pi\mu F}\left(\frac{1}{W} + \frac{1}{6H}\right) \quad \Omega/\text{m}$$

*(chap5.pdf, p.12)*

(Signal line contribution $\approx \sqrt{\rho\pi\mu F}/W$; ground plane contribution $\approx \sqrt{\rho\pi\mu F}/(6H)$, assuming 79.5% of return current flows within $\pm 3H$.)

**More exact formula (conformal mapping):**

$$R_{\text{signal}} = \left[\text{loss ratio}\right]\left(\frac{1}{\pi} + \frac{1}{\pi^2}\ln\frac{4\pi W}{t}\right)\frac{\sqrt{\pi\mu F\rho}}{W}$$

where $\text{Loss ratio} = \begin{cases} 0.94 + 0.132\frac{W}{H} - 0.0062\left(\frac{W}{H}\right)^2 & 0.5 < W/H < 10 \\ 1 & W/H \leq 0.5 \end{cases}$

*(chap5.pdf, p.12)*

**Stripline:** Current is distributed between top and bottom conductor surfaces. AC resistance ≈ parallel combination of top and bottom portions. *(p.13)*

### Surface Roughness *(pp.14–15)*

Real metal surfaces have a **tooth structure** — roughness increases effective resistance by 10–50% when mean roughness ≈ skin depth.

- Typical FR4 boards: average tooth size = **4–7 μm**
- Etched surfaces: smaller tooth size

**Surface resistance:**

$$R_{\text{ac}} = R_S \sqrt{F}$$

*(chap5.pdf, p.15)*

where $R_S = \sqrt{\rho\pi\mu}$ in units of Ω·√s/square (a material constant, independent of frequency and geometry). The full ac resistance per meter of line is:

$$R_{\text{ac signal}} = R_S \sqrt{F} \cdot \frac{L}{W} \quad \Omega/\text{m}$$

*(chap5.pdf, p.16)*

### Effect of AC Losses on Signal Waveforms *(pp.17–19)*

A periodic square wave at 50% duty cycle has Fourier components at the fundamental and odd harmonics only:

$$v(t) = \frac{4A}{\pi}\left[\sin(\omega_0 t) + \frac{1}{3}\sin(3\omega_0 t) + \frac{1}{5}\sin(5\omega_0 t) + \cdots\right]$$

*(chap5.pdf, p.17)*

In a matched system, the **attenuation factor $\alpha$** can be calculated from the voltage divider at a single frequency using VNA measurements.

**Visual effect on the waveform** *(p.19)*:
- High-frequency components are attenuated more → waveform **rounding** (slower edges)
- Low-frequency amplitude also decreases → overall **amplitude reduction**

---

## 5.4 Frequency-Dependent Dielectric Losses *(pp.20–27)*

### Physical Mechanism *(p.20)*

A time-varying electric field causes **polar molecules** in the dielectric to align with the field. The damping/relaxation mechanisms dissipate energy and vary with frequency.

### Complex Dielectric Constant *(p.20)*

$$\varepsilon = \varepsilon' - j\varepsilon''$$

The imaginary part $\varepsilon''$ represents losses.

### Loss Tangent *(p.21)*

$$\tan|\delta_d| = \frac{1}{2\rho\pi F\varepsilon} = \frac{\varepsilon''}{\varepsilon'}$$

*(chap5.pdf, p.21)*

This is equivalent to a conductivity $1/\rho = 2\pi F\varepsilon''$.

### Shunt Conductance in TX Line Model *(p.21)*

The dielectric loss appears as a shunt conductance per unit length in the RLCG model:

$$G = \frac{\varepsilon''}{\varepsilon'}(2\pi F C_{11}) \quad \text{Siemens/meter}$$

*(chap5.pdf, p.21)*

where $C_{11}$ is the self-capacitance per unit length.

### FR4 Loss Tangent *(p.22)*

FR4 has $\tan\delta \approx 0.02$ (given in chap4; varies moderately with frequency). The glass cloth reinforcement contributes negligible dielectric variation with frequency in typical ranges.

### Calculating Losses — Example *(pp.23–27)*

Given: $W = 5$ mil, $H_1 = H_2 = 10$ mil, $t = 0.63$ mil, $\varepsilon_r = 4.0$, stripline.

Steps:
1. Calculate $R_S$ (surface resistivity)
2. Find the frequency where skin depth = conductor thickness ($\delta = t$); below this, use DC resistance; above this, $R \propto \sqrt{F}$
3. At 400 MHz: compute $R_{\text{ac}}$ from the skin-effect formula
4. Compute $G$ at 400 MHz from $G = \tan\delta \cdot 2\pi F C_{11}$ (using PD to find $C_{11}$)

*(chap5.pdf, pp.23–27)*

---

## 5.5 Variations in the Dielectric Constant *(pp.28–30)*

### Why $\varepsilon_r$ Varies *(p.28)*

Properties that depend on $\varepsilon_r$: propagation velocity, characteristic impedance, and crosstalk.

$\varepsilon_r$ is NOT constant — it varies with:
- Frequency
- Temperature
- Moisture absorption
- Spatial variation in composite material proportions

### FR4 Composition *(p.29)*

FR4 = epoxy matrix + woven glass cloth. The dielectric properties vary substantially sample-to-sample.

**First-order approximation:**

$$\varepsilon_{r,\text{FR4}} \approx V_{\text{gls}}\varepsilon_{r,\text{gls}} + (1 - V_{\text{gls}})\varepsilon_{r,\text{epoxy}}$$

*(chap5.pdf, p.29)*

where $V_{\text{gls}}$ = volume fraction of glass.

The glass cloth experiences **no dielectric constant variation** with frequency; the epoxy (resin) variation dominates.

---

## 5.6 Serpentine Traces *(pp.31–33)*

### Why Used *(p.31)*

Length equalization of traces is required by timing specifications, but real-estate constraints force the use of serpentine (meandering) traces.

### Problem *(p.31–32)*

The parallel sections of the serpentine **couple** to each other. Due to this coupling, **part of the signal arrives earlier** than it would on a straight trace → **ledges** appear on the waveform.

- Duration of the ledges ∝ physical length of the coupled sections ($L_P$)
- Magnitude of ledges depends on spacing between parallel sections

### Rules of Thumb *(p.33)*

1. Minimum spacing between parallel sections $S \geq 3H$ to $4H$ ($H$ = height above ground).
2. Minimize $L_P$ (length of serpentine sections).
3. Embedded microstrips and striplines are better (less effect).
4. **Do not serpentine clock traces.**

---

## 5.7 Intersymbol Interference (ISI) *(pp.34–38)*

### Definition *(p.34)*

ISI occurs when reflections, crosstalk, or other noise has **not fully settled** when the next bit is launched. The unsettled residue corrupts the new symbol.

Most severe when: **period < 2 × TD** (the signal period is smaller than the two-way propagation delay).

### Simulation *(pp.35–36)*

Proper ISI analysis requires long pseudo-random bit patterns (PRBS). An efficient shortcut:

Simulate at:
- Fastest period: `010101010101010`
- 2× period: `001100110011001`
- 3× period: `000111000111000`

This captures most ISI effects in much less time than PRBS.

### Rules of Thumb *(p.38)*

- Minimize reflections (avoid impedance discontinuities, stub lengths, and large parasitics from packages/sockets/connectors).
- Keep interconnects as short as possible.
- Avoid tightly coupled serpentine traces.
- Avoid line lengths that cause signal integrity issues (ringback, ledges, overshoot) coincident with bus transitions.
- Minimize crosstalk.

---

## 5.8 Effects of 90$^\circ$ Bends *(pp.39–41)*

### Capacitive Effect *(p.39)*

A 90$^\circ$ bend introduces **excess capacitance** due to the corner area:

$$C_{90^\circ\text{ bend}} \approx C_{11} \cdot w$$

*(chap5.pdf, p.39)*

where $C_{11}$ = self-capacitance per unit length, $w$ = trace width. The excess area is approximately 0.054 square (full square basis).

### Mitigation *(p.40)*

1. **Rounding** the corner — eliminates the effect (but problematic for some layout tools)
2. **Chamfering** — 45$^\circ$ diagonal cut at the corner
3. **Using 45$^\circ$ bends** instead of 90$^\circ$ bends altogether

### High-Frequency Current Paths *(p.41)*

At high frequencies, some current component **hugs the inner corner** of a 90$^\circ$ bend → signals arrive slightly early at the destination.

---

## 5.9 Effects of Topology *(pp.42–44)*

### Balanced T-Topology *(p.42)*

When the T-junction has equal stub lengths and equal loads → signal integrity is preserved with matched or mismatched loads.

### Unbalanced T-Topology *(pp.43–44)*

With unequal stub lengths or unequal loading, the signal at each leg sees a different discontinuity → significant **waveform distortion** and signal integrity degradation.

**Key lessons:**
1. **Symmetry** of topology is critical (both stub length and loading of each leg).
2. **Minimize discontinuities** at the topology junction.
