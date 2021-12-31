# Hamming-one
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Comparison of algorithms solving Hamming-one problem, implemented on CPU and GPU using CUDA.

## Problem statement

Given *n* binary sequences (0 &lt; n &le; 10<sup>5</sup>), each sequence of lenght *l* (0 &lt; l &le; 1000), find all pairs of sequences such that the Hamming distance between them equals 1.

[Hamming distance](https://en.wikipedia.org/wiki/Hamming_distance) between two binary sequences of equal lenght equals the number of positions on which those sequences differ, e.g.:
distance between 1101 and 1100 equals 1, and between 0011 and 1100 equals 4.
