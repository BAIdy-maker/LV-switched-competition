# Parameter Documentation

This document describes all parameters used in the simulations.

## Growth Parameters
- `r_i1`, `r_i2`: Intrinsic growth rates of species i in environments 1 and 2
- `r_j1`, `r_j2`: Intrinsic growth rates of species j in environments 1 and 2

## Competition Coefficients
- `s_ii1`, `s_ii2`: Intraspecific competition for species i
- `s_jj1`, `s_jj2`: Intraspecific competition for species j
- `s_ij1`, `s_ij2`: Effect of species i on species j
- `s_ji1`, `s_ji2`: Effect of species j on species i

## Resource Parameters
- `Z1`: Resource level in environment 1
- `Z2`: Resource level in environment 2 (Z2 = θ × Z1)
- `θ`: Ratio Z2/Z1 (0 < θ < 1)

## Switching Parameters
- `T`: Switching period (T << 1 for averaging theory)
- `δ`: Proportion of time in environment 1 (0 < δ < 1)

## Other Parameters
- `K`: Carrying capacity (normalized to 100)
- `p_i`, `p_j`: Resource accessibility factors (set to 1)

## Values Used in Simulations

### Figure 1 (Balanced Effects)