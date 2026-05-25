# DTU 10060 Physics Tools

[![CI](https://github.com/SFSteffensen/DTU-10060-Physics-Tools/actions/workflows/ci.yml/badge.svg)](https://github.com/SFSteffensen/DTU-10060-Physics-Tools/actions/workflows/ci.yml)

A Python utility library for DTU course 10060 (Polytechnical Foundation Physics).
Covers the full OpenStax University Physics Vol. 1 syllabus used in the course.

## Prerequisites

- Python 3.14+
- [uv](https://docs.astral.sh/uv/) for environment and dependency management

## Setup

```bash
uv sync
```

## Contents

| Section | Topics |
|---------|--------|
| Constants | CODATA physical constants, DTU local gravity |
| Statistics | Sample stats, error propagation, weighted mean |
| Curve fitting | Linear, power-law, exponential, general least-squares |
| Kinematics 1D/2D | Constant-acceleration solver, projectile motion |
| Circular motion | Centripetal acceleration, conical pendulum, banked curves |
| Newton's laws | Friction, inclined planes, stacked blocks |
| ODE integration | General equation of motion, air drag |
| Work and energy | Kinetic/potential energy, work integrals |
| Conservation of energy | Speed-height relations, pendulum, spring launch |
| Momentum | Elastic/inelastic collisions, center of mass, explosions |
| Rotation | Moments of inertia, torque, rolling, angular momentum |
| Plot helpers | 1D motion, projectile trajectory, fit summary table |

## Usage

```python
import physics_tools as pt

# Projectile motion
result = pt.projectile(v0=20, theta_deg=45)
print(result["range"])

# Error propagation
import sympy as sp
x, dx = sp.symbols("x dx")
f = x**2
value, uncertainty = pt.error_propagation(f, {x: 3.0}, {x: 0.1})
```

All functions accept SI units unless otherwise noted.
