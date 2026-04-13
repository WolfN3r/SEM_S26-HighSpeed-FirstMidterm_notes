# Equation Corrections and Verification Log

> Verification pass: each PDF page re-examined against extracted knowledge files.

---

## Chapter 2

### Correction C2-1 — Surface resistance formula scope *(p.16 of chap5, not chap2)*
No corrections to Chapter 2 equations. All verified against slide images:
- Z0 general ✓ (slide 9)
- Z0 microstrip (87/sqrt(ε_r+1.41)) × ln(5.98H/(0.8W+T)) ✓ (slides 9, 39)
- Z0 stripline (60/sqrt(ε_r)) × ln(4H/(0.67π(T+0.8W))) ✓ (slide 10)
- v = c/sqrt(ε_r), PD = sqrt(ε_r)/c, TD = x√ε_r/c ✓ (slide 11)
- TD = √LC, PD = √(L_unit × C_unit) ✓ (slide 11)
- Effective ε_e formula ✓ (slides 12, 40)
- SPICE segments ≥ 10(x/v/T_r) ✓ (slide 14)
- V_i = V_s × Z_0/(Z_0+Z_s) ✓ (slide 17)
- ρ = (Z_t−Z_0)/(Z_t+Z_0) ✓ (slide 18)
- Example 2.1 numbers: TD=898 ps, L_total=44.9 nH, C_total=17.9 pF, 4 segments ✓ (slides 15–16)
- Additional example: ε_e=2.84, v=1.78×10^8 m/s, TD=713 ps ✓ (slide 40)

---

## Chapter 3

### Correction C3-1 — NEXT formula sign convention *(p.13)*
The FEXT formula from slide 13 is:

$$B_{\text{FEXT}} = -\frac{V_{\text{input}} \cdot X\sqrt{LC}}{2T_r}\left(\frac{L_m}{L} - \frac{C_m}{C}\right)$$

The negative sign means FEXT is negative if $L_m/L > C_m/C$ (inductive coupling dominates). This is correctly recorded.

### Verification of all Chapter 3 equations:
- V_noise,Lm = L_m × dI/dt ✓ (slide 4)
- I_noise,Cm = C_m × dV/dt ✓ (slide 5)
- I_near = I(L_m) + I_near(C_m) ✓ (slide 11)
- I_far = I_far(C_m) − I(L_m) ✓ (slide 11)
- NEXT amplitude A = V(input)/4 × (L_m/L + C_m/C) ✓ (slide 13)
- FEXT amplitude B = −V(input)X√LC/(2T_r) × (L_m/L − C_m/C) ✓ (slide 13)
- T_r > 2TD: multiply NEXT by 2TD/T_r; FEXT unchanged ✓ (slide 14)
- L_odd = L_11 − L_12 ✓ (slide 25)
- Z_odd = √((L_11−L_12)/(C_11+C_m)) ✓ (slide 27)
- TD_odd = √((L_11−L_12)(C_11+C_m)) ✓ (slide 27)
- L_even = L_11 + L_12 ✓ (slide 28)
- C_even = C_11 − C_m ✓ (slide 29)
- Z_even = √((L_11+L_12)/(C_11−C_m)) ✓ (slide 29)
- TD_even = √((L_11+L_12)(C_11−C_m)) ✓ (slide 29)

---

## Chapter 4

No equations extracted from text were verifiable via slide images for the estimation formulas on p.14 (complex multi-line expressions). These are flagged:

### <!-- VERIFY --> C4-1 — NEXT/FEXT estimation equations *(p.14)*
The estimation equations for NEXT and FEXT peaks with front-end C_f were only partially captured by text extraction. The slide shows multi-line expressions involving Z_even, Z_odd, Z_0, and the decoupling capacitor time constant τ = R_t × 2C_f. Recommend re-reading chap4.pdf p.14 directly for exact forms before using these in calculations.

### Verification of all other Chapter 4 equations:
- TD_even = ℓ√((L_s+L_m)C_s) ✓ (slide 10)
- TD_odd = ℓ√((L_s−L_m)(C_s+2C_m)) ✓ (slide 10)
- TDc_odd = ℓ√((L_s−L_m)(C_s+2C_m+2C_f/ℓ)) ✓ (slide 23)
- Results tables (FEXT, NEXT, eye diagram) ✓ (slides 26–27, 35–36, 43)

---

## Chapter 5

### Correction C5-1 — Surface Resistance R_S definition *(p.16)*

**Original (incorrect) in chap5.md:**
> $R_S = \sqrt{\rho\pi\mu}/W \cdot L$

**Corrected (per slide 16):**
> $R_S = \sqrt{\rho\pi\mu}$ in units of Ω·√s/square

The full expression is:
$$R_{\text{ac signal}} = \frac{L\sqrt{\rho\pi\mu F}}{W} = R_S\sqrt{F} \cdot \frac{L}{W} \quad \Omega/\text{m}$$

The surface resistance per square ($L = W$) is simply $R_S\sqrt{F}$.
This has been corrected in `knowledge/chap5.md`.

### Verification of all other Chapter 5 equations:
- δ = √(2ρ/ωμ) = √(ρ/πFμ) ✓ (slide 6)
- R_ac microstrip ≈ √(ρπμF)(1/W + 1/(6H)) Ω/m ✓ (slide 12)
- Loss ratio formula ✓ (slide 12)
- R_ground formula with W/H term ✓ (slide 12)
- tan|δ_d| = 1/(2ρπFε) = ε''/ε' ✓ (slide 21)
- G = (ε''/ε') × 2πF × C_11 ✓ (slide 21)
- C_90°bend ≈ C_11 × w ✓ (slide 39)
- Fourier square wave expansion ✓ (slide 17)

---

## Summary

| Chapter | Corrections | VERIFY flags |
|---|---|---|
| Chap 1 | 0 | 0 |
| Chap 2 | 0 | 0 |
| Chap 3 | 0 (sign convention clarified) | 0 |
| Chap 4 | 0 | 1 (complex estimation eqs p.14) |
| Chap 5 | 1 (R_S definition corrected) | 0 |
