# Deep-Learning-Accelerated-Surrogate-Optimization-for-Well-Control-in-Unconventionals
This repository contains code and supporting materials for a deep learning–based surrogate optimization framework for well control in stress-sensitive unconventional reservoirs. See paper: https://arxiv.org/abs/2604.00352

## 📌 Overview
This repository presents a deep learning–accelerated surrogate optimization framework for production control in stress-sensitive unconventional reservoirs.

Production optimization in these systems is governed by a nonlinear trade-off: higher drawdown improves short-term production but accelerates permeability degradation, reducing long-term recovery. Solving this problem with fully coupled flow–geomechanics simulators is computationally expensive.

To address this, the repository implements a workflow where:

A neural network surrogate learns the mapping from time-varying BHP controls to cumulative production
A problem-informed sampling strategy aligns training data with optimization trajectories
The surrogate is embedded into a constrained gradient-based optimizer for fast control optimization

The approach achieves near full-physics accuracy (within a few percent) while delivering orders-of-magnitude speedup (~1000×).

The figure below illustrates the overall workflow:
<img width="1553" height="543" alt="image" src="https://github.com/user-attachments/assets/8598d5ca-df40-4e5d-8eb1-8ce8f0e64931" />
