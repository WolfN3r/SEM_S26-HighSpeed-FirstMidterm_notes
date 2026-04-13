# Practice Questions — HSDSD Midterm

**Format:** Closed-book. Questions organised by chapter.  
**Answers** are in a separate section at the bottom.

---

## Chapter 1 — The Importance of Interconnect Design

**Q1.1 (Conceptual)**  
Explain why a PCB trace must be treated as a transmission line when its physical length is comparable to the wavelength of the highest frequency of interest. What happens if you ignore this?

**Q1.2 (Calculation)**  
A digital signal has a rise time of $t_r = 300\,\text{ps}$.  
(a) What is the highest frequency of interest $f_2$?  
(b) A trace has a propagation delay of $TD = 25\,\text{ps}$. Must it be modelled as a transmission line?

**Q1.3 (True/False)**  
State whether each is true or false, and explain briefly.

(a) Faster rise times always improve system performance because they reduce timing uncertainty.  
(b) A trapezoidal clock signal's spectrum rolls off at −40 dB/decade above $f_2 = 1/(\pi t_r)$.  
(c) If a trace delay is exactly $t_r/10$, it must be modelled as a transmission line.

**Q1.4 (Multiple Choice)**  
The spectral envelope of a trapezoidal clock waveform has a slope of −20 dB/decade in which frequency range?

A. 0 to $f_1 = 1/(\pi\tau)$  
B. $f_1$ to $f_2 = 1/(\pi t_r)$  
C. Above $f_2 = 1/(\pi t_r)$  
D. All frequencies above DC

---

## Chapter 2 — Transmission Line Fundamentals

**Q2.1 (Conceptual)**  
Explain the difference between microstrip and symmetric stripline in terms of:  
(a) the number of ground planes  
(b) the effective dielectric constant  
(c) the propagation velocity

**Q2.2 (Calculation)**  
A microstrip trace has: $W = 6\,\text{mils}$, $H = 4\,\text{mils}$, $T = 1\,\text{mil}$, $\varepsilon_r = 4.5$.  
Calculate the approximate characteristic impedance $Z_o$.

**Q2.3 (Calculation)**  
A symmetric stripline has: $\varepsilon_r = 4.0$, $H = 20\,\text{mils}$ (total), $W = 5\,\text{mils}$, $T = 0.63\,\text{mil}$.  
Calculate the approximate characteristic impedance $Z_o$.

**Q2.4 (Calculation)**  
A signal with $V_s = 0\to3.3\,\text{V}$ is launched from a driver with $Z_s = 25\,\Omega$ onto a $50\,\Omega$ line terminated with an open circuit ($Z_L = \infty$).  
(a) What is the initial voltage $V_i$ launched onto the line?  
(b) What is the reflection coefficient at the load, $\rho_L$?  
(c) What voltage does the load receiver first see?

**Q2.5 (Calculation)**  
How many SPICE segments are needed to model a 6-inch stripline trace with $\varepsilon_r = 4.0$ and rise time $t_r = 150\,\text{ps}$? (Use $c = 12\,\text{in./ns}$ in free space.)

**Q2.6 (True/False)**  
(a) A matched termination ($Z_L = Z_o$) produces no reflection.  
(b) The lossless characteristic impedance depends on the frequency.  
(c) Propagation velocity in a stripline equals $c/\sqrt{\varepsilon_r}$.

---

## Chapter 3 — Crosstalk

**Q3.1 (Conceptual)**  
Describe the physical mechanism behind near-end crosstalk (NEXT) and far-end crosstalk (FEXT). Why is FEXT zero in an ideal symmetric stripline but not in microstrip?

**Q3.2 (Calculation)**  
Two adjacent traces have: $L_M = 0.40\,\text{nH/in.}$, $C_M = 0.06\,\text{pF/in.}$, $L_{11} = 8\,\text{nH/in.}$, $C_{11} = 3.2\,\text{pF/in.}$, trace length $X = 4\,\text{in.}$, $Z_s = Z_o = 50\,\Omega$, $V_s = 1.5\,\text{V}$ (so $V_\text{input} = V_s/2 = 0.75\,\text{V}$), $t_r = 200\,\text{ps}$.

(a) Calculate NEXT magnitude $A$.  
(b) Calculate FEXT magnitude $|B|$.  
(Hint: $\sqrt{L_{11}C_{11}} = \sqrt{8 \times 3.2}\,\text{ns/in.}$; compute numerically.)

**Q3.3 (Calculation)**  
Using the parasitics from Q3.2:

(a) Calculate $Z_\text{odd}$.  
(b) Calculate $Z_\text{even}$.

**Q3.4 (Multiple Choice)**  
Which of the following reduces FEXT most effectively in a microstrip bus?

A. Increasing trace width $W$  
B. Routing on stripline instead of microstrip  
C. Increasing the source impedance $Z_s$  
D. Decreasing the rise time $t_r$

**Q3.5 (Calculation)**  
Design a Pi-termination network for a differential pair with $Z_\text{odd} = 45\,\Omega$ and $Z_\text{even} = 55\,\Omega$.  
Give the values of $R_1$, $R_2$, and $R_3$.

**Q3.6 (Calculation)**  
For the same pair in Q3.5, design a T-termination network.

**Q3.7 (Conceptual)**  
For a three-line bus with parameters $L_{11}$, $L_{12} = L_{23}$, $C_{11}$, $C_{12} = C_{23}$:  
(a) Write the SLEM formula for $Z_\text{common}$ (all bits in phase).  
(b) Write the SLEM formula for $Z_\text{differential}$ (center bit out of phase with both neighbours).  
(c) Which mode produces the higher effective impedance? Why?

**Q3.8 (True/False)**  
(a) NEXT has a flat-top waveform whose duration equals the round-trip propagation time $2 \times TD$.  
(b) Mutual inductance $L_M$ and mutual capacitance $C_M$ always have opposing effects at the far end.  
(c) The coupling factor $K = L_{12}/\sqrt{L_{11}L_{22}}$ ranges from 0 to $\infty$.

---

## Chapter 4 — Coupled Microstrip and Decoupling Capacitors

**Q4.1 (Conceptual)**  
Explain why placing a lumped capacitor $C_f$ at the near end of a coupled microstrip pair reduces FEXT but increases NEXT.

**Q4.2 (Calculation)**  
A coupled microstrip has $Z_{even} = 58\,\Omega$, $Z_{odd} = 42\,\Omega$, $Z_0 = 50\,\Omega$, $V_s = 2\,\text{V}$, $T_d = 25\,\text{ps}$, $t_r = 40\,\text{ps}$.

(a) Calculate $V_{max}$.  
(b) Calculate the FEXT peak $|V_4|$.  
(c) Calculate the NEXT peak $V_2(t_r)$.

**Q4.3 (Calculation)**  
For the same line in Q4.2:  
(a) Calculate $R_t = Z_0 Z_{odd}/(Z_0 + Z_{odd})$.  
(b) If $C_f = 0.5\,\text{pF}$, calculate the RC time constant $\tau = 2R_t C_f$.

**Q4.4 (Multiple Choice)**  
Which configuration achieves the best FEXT reduction with minimal eye diagram degradation?

A. Single lumped $C_f$ at the near end  
B. Distributed $C_f$ with spacing $\Delta l = \lambda/2$  
C. Distributed $C_f$ with spacing $\Delta l = \lambda/10$  
D. No capacitor (conventional coupled microstrip)

**Q4.5 (Conceptual)**  
Given $t_r = 50\,\text{ps}$ and $\varepsilon_{eff} = 3.5$, compute the guided wavelength at the 3-dB bandwidth frequency. What should the capacitor spacing be for optimal distributed $C_f$ performance?

---

## Chapter 5 — Nonideal Interconnect Issues

**Q5.1 (Calculation)**  
A copper microstrip has width $W = 5\,\text{mils} = 127\,\mu\text{m}$, height above ground $H = 4\,\text{mils} = 102\,\mu\text{m}$.  
($\rho_\text{Cu} = 1.72\times10^{-8}\,\Omega\cdot\text{m}$, $\mu_0 = 4\pi\times10^{-7}\,\text{H/m}$)

(a) Calculate the approximate AC signal resistance $R_{\text{ac signal}}$ at $F = 1\,\text{GHz}$ (in $\Omega/\text{m}$).  
(b) Calculate the approximate AC ground return resistance $R_{\text{ac ground}}$ at $F = 1\,\text{GHz}$ (in $\Omega/\text{m}$).

**Q5.2 (Calculation)**  
Using the transition frequency formula, find the frequency $F_t$ at which skin depth equals conductor thickness $t = 35\,\mu\text{m}$ (1 oz copper). ($\rho = 1.72\times10^{-8}\,\Omega\cdot\text{m}$)

**Q5.3 (Calculation)**  
At $F = 400\,\text{MHz}$, a transmission line has $R_{ac} = 20\,\Omega/\text{m}$, $R_{dc} = 8.5\,\Omega/\text{m}$. What is the combined SPICE resistance $R_\text{total}$?

**Q5.4 (Conceptual)**  
Explain why the dielectric loss tangent $\tan\delta_d$ produces a shunt conductance $G$ in the transmission line model, and write the formula relating $G$ to $\tan\delta_d$, $F$, and $C_{11}$.

**Q5.5 (True/False)**  
(a) For FR4 up to 15 GHz, dielectric loss dominates over conductor loss.  
(b) Skin depth increases with increasing frequency.  
(c) In a microstrip, 79.5% of the ground return current flows within a lateral distance of $\pm 3H$ from the trace centre.  
(d) Surface roughness always decreases the AC resistance compared to the ideal formula.  
(e) FEXT is zero in a symmetric stripline because $L_M/L = C_M/C$.

**Q5.6 (Multiple Choice)**  
A serpentine trace has parallel sections of length $L_p$ spaced $S = 2H$ apart. Which rule of thumb is violated?

A. $L_p$ should be minimised  
B. The spacing should be at least 3H to 4H  
C. Serpentines should not be used on inner layers  
D. Clock traces may be serpentined if $L_p < 1\,\text{in.}$

**Q5.7 (Conceptual)**  
Explain the two lessons learned from the unbalanced T topology analysis. What goes wrong when leg lengths are unequal?

**Q5.8 (Calculation)**  
A coupled microstrip line with $Z_{even} = 55\,\Omega$, $Z_{odd} = 45\,\Omega$, $Z_0 = 50\,\Omega$, $V_s = 2\,\text{V}$, $T_d = 0$ (after distributed $C_f$ compensation), $t_r = 40\,\text{ps}$. What is the expected FEXT peak?

---

# Answers

---

## Chapter 1 Answers

**A1.1**  
When a trace is long compared to the signal wavelength, the signal experiences different voltage levels at different points along the trace simultaneously. Ignoring TX-line effects causes: incorrect timing (reflections add to/subtract from the signal), false triggering (voltage bouncing through the threshold), and signal integrity failures. *(chap1.pdf, p.3–5)*

**A1.2**  
(a) $f_2 = 1/(\pi \times 300\,\text{ps}) = 1/(942\,\text{ps}) \approx 1.06\,\text{GHz}$ *(chap1.pdf, p.6)*  
(b) Criterion: $TD \geq t_r/10 = 30\,\text{ps}$. Since $TD = 25\,\text{ps} < 30\,\text{ps}$, **TX-line model not required.** *(chap1.pdf, p.7)*

**A1.3**  
(a) **False.** Faster rise times increase high-frequency content, which worsens capacitive/inductive effects, reflections, and crosstalk. *(chap1.pdf, p.5)*  
(b) **True.** Above $f_2 = 1/(\pi t_r)$ the envelope falls at −40 dB/decade. *(chap1.pdf, p.6)*  
(c) **True.** The criterion is $\geq t_r/10$, so exactly $t_r/10$ means it must be modelled as a TX line. *(chap1.pdf, p.7)*

**A1.4**  
**B.** The −20 dB/decade region spans $f_1$ to $f_2$. *(chap1.pdf, p.6)*

---

## Chapter 2 Answers

**A2.1**  
(a) Microstrip: one ground plane (below). Stripline: two ground planes (above and below).  
(b) Microstrip: $\varepsilon_{eff} < \varepsilon_r$ (field partly in air). Stripline: $\varepsilon_{eff} = \varepsilon_r$ (fully embedded in dielectric).  
(c) Microstrip is faster than stripline for the same $\varepsilon_r$. Stripline: $v = c/\sqrt{\varepsilon_r}$. *(chap2.pdf, p.7–11)*

**A2.2**  
$$Z_o \approx \frac{87}{\sqrt{4.5+1.41}}\ln\!\left(\frac{5.98\times4}{0.8\times6+1}\right) = \frac{87}{\sqrt{5.91}}\ln\!\left(\frac{23.92}{5.8}\right) = \frac{87}{2.431}\ln(4.124) = 35.79\times1.417 \approx 50.7\,\Omega$$
*(chap2.pdf, p.7)*

**A2.3**  
$$Z_o \approx \frac{60}{\sqrt{4.0}}\ln\!\left(\frac{4\times20}{0.67\pi(0.63+0.8\times5)}\right) = 30\ln\!\left(\frac{80}{0.67\pi\times4.63}\right) = 30\ln\!\left(\frac{80}{9.74}\right) = 30\ln(8.21) = 30\times2.106 \approx 63.2\,\Omega$$
*(chap2.pdf, p.8)*

**A2.4**  
(a) $V_i = 3.3 \times 50/(25+50) = 3.3 \times 0.667 = 2.2\,\text{V}$ *(chap2.pdf, p.17)*  
(b) $\rho_L = (\infty - 50)/(\infty + 50) = +1$ *(chap2.pdf, p.18)*  
(c) $V_\text{load} = 2.2 + 1\times2.2 = 4.4\,\text{V}$ (overshoot above supply — causes concern!)

**A2.5**  
Propagation delay per inch: $\sqrt{4}/c = 2/(12\,\text{in./ns}) = 167\,\text{ps/in.}$  
Total delay: $6 \times 167 = 1002\,\text{ps}$.  
$$N \geq \frac{10 \times 1002}{150} = 66.8 \rightarrow \mathbf{67\text{ segments}}$$
*(chap2.pdf, p.13)*

**A2.6**  
(a) **True.** $\rho = 0$ when $Z_L = Z_o$. *(chap2.pdf, p.18)*  
(b) **False.** For a lossless line, $Z_o = \sqrt{L/C}$ is frequency-independent. *(chap2.pdf, p.4)*  
(c) **True.** Stripline is fully embedded, so $v = c/\sqrt{\varepsilon_r}$. *(chap2.pdf, p.10)*

---

## Chapter 3 Answers

**A3.1**  
NEXT: at the near end, inductive coupling ($+L_m dI/dt$) and capacitive coupling ($+C_m dV/dt$) add in phase → flat-top pulse of duration $2TD$. FEXT: inductive ($-L_m dI/dt$) and capacitive ($+C_m dV/dt$) partially cancel. In a symmetric stripline $L_M/L = C_M/C$ exactly → FEXT = 0. In microstrip $L_M/L \neq C_M/C$ due to the inhomogeneous medium → FEXT $\neq 0$. *(chap3.pdf, p.4–13)*

**A3.2**  
$L_M/L_{11} = 0.40/8 = 0.05$; $C_M/C_{11} = 0.06/3.2 = 0.01875$

(a) NEXT: $A = \frac{0.75}{4}(0.05 + 0.01875) = 0.1875 \times 0.06875 \approx \mathbf{0.0129\,\text{V}}$  
*(chap3.pdf, p.13)*

(b) $\sqrt{L_{11}C_{11}} = \sqrt{8\times3.2}\,\text{nH/in.}\cdot\text{pF/in.} = \sqrt{25.6} = 5.06\,\text{(ps/in.)}$  
$\sqrt{LC}$ for the line is $5.06\,\text{ps/in.}$; $X = 4\,\text{in.}$; $T_r = 200\,\text{ps}$.

$$|B| = \frac{0.75 \times 4 \times 5.06}{2 \times 200}|0.05 - 0.01875| = \frac{15.18}{400} \times 0.03125 = 0.03795 \times 0.03125 \approx \mathbf{0.00119\,\text{V}}$$
*(chap3.pdf, p.13)*

**A3.3**  
(a) $Z_\text{odd} = \sqrt{(8-0.40)/(3.2+0.06)} = \sqrt{7.6/3.26} = \sqrt{2.331} \approx \mathbf{48.3\,\Omega}$ *(chap3.pdf, p.27)*  
(b) $Z_\text{even} = \sqrt{(8+0.40)/(3.2-0.06)} = \sqrt{8.4/3.14} = \sqrt{2.675} \approx \mathbf{51.7\,\Omega}$ *(chap3.pdf, p.29)*

**A3.4**  
**B.** Routing on stripline eliminates FEXT because $L_M/L = C_M/C$ in a homogeneous medium. *(chap3.pdf, p.38)*

**A3.5**  
Pi-termination: $R_1 = R_2 = Z_\text{even} = 55\,\Omega$  
$$R_3 = \frac{2\times55\times45}{55-45} = \frac{4950}{10} = \mathbf{495\,\Omega}$$
*(chap3.pdf, p.39)*

**A3.6**  
T-termination: $R_1 = R_2 = Z_\text{odd} = 45\,\Omega$  
$$R_3 = \frac{1}{2}(55-45) = \mathbf{5\,\Omega}$$
*(chap3.pdf, p.40)*

**A3.7**  
(a) $Z_\text{common} = \sqrt{(L_{11}+2L_{12})/(C_{11}-2C_{12})}$ *(chap3.pdf, p.33)*  
(b) $Z_\text{diff} = \sqrt{(L_{11}-2L_{12})/(C_{11}+2C_{12})}$ *(chap3.pdf, p.49)*  
(c) Common mode has the higher impedance: mutual inductance adds ($L+2L_M$) and mutual capacitance subtracts ($C-2C_M$). *(chap3.pdf, p.33)*

**A3.8**  
(a) **True.** NEXT duration = $2TD$ (round trip). *(chap3.pdf, p.13)*  
(b) **True.** Inductive contribution: $-L_m dI/dt$ (opposes); capacitive: $+C_m dV/dt$ (adds). They partially cancel at far end. *(chap3.pdf, p.11)*  
(c) **False.** $K$ ranges from 0 to 1. *(chap3.pdf, p.21)*

---

## Chapter 4 Answers

**A4.1**  
A lumped $C_f$ slows the odd-mode wave (adding capacitance to the odd-mode circuit) until $TD_\text{odd} = TD_\text{even}$, so the two modes arrive simultaneously and cancel the FEXT. However, the same capacitor charges rapidly at the near end, injecting a large current spike back into the quiet line → increased NEXT. The lumped nature also creates an impedance discontinuity that degrades $|S_{11}|$ and the eye diagram. *(chap4.pdf, p.22–29)*

**A4.2**  
(a) $V_{max} = \frac{50}{58+100+42}\times2 = \frac{50}{200}\times2 = 0.5\,\text{V}$ *(chap4.pdf, p.14)*  
(b) $|V_4| = 0.5\times\min(25/40, 1) = 0.5\times0.625 = \mathbf{0.3125\,\text{V}}$ *(chap4.pdf, p.14)*  
(c) $V_2(t_r) = \frac{2}{2}\frac{58}{58+50} - \frac{2}{2}\frac{42}{42+50} = \frac{58}{108} - \frac{42}{92} = 0.537 - 0.457 = \mathbf{0.080\,\text{V}}$ *(chap4.pdf, p.14)*

**A4.3**  
(a) $R_t = 50\times42/(50+42) = 2100/92 \approx 22.8\,\Omega$ *(chap4.pdf, p.28)*  
(b) $\tau = 2\times22.8\times0.5\times10^{-12} = 22.8\,\text{ps}$ *(chap4.pdf, p.28)*

**A4.4**  
**C.** Distributed $C_f$ at $\lambda/10$ spacing achieves FEXT $\approx 0$ and restores eye diagram performance. *(chap4.pdf, p.40)*

**A4.5**  
$$f_{3\text{dB}} = 0.35/50\,\text{ps} = 7\,\text{GHz}$$
$$\lambda = \frac{3\times10^8}{7\times10^9\times\sqrt{3.5}} = \frac{3\times10^8}{1.31\times10^{10}} \approx 22.9\,\text{mm}$$
Capacitor spacing: $\Delta l = \lambda/10 \approx \mathbf{2.3\,\text{mm}}$. *(chap4.pdf, p.39)*

---

## Chapter 5 Answers

**A5.1**  
(a) $R_{\text{ac signal}} = \sqrt{\rho\pi\mu F}/W = \sqrt{1.72\times10^{-8}\times\pi\times4\pi\times10^{-7}\times10^9}/(127\times10^{-6})$  
$= \sqrt{1.72\times10^{-8}\times1.256\times10^{-6}\times10^9}/(127\times10^{-6})$  
$= \sqrt{0.02160}/127\times10^{-6} = 0.1470/127\times10^{-6} \approx \mathbf{1158\,\Omega/\text{m}}$  
*(chap5.pdf, p.9)*

(b) $R_{\text{ac ground}} = \sqrt{\rho\pi\mu F}/(6H) = 0.1470/(6\times102\times10^{-6}) = 0.1470/612\times10^{-6} \approx \mathbf{240\,\Omega/\text{m}}$  
*(chap5.pdf, p.11)*

**A5.2**  
$$F_t = \frac{\rho}{\pi\mu t^2} = \frac{1.72\times10^{-8}}{\pi\times1.256\times10^{-6}\times(35\times10^{-6})^2} = \frac{1.72\times10^{-8}}{4.833\times10^{-15}} \approx \mathbf{3.56\,\text{MHz}}$$
*(chap5.pdf, p.26)*

**A5.3**  
$$R_\text{total} = \sqrt{20^2 + 8.5^2} = \sqrt{400+72.25} = \sqrt{472.25} \approx \mathbf{21.7\,\Omega/\text{m}}$$
*(chap5.pdf, p.10)*

**A5.4**  
A lossy dielectric has $\varepsilon = \varepsilon' - j\varepsilon''$. The imaginary part $\varepsilon''$ acts like a conductivity $\sigma = \omega\varepsilon''$, which in the transmission line model appears as a shunt conductance per unit length:

$$G = \frac{\varepsilon''}{\varepsilon'}(2\pi F C_{11}) = \tan\delta_d \times 2\pi F C_{11}$$
*(chap5.pdf, p.21)*

**A5.5**  
(a) **True.** For FR4, dielectric loss dominates above a few hundred MHz up to 15 GHz. *(chap5.pdf, p.5)*  
(b) **False.** $\delta = \sqrt{\rho/(\pi F\mu)}$ — skin depth **decreases** with increasing frequency. *(chap5.pdf, p.6)*  
(c) **True.** From the Lorentzian integral: $\int_{-3H}^{3H}\approx 0.795\,I_o$. *(chap5.pdf, p.11)*  
(d) **False.** Surface roughness **increases** AC resistance by 10–50% above the ideal formula. *(chap5.pdf, p.14)*  
(e) **True.** In a symmetric stripline (homogeneous dielectric) $L_M/L = C_M/C$, so FEXT = 0. *(chap3.pdf, p.13)*

**A5.6**  
**B.** The spacing $S = 2H$ violates the rule that $S \geq 3H$ to $4H$. *(chap5.pdf, p.33)*

**A5.7**  
Lesson 1: Topology symmetry is critical. Equal leg lengths and equal loading at each branch ensure that reflections arrive at the same time and cancel properly, preventing oscillation. Lesson 2: Minimise discontinuities at the junction. When $L_1 \neq L_2$, the wave reaches the shorter-leg receiver first, reflects, and bounces between the junction and receivers, causing ringing that may not settle within a bus cycle. *(chap5.pdf, p.44)*

**A5.8**  
With $T_d = 0$:

$$|V_4| = V_{max}\times\min(0/40, 1) = V_{max}\times 0 = \mathbf{0\,\text{V}}$$
*(chap4.pdf, p.14)*

FEXT is theoretically zero when even- and odd-mode delays are equalised. (In practice a small residual exists due to the lumped capacitor causing reflections, but the dominant FEXT term vanishes.)
