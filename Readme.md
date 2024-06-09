# Matched Filter Detector Simulation

This repository contains MATLAB code for simulating and analyzing the performance of a Matched Filter Detector under different signal-to-noise ratio (SNR) conditions. The code utilizes Monte Carlo simulations to generate noise samples and calculate test statistics, allowing for the evaluation of the detector's probability of detection under varying levels of noise.

## Code Description

- `MFD.m`: MATLAB script for simulating the matched filter detector using Monte Carlo simulations. This script defines the parameters for the simulation, including the number of Monte Carlo iterations, the range of the probability of false alarm, and the SNR values. It then performs the simulations, calculates the theoretical and simulated probabilities of detection, and generates plots to visualize the results.

- `matched_updated.m`: Similar to the first script, this MATLAB script simulates the matched filter detector using Monte Carlo simulations. It defines different parameters for the simulation, including a different range for the probability of false alarm and SNR values. The script performs simulations, calculates probabilities of detection, and generates plots for comparison.

## Usage

1. Clone the repository to your local machine:

```bash
git clone https://github.com/SaiKiranNandipati/-Spectrum-sensing-using-Matched-filter--using-MATLAB.git
