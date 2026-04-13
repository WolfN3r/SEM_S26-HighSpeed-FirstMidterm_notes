---
title: HSDSD Practice Questions
subtitle: Chapters 1–5
---

# Practice Questions — HSDSD Midterm

---

## Chapter 1 — Interconnect Design Basics

### Conceptual

**Q1.1** *(chap1.pdf, p.3)*  
Why must a trace be considered as a transmission line rather than a simple wire when its length is comparable to the wavelength of the signal?

**Q1.2** *(chap1.pdf, p.4)*  
What is the "threshold region" of a logic signal, and why is minimizing time spent in this region important for digital system design?

**Q1.3** *(chap1.pdf, p.5)*  
Explain the trade-off between rise/fall time and signal integrity. Why does a faster edge rate lead to more severe transmission line effects?

### Calculation

**Q1.4** *(chap1.pdf, p.6)*  
A digital signal has a rise time of $\tau_r = 500$ ps. What is the highest frequency of interest?

**Q1.5** *(chap1.pdf, p.7)*  
A PCB trace has a propagation delay of $T_D = 200$ ps. A driver has $t_r = 1$ ns. Should this trace be treated as a transmission line?

### True/False

**Q1.6** *(chap1.pdf, p.8)*  
True or False: According to Moore's Law, bus speed always scales proportionally with core CPU frequency.

**Q1.7** *(chap1.pdf, p.7)*  
True or False: A trace of length $\lambda/20$ at the highest frequency of interest must be treated as a transmission line.

---

## Chapter 2 — Ideal Transmission Line Fundamentals

### Conceptual

**Q2.1** *(chap2.pdf, p.3)*  
What are the two main planar transmission line structures used in PCB design? How do they differ in terms of layer position and effective dielectric constant?

**Q2.2** *(chap2.pdf, p.6)*  
List the four elements of the RLCG per-unit-length model of a transmission line and explain what physical phenomenon each one represents.

**Q2.3** *(chap2.pdf, pp.31–36)*  
Compare series source termination and parallel load termination: describe the mechanism of each, and give one advantage and one disadvantage of each.

**Q2.4** *(chap2.pdf, p.27)*  
What happens to reflections when the rise time satisfies $\tau_r > 2\text{TD}$? How does this differ from the case $\tau_r < 2\text{TD}$?

### Calculation

**Q2.5** *(chap2.pdf, p.9)*  
A microstrip line has $W = 4$ mil, $H = 4$ mil, $T = 1$ mil, $\varepsilon_r = 4.5$. Estimate $Z_0$ using the microstrip approximation formula. (Hint: check validity condition $0.1 < W/H < 2$.)

**Q2.6** *(chap2.pdf, p.11)*  
A stripline is embedded in FR4 ($\varepsilon_r = 4.0$) and is 3 in. long. Find the propagation velocity and time delay. ($c = 3\times10^8$ m/s, 1 in. = 0.0254 m)

**Q2.7** *(chap2.pdf, pp.13–14)*  
A transmission line has $Z_0 = 75\,\Omega$, length = 4 in., $\varepsilon_r = 4.0$. A signal with rise time $T_r = 2$ ns drives the line. How many SPICE segments are needed?

**Q2.8** *(chap2.pdf, p.17)*  
A source of $V_s = 3.3$ V with $Z_s = 22\,\Omega$ drives a $50\,\Omega$ transmission line. What is the initial incident voltage $V_i$ launched onto the line?

**Q2.9** *(chap2.pdf, p.18)*  
Calculate the reflection coefficient for: (a) a matched load, (b) an open load, (c) a load $Z_L = 100\,\Omega$ on a $50\,\Omega$ line.

**Q2.10** *(chap2.pdf, pp.15–16 — Example 2.1)*  
Given a stripline with $Z_0 = 50\,\Omega$, length $x = 5$ in., $T_r = 2.5$ ns, $\varepsilon_r = 4.5$:
- (a) Calculate TD.
- (b) Find $L_{\text{total}}$ and $C_{\text{total}}$.
- (c) How many segments are needed?
- (d) Find $C_{\text{seg}}$ and $L_{\text{seg}}$.

### Multiple Choice

**Q2.11** *(chap2.pdf, p.18)*  
An open-circuit load on a transmission line produces a reflection coefficient of:  
(A) −1 &emsp; (B) 0 &emsp; (C) +1 &emsp; (D) +0.5

**Q2.12** *(chap2.pdf, p.12)*  
On the same FR4 board, which transmission line structure has a FASTER propagation speed?  
(A) Stripline &emsp; (B) Microstrip &emsp; (C) Both the same &emsp; (D) Depends only on width

---

## Chapter 3 — Crosstalk

### Conceptual

**Q3.1** *(chap3.pdf, p.3)*  
What are the two main ways crosstalk degrades a digital bus? Name the two physical coupling mechanisms.

**Q3.2** *(chap3.pdf, pp.11–12)*  
Compare near-end crosstalk (NEXT) and far-end crosstalk (FEXT): where is each measured, and what determines the duration of each?

**Q3.3** *(chap3.pdf, pp.24–32)*  
Explain why odd-mode propagation results in underdriven conditions, while even-mode propagation results in overdriven conditions.

**Q3.4** *(chap3.pdf, p.32)*  
Why does crosstalk NOT induce velocity variations in a stripline, while it DOES in a microstrip?

**Q3.5** *(chap3.pdf, pp.41–42)*  
Give three design rules for minimizing crosstalk between parallel traces.

### Calculation

**Q3.6** *(chap3.pdf, p.13)*  
Two matched-terminated ($Z_0 = 50\,\Omega$) coupled lines have:
- $L_m = 0.5$ nH/in., $C_m = 0.08$ pF/in.
- $L_{11} = 8$ nH/in., $C_{11} = 3.2$ pF/in.
- $V_{\text{in}} = 1$ V, $T_r = 150$ ps, line length $X = 3$ in.

First verify whether $T_r < 2\text{TD}$. Then calculate peak NEXT and FEXT amplitudes.

**Q3.7** *(chap3.pdf, pp.27, 29)*  
For a coupled pair of lines with $L_{11} = 7.13$ nH/in., $L_{12} = 0.54$ nH/in., $C_{11} = 2.85$ pF/in., $C_m = 0.079$ pF/in.:
- (a) Calculate $Z_{\text{odd}}$ and $Z_{\text{even}}$.
- (b) Is the odd mode underdriven or overdriven for a $Z_s = 50\,\Omega$ source?

**Q3.8** *(chap3.pdf, p.21)*  
Two coupled lines have $L_{11} = L_{22} = 6$ nH/in., $L_{12} = 0.6$ nH/in. Calculate the inductive coupling factor $K$.

### True/False

**Q3.9** *(chap3.pdf, p.13)*  
True or False: In the long-line case ($T_r < 2$TD), near-end crosstalk amplitude is independent of line length.

**Q3.10** *(chap3.pdf, p.32)*  
True or False: Even-mode propagation always results in a higher characteristic impedance than the single-line impedance $Z_0$.

**Q3.11** *(chap3.pdf, p.14)*  
True or False: In the short-line case ($T_r > 2$TD), far-end crosstalk equations need to be adjusted by a factor of $2\text{TD}/T_r$.

---

## Chapter 4 — Coupled Microstrip Line

### Conceptual

**Q4.1** *(chap4.pdf, p.10)*  
Explain why far-end crosstalk (FEXT) exists in a microstrip but not in a stripline. Use the concept of even-mode and odd-mode time delays.

**Q4.2** *(chap4.pdf, pp.22–24)*  
What is the purpose of the front-end decoupling capacitor $C_f$ in coupled microstrip design? What property does it modify?

**Q4.3** *(chap4.pdf, pp.34–36)*  
Why does adding a front-end decoupling capacitor $C_f$ degrade eye diagram performance at high bit rates?

**Q4.4** *(chap4.pdf, pp.39–42)*  
How do distributed decoupling capacitors improve on the lumped front-end $C_f$ design? What is the key advantage in terms of S-parameters?

### True/False with Explanation

**Q4.5** *(chap4.pdf, p.10)*  
True or False: FEXT is always zero in a stripline because the dielectric fully surrounds both conductors, making even- and odd-mode velocities equal.

**Q4.6** *(chap4.pdf, p.43)*  
True or False: Adding a front-end decoupling capacitor reduces both FEXT and NEXT simultaneously.

---

## Chapter 5 — Non-ideal Interconnect Issues

### Conceptual

**Q5.1** *(chap5.pdf, p.6)*  
Define skin depth $\delta$. What physical phenomenon causes the skin effect, and what happens to conductor resistance as frequency increases?

**Q5.2** *(chap5.pdf, p.7)*  
Explain why the internal inductance of a conductor decreases at high frequencies. What is the asymptotic high-frequency value?

**Q5.3** *(chap5.pdf, pp.17–19)*  
Describe the two visual effects of AC conductor losses on a time-domain digital waveform.

**Q5.4** *(chap5.pdf, pp.31–33)*  
Why do serpentine traces cause ledges on the rising edge of a signal? What design rules mitigate this?

**Q5.5** *(chap5.pdf, pp.34–36)*  
What is intersymbol interference (ISI) and under what condition is it most severe?

### Calculation

**Q5.6** *(chap5.pdf, p.6)*  
Copper has $\rho = 1.72\times10^{-8}$ Ω·m, $\mu = \mu_0 = 4\pi\times10^{-7}$ H/m. Calculate the skin depth at 1 GHz.

**Q5.7** *(chap5.pdf, p.15)*  
What is the surface resistance $R_S$ of copper? (Use $\rho = 1.72\times10^{-8}$ Ω·m.)

**Q5.8** *(chap5.pdf, p.12)*  
A microstrip has $W = 5$ mil = $127\,\mu$m, $H = 3.2$ mil = $81.3\,\mu$m. Estimate $R_{\text{ac}}$ at 1 GHz using the approximate formula. ($\rho_{\text{Cu}} = 1.72\times10^{-8}$ Ω·m, $\mu = \mu_0$)

**Q5.9** *(chap5.pdf, p.21)*  
A microstrip has $C_{11} = 3.2$ pF/in. and the FR4 substrate has $\tan\delta = 0.02$. Calculate the shunt conductance $G$ per unit length at 1 GHz.

**Q5.10** *(chap5.pdf, p.39)*  
A microstrip trace with $C_{11} = 3.5$ pF/in. and $w = 5$ mil makes a 90° bend. Estimate the excess capacitance.

### True/False

**Q5.11** *(chap5.pdf, p.6)*  
True or False: Skin depth increases with frequency.

**Q5.12** *(chap5.pdf, p.33)*  
True or False: Clock traces are generally acceptable to serpentine because the effect is the same on all edges.

**Q5.13** *(chap5.pdf, p.40)*  
True or False: Chamfering a 90° bend at 45° eliminates excess capacitance.

---

# Answers

---

## Chapter 1

**A1.4:** $f_{\max} = 0.32/500\text{ ps} = 0.64\text{ GHz}$

**A1.5:** $t_r/10 = 100\text{ ps}$. Since $T_D = 200\text{ ps} > 100\text{ ps}$, YES — treat as a transmission line.

**A1.6:** **False.** Bus speed tends to lag behind core frequency (bus is the bottleneck). *(chap1.pdf, p.9)*

**A1.7:** **False.** Only conductors $\geq \lambda/10$ need to be treated as TX lines; $\lambda/20$ is safely below the criterion. *(chap1.pdf, p.7)*

---

## Chapter 2

**A2.5:** $W/H = 4/4 = 1.0$ (valid). $Z_0 \approx \frac{87}{\sqrt{4.5+1.41}}\ln\frac{5.98\times4}{0.8\times4+1} = \frac{87}{\sqrt{5.91}}\ln\frac{23.92}{4.2} \approx 35.8\times\ln(5.695) \approx 35.8\times1.739 \approx 62.2\,\Omega$

**A2.6:** $v = 3\times10^8/\sqrt{4} = 1.5\times10^8$ m/s; $\text{TD} = 3\times0.0254/1.5\times10^8 = 508\text{ ps}$

**A2.7:** TD: $v=3\times10^8/\sqrt{4}=1.5\times10^8$; $\text{TD}=4\times0.0254/1.5\times10^8=677\text{ ps}$. Segments $\geq 10\times677\text{ ps}/2000\text{ ps}=3.4 \to$ 4 segments.

**A2.8:** $V_i = 3.3\times50/(50+22) = 3.3\times0.694 = 2.29\text{ V}$

**A2.9:** (a) $\rho=0$; (b) $\rho=+1$; (c) $\rho=(100-50)/(100+50)=+0.333$

**A2.10:**
- (a) $\text{TD} = 5\times0.0254\times\sqrt{4.5}/(3\times10^8) = 898\text{ ps}$
- (b) $L_{\text{total}} = 898\text{ ps}\times50\,\Omega = 44.9\text{ nH}$; $C_{\text{total}} = 898\text{ ps}/50\,\Omega = 17.9\text{ pF}$
- (c) Segments $\geq 10\times898/2500 = 3.6 \to$ 4
- (d) $C_{\text{seg}}=17.9/4=4.48\text{ pF}$; $L_{\text{seg}}=44.9/4=11.23\text{ nH}$

**A2.11:** **(C)** +1 (open circuit: $Z_t\to\infty$, $\rho\to+1$) *(chap2.pdf, p.18)*

**A2.12:** **(B) Microstrip.** Partial air → smaller effective $\varepsilon_r$ → faster propagation. *(chap2.pdf, p.12)*

---

## Chapter 3

**A3.6:**
- $\text{TD} = X\sqrt{L_{11}C_{11}} = 3\times\sqrt{8\times10^{-9}\times3.2\times10^{-12}} = 3\times\sqrt{25.6\times10^{-21}} = 3\times160\text{ ps} = 480\text{ ps}$
- $2\text{TD} = 960\text{ ps}$. $T_r = 150\text{ ps} < 960\text{ ps}$ → long-line case ✓
- $A_{\text{NEXT}} = (1.0/4)(0.5/8 + 0.08/3.2) = 0.25(0.0625+0.025) = 0.25\times0.0875 = 21.9\text{ mV}$
- $B_{\text{FEXT}} = -(1.0\times3\times160\text{ ps})/(2\times150\text{ ps})\times(0.0625-0.025) = -(480/300)\times0.0375 = -1.6\times0.0375 = -60\text{ mV}$

**A3.7:**
- $Z_{\text{odd}} = \sqrt{(7.13-0.54)/(2.85+0.079)} = \sqrt{6.59/2.929} = \sqrt{2.251} \approx 50.0/\sqrt{2.251}\cdots$

  More directly: $Z_{\text{odd}}=\sqrt{6.59\text{ nH/in.}/2.929\text{ pF/in.}}=\sqrt{2251\,\Omega^2}\approx 47.4\,\Omega$

- $Z_{\text{even}} = \sqrt{(7.13+0.54)/(2.85-0.079)} = \sqrt{7.67/2.771} = \sqrt{2.768\times10^3}\approx 52.6\,\Omega$

- For $Z_s = 50\,\Omega$: odd mode has $Z_{\text{odd}}=47.4\,\Omega < Z_s=50\,\Omega$ → **underdriven** *(chap3.pdf, p.27)*

**A3.8:** $K = L_{12}/\sqrt{L_{11}L_{22}} = 0.6/\sqrt{6\times6} = 0.6/6 = 0.10$ *(chap3.pdf, p.21)*

**A3.9:** **True.** *(chap3.pdf, p.14)*

**A3.10:** **True.** $Z_{\text{even}} > Z_0$ always. *(chap3.pdf, p.29)*

**A3.11:** **False.** It is NEXT (not FEXT) that is adjusted by $2\text{TD}/T_r$ in the short-line case. FEXT equations do not need adjustment. *(chap3.pdf, p.14)*

---

## Chapter 4

**A4.5:** **True.** In a stripline both conductors are fully surrounded by the same dielectric; the effective $\varepsilon_r$ is the same for both modes → equal velocities → $T_d = 0$ → FEXT cancels. *(chap4.pdf, p.10)*

**A4.6:** **False.** Adding front-end $C_f$ **reduces FEXT** but **increases NEXT**. *(chap4.pdf, pp.26–27)*

---

## Chapter 5

**A5.6:** $\delta = \sqrt{1.72\times10^{-8}/(\pi\times10^9\times4\pi\times10^{-7})} = \sqrt{1.72\times10^{-8}/(1.974\times10^{-3})} = \sqrt{8.71\times10^{-6}} \approx 2.95\,\mu\text{m}$

**A5.7:** $R_S = \sqrt{\rho\pi\mu} = \sqrt{1.72\times10^{-8}\times\pi\times4\pi\times10^{-7}} = \sqrt{1.72\times10^{-8}\times3.948\times10^{-6}} = \sqrt{6.79\times10^{-14}} \approx 8.24\times10^{-7}\,\Omega\cdot\sqrt{\text{s}}$

**A5.8:**
$$R_{\text{ac}} = \sqrt{1.72\times10^{-8}\times\pi\times4\pi\times10^{-7}\times10^9}\left(\frac{1}{127\times10^{-6}}+\frac{1}{6\times81.3\times10^{-6}}\right)$$
$= \sqrt{0.068}\times(7874+2049) = 0.261\times9923 \approx 2590\,\Omega/\text{m}$

**A5.9:** Convert $C_{11}$: $3.2\text{ pF/in.}\times39.37\text{ in./m} = 126\text{ pF/m}$.  
$G = 0.02\times2\pi\times10^9\times126\times10^{-12} = 0.02\times0.792 = 0.01584\text{ S/m} \approx 15.8\text{ mS/m}$

**A5.10:** $C_{90°} \approx C_{11}\times w = 3.5\text{ pF/in.}\times5\text{ mil} = 3.5\times(5/1000)\text{ pF} = 0.0175\text{ pF} \approx 17.5\text{ fF}$  
*(Note: units must be consistent — $w$ in inches if $C_{11}$ is in pF/in.)*

**A5.11:** **False.** Skin depth **decreases** with increasing frequency. *(chap5.pdf, p.6)*

**A5.12:** **False.** Clock traces must **never** be serpentined because early signal arrival corrupts clock timing. *(chap5.pdf, p.33)*

**A5.13:** **False.** Chamfering **reduces** excess capacitance but does not eliminate it completely. Rounding is more effective, and 45° bends avoid the issue altogether. *(chap5.pdf, p.40)*
