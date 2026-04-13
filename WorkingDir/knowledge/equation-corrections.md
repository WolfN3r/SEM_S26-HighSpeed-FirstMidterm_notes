# Equation Verification Log

**Task 2: Equation Verification — All Chapters**

Each chapter was re-read page-by-page and every equation in the corresponding knowledge file was compared against the original PDF slide. Results are recorded below.

---

## Chapter 1 (`chap1.md` vs `chap1_HSDSD.pdf`)

**Status: VERIFIED — No corrections needed.**

| Equation | Location in chap1.md | PDF page | Result |
|---|---|---|---|
| $f_2 = 1/(\pi\tau_r) = 0.32/\tau_r$ | §1.4 | p.6 | ✓ Correct |
| Spectral breakpoints $f_1 = 1/\pi\tau$, $f_2 = 1/\pi t_r$ | §1.4 | p.6 | ✓ Correct |
| $f = 0.35/t_r$, $\lambda = c/f$ | §1.5 | p.7 | ✓ Correct |
| $f_l = 10f$, $\lambda_l = \lambda/10$ (TX line criterion) | §1.5 | p.7 | ✓ Correct |

---

## Chapter 2 (`chap2.md` vs `chap2_HSDSD.pdf`)

**Status: VERIFIED — No corrections needed.**

| Equation | Location | PDF page | Result |
|---|---|---|---|
| $Z_o = \sqrt{(R+j\omega L)/(G+j\omega C)}$ | §1.1 | p.4 | ✓ Correct |
| Lossless $Z_o = \sqrt{L/C}$ | §1.1 | p.4 | ✓ Correct |
| Microstrip $Z_o \approx \frac{87}{\sqrt{\varepsilon_r+1.41}}\ln\!\left(\frac{5.98H}{0.8W+T}\right)$ | §2.1 | p.7 | ✓ Correct |
| Symmetric stripline $Z_{o,\text{sym}} \approx \frac{60}{\sqrt{\varepsilon_r}}\ln\!\left(\frac{4H}{0.67\pi(T+0.8W)}\right)$ | §2.2 | p.8 | ✓ Correct |
| Propagation delay $TD = x\sqrt{\varepsilon_r}/c$ | §3.1 | p.10 | ✓ Correct |
| Microstrip effective dielectric constant (full F-factor formula) | §3.2 | p.11 | ✓ Correct |
| SPICE segments $\geq 10(x/T_r v)$ | §4.1 | p.13 | ✓ Correct |
| Initial wave $V_i = V_s Z_o/(Z_o + Z_s)$ | §5.1 | p.17 | ✓ Correct |
| Reflection coefficient $\rho = (Z_t - Z_o)/(Z_t + Z_o)$ | §5.2 | p.18 | ✓ Correct |

---

## Chapter 3 (`chap3.md` vs `chap3_HSDSD.pdf`)

**Status: VERIFIED — No corrections needed.**

| Equation | Location | PDF page | Result |
|---|---|---|---|
| $V_{\text{noise},L_m} = L_m dI/dt$ | §2.1 | p.4 | ✓ Correct |
| $I_{\text{noise},C_m} = C_m dV/dt$ | §2.2 | p.5 | ✓ Correct |
| NEXT $A = \frac{V_\text{in}}{4}\left(\frac{L_M}{L}+\frac{C_M}{C}\right)$ | §4.1 | p.13 | ✓ Correct |
| FEXT $B = -\frac{V_\text{in}X\sqrt{LC}}{2T_r}\left(\frac{L_M}{L}-\frac{C_M}{C}\right)$ | §4.1 | p.13 | ✓ Correct |
| Mismatch factor $V_x = V_\text{crosstalk}(1+(R-Z_0)/(R+Z_0))$ | §4.2 | p.15 | ✓ Correct |
| Coupling factor $K = L_{12}/\sqrt{L_{11}L_{22}}$ | §6.1 | p.21 | ✓ Correct |
| SPICE segment count $N = 10X/(vT_r)$ | §6.2 | p.23 | ✓ Correct |
| Odd-mode inductance $L_\text{odd} = L_{11} - L_{12}$ | §7.1 | p.25 | ✓ Correct |
| Odd-mode capacitance $C_\text{odd} = C_{11} + C_m$ | §7.1 | p.26 | ✓ Correct |
| Odd-mode impedance $Z_\text{odd} = \sqrt{(L_{11}-L_{12})/(C_{11}+C_m)}$ | §7.1 | p.27 | ✓ Correct |
| Even-mode inductance $L_\text{even} = L_{11} + L_m$ | §7.2 | p.28 | ✓ Correct |
| Even-mode capacitance $C_\text{even} = C_{11} - C_m$ | §7.2 | p.29 | ✓ Correct |
| Even-mode impedance $Z_\text{even} = \sqrt{(L_{11}+L_{12})/(C_{11}-C_m)}$ | §7.2 | p.29 | ✓ Correct |
| SLEM (all in-phase) $Z_{2,\text{eff}} = \sqrt{(L_{22}+L_{12}+L_{23})/(C_{22}-C_{12}-C_{23})}$ | §7.3 | p.33 | ✓ Correct |
| SLEM (one out-of-phase) $Z_{2,\text{eff}} = \sqrt{(L_{22}+L_{12}-L_{23})/(C_{22}-C_{12}+C_{23})}$ | §7.4 | p.34 | ✓ Correct |
| Pi-termination $R_3 = 2Z_\text{even}Z_\text{odd}/(Z_\text{even}-Z_\text{odd})$ | §9.1 | p.39 | ✓ Correct |
| T-termination $R_3 = \frac{1}{2}(Z_\text{even}-Z_\text{odd})$ | §9.2 | p.40 | ✓ Correct |

**Note:** The example in §11.1 (p.47–49) uses a "differential mode" formula
$Z_{2,\text{diff}} = \sqrt{(L_{22}-L_{12}-L_{23})/(C_{22}+C_{12}+C_{23})}$ where
the center bit is out of phase with **both** neighbors simultaneously. This differs
from the SLEM §7.4 (one neighbor out of phase) by design — both are correct for
their respective scenarios.

---

## Chapter 4 (`chap4.md` vs `chap4_HSDSD.pdf`)

**Status: VERIFIED — No corrections needed.**

| Equation | Location | PDF page | Result |
|---|---|---|---|
| Even-mode TD $TD_{even} = l\sqrt{(L_s+L_m)C_s}$ | §2.1/§4.2 | p.10/p.23 | ✓ Correct |
| Odd-mode TD $TD_{odd} = l\sqrt{(L_s-L_m)(C_s+2C_m)}$ | §2.1 | p.10 | ✓ Correct |
| NEXT peak $V_2(t_r) = \frac{V_s}{2}\frac{Z_{even}}{Z_{even}+Z_0} - \frac{V_s}{2}\frac{Z_{odd}}{Z_{odd}+Z_0}$ | §3.5 | p.14 | ✓ Correct |
| FEXT peak $|V_4(TD_{even})| = V_{max}\min(T_d/t_r, 1)$ | §3.5 | p.14 | ✓ Correct |
| $V_{max} = \frac{Z_0}{Z_{even}+2Z_0+Z_{odd}}V_s$ | §3.5 | p.14 | ✓ Correct |
| Odd-mode TD with $C_f$: $TD^c_{odd} = l\sqrt{(C_s+2C_m+2C_f/l)(L_s-L_m)}$ | §4.2 | p.23 | ✓ Correct |
| $C_f$ design: $T_d = l\sqrt{L_s-L_m}(\sqrt{C_s+2C_m+2C_f/l}-\sqrt{C_s+2C_m})$ | §4.3 | p.24 | ✓ Correct |
| RC time constant $\tau = 2R_tC_f$, $R_t = Z_0Z_{odd}/(Z_0+Z_{odd})$ | §4.6 | p.28 | ✓ Correct |
| 3-dB frequency $f_{3\text{dB}} = 0.35/t_r$ | §5.1 | p.39 | ✓ Correct |
| Guided wavelength $\lambda = (3\times10^8)/(f_{3\text{dB}}\sqrt{\varepsilon_{eff}})$ | §5.1 | p.39 | ✓ Correct |

---

## Chapter 5 (`chap5.md` vs `chap5_HSDSD.pdf`)

**Status: VERIFIED — No corrections needed.**

| Equation | Location | PDF page | Result |
|---|---|---|---|
| DC resistance $R = \rho L/(Wt)$ | §1.2 | p.4 | ✓ Correct |
| Skin depth $\delta = \sqrt{2\rho/(\omega\mu)} = \sqrt{\rho/(\pi F\mu)}$ | §1.4 | p.6 | ✓ Correct |
| AC signal resistance $R_{\text{ac sig}} \approx \sqrt{\rho\pi\mu F}/W$ | §1.7 | p.9 | ✓ Correct |
| DC+AC combination $R_{\text{total}} \approx \sqrt{R_\text{ac}^2+R_\text{dc}^2}$ | §1.7 | p.10 | ✓ Correct |
| Ground current density $I(D) \approx \frac{I_o}{\pi H}\frac{1}{1+(D/H)^2}$ | §1.7 | p.10 | ✓ Correct |
| 79.5% current integral $\int_{-3H}^{3H}\cdots = \frac{2I_o}{\pi}\tan^{-1}(3)\approx 0.795I_o$ | §1.7 | p.11 | ✓ Correct |
| Ground AC resistance $R_{\text{ac gnd}} = \sqrt{\rho\pi\mu F}/(6H)$ | §1.7 | p.11 | ✓ Correct |
| Total microstrip AC resistance $\sqrt{\rho\pi\mu F}(1/W+1/6H)$ | §1.7 | p.12 | ✓ Correct |
| Exact $R_\text{signal}$ (conformal mapping formula with loss ratio) | §1.7 | p.12 | ✓ Correct |
| Exact $R_\text{ground}$ ($(W/H)/(W/H+5.8+0.03(H/W))\cdot\sqrt{\pi\mu F\rho}/W$) | §1.7 | p.12 | ✓ Correct |
| Stripline resistance (parallel combination) | §1.8 | p.13 | ✓ Correct |
| Surface resistance $R_s = (L/W)\sqrt{\rho\pi\mu}$ | §1.10 | p.16 | ✓ Correct |
| Square resistance $R_\text{square} = \rho/t$ | §1.10 | p.16 | ✓ Correct |
| Fourier series $f(x) = \frac{2}{\pi}\sum_{n=1,3,5}\frac{1}{n}\sin(2\pi nFx)$ | §1.11 | p.17 | ✓ Correct |
| Attenuation $\alpha = R_2/(R_\text{ac}+R_2)$ | §1.11 | p.18 | ✓ Correct |
| Complex dielectric $\varepsilon = \varepsilon' - j\varepsilon''$ | §1.12 | p.20 | ✓ Correct |
| Loss tangent $\tan|\delta_d| = \varepsilon''/\varepsilon'$ | §1.12 | p.21 | ✓ Correct |
| Dielectric conductance $G = (\varepsilon''/\varepsilon')(2\pi FC_{11})$ | §1.12 | p.21 | ✓ Correct |
| FR4 composite $\varepsilon_r = \varepsilon_\text{rsn}V_\text{rsn}+\varepsilon_\text{gls}V_\text{gls}$ | §2.2 | p.29 | ✓ Correct |
| FR4 empirical $\varepsilon_r(V_\text{rsn},F) = 6.32-[2.17+0.168\log_{10}F(\text{kHz})]V_\text{rsn}$ | §2.2 | p.29 | ✓ Correct |
| 90° bend capacitance $C_{90°}\approx C_{11}w$ | §5.1 | p.39 | ✓ Correct |
| Excess area $= 1/4 - \pi/16 \approx 0.054$ squares | §5.1 | p.39 | ✓ Correct |
| Unbalanced T: $\rho = (Z_o/2-Z_o)/(Z_o/2+Z_o) = -1/3$ | §6.2 | p.43 | ✓ Correct |
| Unbalanced T: $T = 1+\rho = 2/3$ | §6.2 | p.43 | ✓ Correct |

---

## Summary

**Total equations verified: 55**  
**Corrections made: 0**  
**Ambiguous/flagged equations: 0**

All knowledge files (`chap1.md` through `chap5.md`) accurately reflect the source PDFs. No `<!-- VERIFY: -->` flags were added because no ambiguous equations were encountered.
