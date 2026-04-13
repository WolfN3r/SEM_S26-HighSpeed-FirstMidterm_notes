# Chapter 1 — The Importance of Interconnect Design

> Source: `chap1_HSDSD.pdf`  
> Instructor: Chun-Long Wang, National Taiwan University of Science and Technology

---

## 1.1 Trace Length vs. Wavelength *(p.3)*

In 100 ps, light in free space travels ~30 mm (1.2 in.). PCB traces can be longer than or comparable to this distance, meaning the **speed of light is a limiting factor**.

When a trace length is **larger than or comparable to the wavelength** of the highest significant frequency component, the trace must be treated as a **transmission line** — not a simple wire. Wave effects (delay, reflections, distortion) cannot be ignored.

---

## 1.2 Interconnects and Waveform Integrity *(p.4)*

- **Interconnect**: any conductive path carrying a digital signal (chip packages, connectors, sockets, PCB traces).
- A group of interconnects = **bus**.
- For valid logic levels, the designer must guarantee:
  - High voltages **do not fall below** $V_{ih}$
  - Low voltages **stay below** $V_{il}$
- The region between $V_{il}$ and $V_{ih}$ is the **threshold region** — logic level is indeterminate there.

---

## 1.3 Rise and Fall Time Limitations *(p.5)*

- Faster rise/fall times maximize operating speed by minimising timing uncertainty in the threshold region.
- BUT faster edges produce **higher-frequency spectral content**, which forces the capacitance, inductance, and frequency-dependent resistance of the conductor to be considered.
- Result: the wire introduces **delay and transient impedance** → distortions and glitches on the waveform.

---

## 1.4 Spectrum of Trapezoidal (Clock) Waveforms *(p.6)*

A periodic trapezoidal pulse train has:
- $\tau_r$ = rise time (10–90%)
- $\tau_f$ = fall time (10–90%)
- $\tau$ = pulse width (measured at midpoints)

The **highest frequency of interest** is determined by the rise time:

$$f_{\max} = \frac{1}{\pi \tau_r} = \frac{0.32}{\tau_r}$$

*(chap1.pdf, p.6)*

This is the bandwidth that must be considered when deciding whether to treat a trace as a transmission line.

---

## 1.5 When Must a Conductor Be Treated as a Transmission Line? *(p.7)*

**Rule of thumb:** Any circuit length that is at least **1/10 of the electrical length corresponding to the edge rate** must be treated as a transmission line.

Derivation:
- For a signal with rise time $t_r$: $f = 0.35/t_r$, $\lambda = c/f$
- A transmission line of time delay $T_D$ has physical length $\ell = c/f_\ell$
- Criterion: $T_D \geq t_r/10$ (i.e., $\ell \geq \lambda/10$)

*(chap1.pdf, p.7)*

---

## 1.6 Moore's Law and Bus Speed Bottleneck *(pp.8–9)*

- **Gordon Moore (Intel co-founder)**: computer performance doubles every 18 months.
- As core frequency increases, faster **bus data rates** are required to feed the processor.
- **Bus speed** has become the bottleneck — not the core clock.
- At high frequencies, new variables and effects arise (reflections, crosstalk, losses) that challenge digital system design — collectively called **High-Speed Digital Signal Design (HSDSD)**.
