"""
physics_tools.py — DTU 10060 Physics (Polytechnical Foundation) exam library.

Mirrors the course chapters (OpenStax University Physics Vol. 1):

  §1  Constants & units
  §2  Statistics & error analysis
  §3  Curve fitting
  §4  Kinematics 1D                          (Kinematics 1D)
  §5  Kinematics 2D                          (Kinematics 2D)
  §6  Circular motion                        (Forces 1/2, Equation of motion)
  §7  Newton's laws & friction               (Forces 1/2 + 2/2)
  §8  Equations of motion (ODE integration)  (Equation of motion)
  §9  Work and energy                        (Work and energy)
  §10 Conservation of energy                 (Conservation of energy)
  §11 Momentum & collisions                  (Impacts and conservation of momentum)
  §12 Rotation                               (Rotation 1/2 + 2/2)
  §13 Plot helpers

Conventions:
  - All inputs in SI units unless explicitly noted.
  - Positive y is up.
  - Functions return plain floats or dicts; no opaque objects unless useful.
"""

from __future__ import annotations

from typing import Callable, Optional

import matplotlib.pyplot as plt
import numpy as np
import polars as pl
import scipy.constants as _sc
import scipy.optimize as opt
import scipy.stats as stats
import sympy as sp
from numpy import cos, exp, log, pi, sin, sqrt
from scipy.integrate import solve_ivp

# §1  CONSTANTS  (CODATA values via scipy.constants where available)
g = 9.82  # Surface gravity used at DTU 10060 [m/s²] (±0.01 m/s²)
G = _sc.G  # Newton gravitation [N·m²/kg²]  6.67430e-11
c = _sc.c  # Speed of light [m/s]  299 792 458 (exact)
eV = _sc.eV  # 1 electron-volt in joules [J]  1.602176634e-19 (exact)
NA = _sc.Avogadro  # Avogadro [1/mol]  6.02214076e23 (exact)
kB = _sc.Boltzmann  # Boltzmann [J/K]  1.380649e-23 (exact)
R_gas = _sc.R  # Gas constant [J/(mol·K)]  8.314462618...
M_earth = 5.9722e24  # Earth mass [kg]
R_earth = 6.3710e6  # Earth mean radius [m]


# §2  STATISTICS & ERROR ANALYSIS
def sample_stats(data) -> dict:
    """
    Sample statistics: mean, sample std (ddof=1), standard error of the mean.

    Returns:
        mean  – sample mean
        std   – sample standard deviation (ddof=1, Bessel-corrected)
        sem   – standard error of the mean = std / sqrt(n)
        n     – number of samples
        min   – smallest value
        max   – largest value
    """
    a = np.asarray(data, dtype=float)
    n = a.size
    if n < 2:
        raise ValueError("Need ≥ 2 samples for sample std")
    mean = a.mean()
    std = a.std(ddof=1)
    return dict(mean=mean, std=std, sem=std / sqrt(n), n=n, min=a.min(), max=a.max())


def standard_score(x: float, x_ref: float, sigma: float) -> float:
    """
    Standard score (z-score): how many standard deviations x is from x_ref.
        z = (x − x_ref) / σ

    Guide: |z| ≤ 1 very likely same, 1–2 likely, 2–3 grey zone, >3 unlikely same.
    """
    return (x - x_ref) / sigma


def is_consistent(new_value: float, data, n_sigma: float = 2.0) -> dict:
    """
    Does `new_value` plausibly come from the same population as `data`?

    Test: |new − μ̂| < n_sigma · s.   With n_sigma=2 this is roughly the 95 %
    interval of a Gaussian; n_sigma≈3 is "almost certainly the same".

    Returns (all keys from sample_stats, plus):
        new        – the new value being tested
        deviation  – signed difference: new_value − mean
        sigma_dist – how many sample std's away the new value is: |deviation| / std
        consistent – True if |deviation| < n_sigma · std
    """
    s = sample_stats(data)
    diff = new_value - s["mean"]
    return {
        **s,
        "new": new_value,
        "deviation": diff,
        "sigma_dist": abs(diff) / s["std"],
        "consistent": abs(diff) < n_sigma * s["std"],
    }


def compare_measurements(
    x: float, sigma_x: float, y: float, sigma_y: float, n_sigma: float = 2.0
) -> dict:
    """
    Compare two independent measurements x ± σ_x and y ± σ_y.

        z = (x − y) / sqrt(σ_x² + σ_y²)

    Guide: |z| < 2 → consistent, 2 ≤ |z| < 3 → grey zone, |z| ≥ 3 → reject.

    Returns:
        diff        – signed difference x − y
        sigma_diff  – combined uncertainty sqrt(σ_x² + σ_y²)
        z           – standard score of the difference
        consistent  – True if |z| < n_sigma
    """
    diff = x - y
    sigma_diff = sqrt(sigma_x**2 + sigma_y**2)
    z = diff / sigma_diff
    return dict(diff=diff, sigma_diff=sigma_diff, z=z, consistent=abs(z) < n_sigma)


def round_uncertainty(value: float, sigma: float) -> dict:
    """
    Round σ to 1 significant figure, or 2 if the leading digit is 1, 2, or 3
    (to keep the rounding error under ~10 %). Round `value` to match σ's last
    decimal place.

    Returns:
        value     – rounded best estimate
        sigma     – rounded uncertainty
        decimals  – number of decimal places used (≥ 0 means decimal places;
                    < 0 means rounded to that power of 10, e.g. −1 → tens)
        formatted – human string like "10.0 ± 0.5" or "(1.2 ± 0.3)·10³"
    """
    if sigma <= 0:
        raise ValueError("sigma must be positive")
    # Order of magnitude of σ
    exp10 = int(np.floor(np.log10(sigma)))
    leading = sigma / 10**exp10  # in [1, 10)
    # Keep 2 sig figs when leading digit is 1, 2, or 3
    sig_figs = 2 if leading < 3.95 else 1
    # decimals to round to (positive = after decimal point)
    decimals = -(exp10 - (sig_figs - 1))
    sigma_r = round(sigma, decimals)
    value_r = round(value, decimals)
    if decimals >= 0:
        fmt = f"{value_r:.{decimals}f} ± {sigma_r:.{decimals}f}"
    else:
        fmt = f"{value_r:.0f} ± {sigma_r:.0f}"
    return dict(value=value_r, sigma=sigma_r, decimals=decimals, formatted=fmt)


def weighted_mean(values, uncertainties) -> tuple[float, float]:
    """
    Inverse-variance-weighted mean and its standard error.

      μ = Σ(xi/σi²) / Σ(1/σi²)     σ_μ = 1 / sqrt(Σ 1/σi²)
    """
    x, u = np.asarray(values, float), np.asarray(uncertainties, float)
    w = 1.0 / u**2
    mu = (x * w).sum() / w.sum()
    return mu, 1.0 / sqrt(w.sum())


def error_propagation(
    expr: sp.Expr, values: dict, uncertainties: dict
) -> tuple[float, float]:
    """
    First-order Gaussian error propagation.

        σ_f² = Σ (∂f/∂x_i)² σ_{x_i}²

    Args:
        expr:           sympy expression for f.
        values:         {symbol: numeric value}
        uncertainties:  {symbol: σ}   (subset of `values`)

    Returns (f_value, σ_f).
    """
    f_val = float(expr.subs(values))
    var = 0.0
    for sym, sigma in uncertainties.items():
        d = float(sp.diff(expr, sym).subs(values))
        var += (d * sigma) ** 2
    return f_val, sqrt(var)


# §3  CURVE FITTING  (Experiments 2/2)
def linear_fit(x, y) -> dict:
    """
    Least-squares fit y = m x + b.

    Returns:
        slope            – m
        intercept        – b
        sigma_slope      – standard error on m
        sigma_intercept  – standard error on b
        r2               – coefficient of determination R²
    """
    r = stats.linregress(np.asarray(x, float), np.asarray(y, float))
    return dict(
        slope=r.slope,
        intercept=r.intercept,
        sigma_slope=r.stderr,
        sigma_intercept=r.intercept_stderr,
        r2=r.rvalue**2,
    )


def power_law_fit(x, y) -> dict:
    """
    Fit y = A · x^α via log-log linear regression.

    Returns:
        A            – amplitude coefficient
        alpha        – exponent (slope in log-log space)
        sigma_A      – standard error on A
        sigma_alpha  – standard error on alpha
        r2           – R² of the log-log linear fit
    """
    x, y = np.asarray(x, float), np.asarray(y, float)
    if (x <= 0).any() or (y <= 0).any():
        raise ValueError("Power law fit requires strictly positive x, y")
    res = stats.linregress(log(x), log(y))
    A = exp(res.intercept)
    return dict(
        A=A,
        alpha=res.slope,
        sigma_A=A * res.intercept_stderr,
        sigma_alpha=res.stderr,
        r2=res.rvalue**2,
    )


def exp_fit(x, y) -> dict:
    """
    Fit y = A · exp(k x) via semi-log linear regression.

    Returns:
        A        – amplitude at x=0
        k        – growth/decay rate
        sigma_A  – standard error on A
        sigma_k  – standard error on k
        r2       – R² of the semi-log linear fit
    """
    x, y = np.asarray(x, float), np.asarray(y, float)
    if (y <= 0).any():
        raise ValueError("Exponential fit requires y > 0")
    res = stats.linregress(x, log(y))
    A = exp(res.intercept)
    return dict(
        A=A,
        k=res.slope,
        sigma_A=A * res.intercept_stderr,
        sigma_k=res.stderr,
        r2=res.rvalue**2,
    )


def quadratic_fit(x, y) -> dict:
    """
    Least-squares fit y = A + B x + C x².

    Returns:
        A    – constant term
        B    – linear coefficient
        C    – quadratic coefficient
        r2   – coefficient of determination R²
    """
    x, y = np.asarray(x, float), np.asarray(y, float)
    coeffs = np.polyfit(x, y, 2)  # returns [C, B, A]
    C, B, A = coeffs
    y_pred = np.polyval(coeffs, x)
    ss_res = ((y - y_pred) ** 2).sum()
    ss_tot = ((y - y.mean()) ** 2).sum()
    return dict(A=A, B=B, C=C, r2=1.0 - ss_res / ss_tot)


def curve_fit(f: Callable, x, y, p0=None, sigma=None) -> tuple[np.ndarray, np.ndarray]:
    """
    Thin wrapper around scipy.optimize.curve_fit returning (popt, perr).
    If `sigma` (y-uncertainties) is given, errors are absolute.
    """
    popt, pcov = opt.curve_fit(
        f, x, y, p0=p0, sigma=sigma, absolute_sigma=sigma is not None
    )
    return popt, np.sqrt(np.diag(pcov))


# §4  KINEMATICS 1D  (constant acceleration)
def kin1d(*, v0=None, v=None, a=None, t=None, dx=None) -> dict:
    """
    Constant-acceleration 1D solver. Provide any 3 of {v0, v, a, t, dx}, get
    the remaining two. Solves the four standard equations:

        v  = v0 + a t
        dx = v0 t + ½ a t²
        v² = v0² + 2 a dx
        dx = ½ (v0 + v) t

    Picks the positive-time root when ambiguous.

    Returns:
        v0  – initial velocity [m/s]
        v   – final velocity [m/s]
        a   – acceleration [m/s²]
        t   – elapsed time [s]
        dx  – displacement [m]
    """
    syms = sp.symbols("v0 v a t dx", real=True)
    v0_s, v_s, a_s, t_s, dx_s = syms
    given = {}
    for name, val, sym in [
        ("v0", v0, v0_s),
        ("v", v, v_s),
        ("a", a, a_s),
        ("t", t, t_s),
        ("dx", dx, dx_s),
    ]:
        if val is not None:
            given[sym] = sp.nsimplify(val, rational=False)
    if len(given) < 3:
        raise ValueError("Need at least 3 of {v0, v, a, t, dx}")

    eq1 = sp.Eq(v_s, v0_s + a_s * t_s)
    eq2 = sp.Eq(dx_s, v0_s * t_s + a_s * t_s**2 / 2)
    eqs = [eq.subs(given) for eq in (eq1, eq2)]
    unknowns = [s for s in syms if s not in given]
    sols = sp.solve(eqs, unknowns, dict=True)
    if not sols:
        raise ValueError("No solution (inconsistent inputs)")

    # Prefer t ≥ 0 when t is unknown
    if t_s in unknowns:
        sols = sorted(sols, key=lambda s: -1 if float(s[t_s]) >= 0 else 1)

    sol = sols[0]
    out = {}
    for name, sym in zip(["v0", "v", "a", "t", "dx"], syms):
        val = given[sym] if sym in given else sol[sym]
        out[name] = float(val)
    return out


def free_fall_y(y0: float, v0: float, t, g_local: float = g) -> float | np.ndarray:
    """Vertical position under gravity (positive up):  y(t) = y0 + v0 t − ½ g t²."""
    t = np.asarray(t)
    return y0 + v0 * t - 0.5 * g_local * t * t


def free_fall_v(v0: float, t, g_local: float = g) -> float | np.ndarray:
    """Vertical velocity under gravity:  v(t) = v0 − g t."""
    return v0 - g_local * np.asarray(t)


def meeting_time(
    y_a: Callable, y_b: Callable, t_max: float = 1000, n_scan: int = 5000
) -> Optional[float]:
    """
    Smallest t > 0 where y_a(t) = y_b(t). Coarse scan + brentq refinement.
    Returns None if no crossing in (0, t_max].
    """
    ts = np.linspace(1e-9, t_max, n_scan)
    d = y_a(ts) - y_b(ts)
    sign_changes = np.where(np.diff(np.sign(d)) != 0)[0]
    if not sign_changes.size:
        return None
    i = sign_changes[0]
    return float(opt.brentq(lambda t: y_a(t) - y_b(t), ts[i], ts[i + 1]))


# §5  KINEMATICS 2D
def projectile(v0: float, theta_deg: float, y0: float = 0, g_local: float = g) -> dict:
    """
    Projectile launched from (0, y0) with speed v0 at angle θ above horizontal.

    Returns:
        vx          – horizontal velocity component (constant) [m/s]
        vy0         – initial vertical velocity component [m/s]
        t_apex      – time to reach peak height [s]
        h_max       – maximum height above ground (not above y0) [m]
        t_ground    – time of landing (y = 0) [s]
        range       – horizontal distance at landing [m]
        trajectory  – callable traj(t) returning (x(t), y(t)) arrays
    """
    θ = np.deg2rad(theta_deg)
    vx, vy0 = v0 * cos(θ), v0 * sin(θ)
    t_apex = vy0 / g_local
    h_max = y0 + vy0**2 / (2 * g_local)
    t_ground = (vy0 + sqrt(vy0**2 + 2 * g_local * y0)) / g_local
    R = vx * t_ground

    def traj(t):
        t = np.asarray(t)
        return vx * t, y0 + vy0 * t - 0.5 * g_local * t * t

    return dict(
        vx=vx,
        vy0=vy0,
        t_apex=t_apex,
        h_max=h_max,
        t_ground=t_ground,
        range=R,
        trajectory=traj,
    )


def relative_velocity_1d(*objects) -> float:
    """
    Convenience: sum velocities. velocity_of_A_wrt_C =
        relative_velocity_1d(v_A_wrt_B, v_B_wrt_C).
    """
    return float(sum(objects))


# §6  CIRCULAR MOTION
def rpm_to_rads(rpm: float) -> float:
    """Convert revolutions per minute → angular velocity ω [rad/s]."""
    return rpm * 2 * pi / 60


def centripetal_acc(*, v=None, r=None, omega=None) -> float:
    """
    Centripetal (radial) acceleration. Use either (v, r) or (ω, r).
        a = v²/r = ω² r
    """
    if v is not None and r is not None:
        return v * v / r
    if omega is not None and r is not None:
        return omega * omega * r
    raise ValueError("Provide (v, r) or (omega, r)")


def centrifuge_radius(rpm: float, a_in_g: float, g_local: float = g) -> float:
    """
    Radius of a centrifuge spinning at `rpm` whose outer rim acceleration
    equals `a_in_g` times g.
    """
    ω = rpm_to_rads(rpm)
    return a_in_g * g_local / (ω * ω)


def conical_pendulum(L: float, theta_deg: float, g_local: float = g) -> dict:
    """
    Conical pendulum (mass on string of length L sweeping at constant
    half-angle θ from vertical).

    Returns:
        omega            – angular velocity [rad/s]
        T                – period of revolution [s]
        v                – linear speed of the mass [m/s]
        r                – radius of the horizontal circle [m]
        tension_over_mg  – string tension divided by mg = 1 / cos θ
    """
    θ = np.deg2rad(theta_deg)
    ω = sqrt(g_local / (L * cos(θ)))
    r = L * sin(θ)
    return dict(omega=ω, T=2 * pi / ω, v=ω * r, r=r, tension_over_mg=1 / cos(θ))


def physical_pendulum_period(
    I_pivot: float, mass: float, d_cm: float, g_local: float = g
) -> float:
    """
    Small-angle period of a rigid body pivoting at distance `d_cm` from its
    center of mass, with moment of inertia `I_pivot` about the *pivot*:

        T = 2π · sqrt(I_pivot / (m · g · d_cm))

    Use `parallel_axis(I_cm, m, d_cm)` to convert from I_cm if needed.

    Simple-pendulum sanity check: point mass on string of length L gives
    I_pivot = m·L², d_cm = L  →  T = 2π·sqrt(L/g). ✓
    """
    return float(2 * pi * sqrt(I_pivot / (mass * g_local * d_cm)))


def banked_curve_angle(v: float, r: float, g_local: float = g) -> float:
    """
    Banking angle [deg] for a curve of radius r negotiated at speed v
    *without* relying on friction:    tan θ = v² / (g r).
    """
    return float(np.rad2deg(np.arctan(v * v / (r * g_local))))


# §7  NEWTON'S LAWS & FRICTION
def friction_force(mu: float, N: float) -> float:
    """Friction magnitude on a flat surface:  f = μ N."""
    return mu * N


def will_slip(F_applied: float, mu_s: float, N: float) -> bool:
    """Static slip test: returns True if applied force exceeds μ_s N."""
    return F_applied > mu_s * N


def inclined_plane(
    theta_deg: float, mu_k: float = 0, mu_s: float | None = None, g_local: float = g
) -> dict:
    """
    Block on a fixed incline.

        a_slide = g (sin θ − μ_k cos θ)
        stays at rest if tan θ ≤ μ_s.

    Returns:
        theta_deg        – incline angle [deg] (echoed back)
        a_slide          – acceleration while sliding [m/s²] (positive = down the slope)
        can_stay_at_rest – True if tan θ ≤ μ_s (static friction sufficient to hold block)
    """
    θ = np.deg2rad(theta_deg)
    a_slide = g_local * (sin(θ) - mu_k * cos(θ))
    can_rest = (mu_s is None) or (np.tan(θ) <= mu_s)
    return dict(theta_deg=theta_deg, a_slide=a_slide, can_stay_at_rest=can_rest)


def two_blocks_stacked(
    m_top: float,
    m_bot: float,
    F: float,
    mu_s: float,
    mu_k: float,
    g_local: float = g,
    pulled: str = "top",
) -> dict:
    """
    Two stacked blocks on a smooth floor. Horizontal force F on the chosen
    block (`pulled`: "top" or "bottom").

    Returns:
        slipping  – bool, whether the interface slides
        a_top     – acceleration of the top block [m/s²]
        a_bot     – acceleration of the bottom block [m/s²]
        a_cm      – acceleration of the system center of mass [m/s²]
                    (always F / (m_top + m_bot), internal friction doesn't affect COM)
        friction  – interface friction force magnitude [N]
    """
    N_interface = m_top * g_local
    f_static_max = mu_s * N_interface
    f_kinetic = mu_k * N_interface

    # Try "no slip" first: blocks move together with a_common = F/M
    M = m_top + m_bot
    a_common = F / M
    # The friction needed on bottom block to accelerate it at a_common:
    f_needed_on_bottom = m_bot * a_common if pulled == "top" else m_top * a_common

    if f_needed_on_bottom <= f_static_max:
        return dict(
            slipping=False,
            a_top=a_common,
            a_bot=a_common,
            a_cm=a_common,
            friction=f_needed_on_bottom,
        )

    # They slip: kinetic friction acts.
    if pulled == "top":
        a_top = (F - f_kinetic) / m_top
        a_bot = f_kinetic / m_bot
    else:  # pulled bottom
        a_top = f_kinetic / m_top
        a_bot = (F - f_kinetic) / m_bot
    a_cm = F / M  # internal friction cancels in COM
    return dict(slipping=True, a_top=a_top, a_bot=a_bot, a_cm=a_cm, friction=f_kinetic)


def mu_k_from_deceleration(a_decel: float, g_local: float = g) -> float:
    """
    Pure-friction deceleration on a flat surface:  μ_k = |a| / g.
    """
    return abs(a_decel) / g_local


# §8  EQUATION OF MOTION  (ODE integration)
def integrate_em(
    force_func: Callable[[float, float, float], float],
    mass: float,
    x0: float,
    v0: float,
    t_span: tuple[float, float],
    n_points: int = 1001,
) -> dict:
    """
    Integrate m·ẍ = F(t, x, ẋ) using scipy.solve_ivp (RK45 default).

    Returns:
        t  – time array [s] (numpy)
        x  – position array [m] (numpy)
        v  – velocity array [m/s] (numpy)
    """

    def rhs(t, y):
        x, v = y
        return [v, force_func(t, x, v) / mass]

    sol = solve_ivp(
        rhs,
        t_span,
        [x0, v0],
        t_eval=np.linspace(*t_span, n_points),
        rtol=1e-9,
        atol=1e-12,
    )
    return dict(t=sol.t, x=sol.y[0], v=sol.y[1])


def air_drag_fall(
    mass: float,
    drag_coef_b: float,
    y0: float = 100,
    v0: float = 0,
    t_max: float = 20,
    g_local: float = g,
    n_points: int = 1001,
) -> dict:
    """
    1D fall with linear drag:  F = −m g − b v  (positive up).
    Terminal speed = m g / b.

    Returns:
        t           – time array [s] (numpy)
        y           – vertical position array [m], positive up (numpy)
        v           – vertical velocity array [m/s] (numpy)
        v_terminal  – terminal fall speed magnitude m g / b [m/s]
    """

    def F(t, x, v):
        return -mass * g_local - drag_coef_b * v

    out = integrate_em(F, mass, y0, v0, (0, t_max), n_points)
    out["v_terminal"] = mass * g_local / drag_coef_b
    return out


def quadratic_drag_fall(
    mass: float,
    drag_coef_D: float,
    y0: float = 100,
    v0: float = 0,
    t_max: float = 20,
    g_local: float = g,
    n_points: int = 1001,
) -> dict:
    """
    1D fall with quadratic drag:  F = −m g − D · v · |v|  (positive up).
    Terminal speed = sqrt(m g / D).

    D = ½ ρ C_D A  (use this to derive D from the drag coefficient).

    Returns:
        t           – time array [s] (numpy)
        y           – vertical position array [m], positive up (numpy)
        v           – vertical velocity array [m/s] (numpy)
        v_terminal  – terminal fall speed magnitude sqrt(m g / D) [m/s]
    """

    def F(t, x, v):
        return -mass * g_local - drag_coef_D * v * abs(v)

    out = integrate_em(F, mass, y0, v0, (0, t_max), n_points)
    out["v_terminal"] = sqrt(mass * g_local / drag_coef_D)
    return out


def terminal_velocity(
    mass: float,
    drag_coef: float,
    regime: str = "linear",
    g_local: float = g,
) -> float:
    """
    Terminal fall speed for a body in steady-state drag.

      linear (Stokes):   F = b v        →  v_t = m g / b
      quadratic (form):  F = D v²       →  v_t = sqrt(m g / D)

    `drag_coef` is `b` for linear, `D` for quadratic.
    """
    if regime == "linear":
        return mass * g_local / drag_coef
    if regime == "quadratic":
        return sqrt(mass * g_local / drag_coef)
    raise ValueError(f"regime must be 'linear' or 'quadratic', got {regime!r}")


def oscillation_period(
    force_func: Callable[[float, float, float], float],
    mass: float,
    x0: float,
    v0: float,
    t_max: float = 100,
) -> float:
    """
    Period of a (possibly nonlinear) oscillation, found by detecting successive
    velocity-zero crossings (maxima of x) via solve_ivp events.

    Args:
        force_func – F(t, x, v): net force [N]
        mass       – mass [kg]
        x0, v0     – initial conditions [m], [m/s]
        t_max      – integration window [s]; increase if fewer than 2 maxima found

    Returns mean period [s] across all detected maxima.
    """

    def rhs(t, y):
        x, v = y
        return [v, force_func(t, x, v) / mass]

    class _MaximaEvent:
        direction = -1  # v goes + → − at a peak
        terminal = False

        def __call__(self, t, y):
            return y[1]

    sol = solve_ivp(
        rhs,
        [0, t_max],
        [x0, v0],
        events=[_MaximaEvent()],
        max_step=t_max / 1000,
        rtol=1e-9,
        atol=1e-12,
    )
    t_events = sol.t_events[0]
    if len(t_events) < 2:
        raise ValueError(
            "Fewer than 2 maxima found; increase t_max or check initial conditions"
        )
    return float(np.diff(t_events).mean())


def damped_driven_sho(
    mass: float,
    damping_b: float,
    spring_k: float,
    F0: float = 0.0,
    omegas: Optional[np.ndarray] = None,
    t_transient: float = 50.0,
    t_measure: float = 50.0,
    n_points_per_period: int = 200,
) -> dict:
    """
    Driven damped harmonic oscillator:  m·ẍ + b·ẋ + k·x = F0·sin(ω·t).

    If `omegas` is None: return the time-domain solution for free vibration
    (F0 = 0) at the natural frequency starting from x=1, v=0.

    If `omegas` is given: sweep ω, integrate past the transient (`t_transient`
    seconds), then measure steady-state amplitude over `t_measure` seconds.
    Returns the response curve A(ω).

    Returns:
        omega0    – natural angular frequency sqrt(k/m) [rad/s]
        zeta      – damping ratio b / (2·sqrt(m·k))
        omega_d   – damped angular frequency, omega0·sqrt(1 − ζ²) (NaN if ζ ≥ 1)
        omegas    – the ω array used (only if sweep)
        amplitude – steady-state amplitude at each ω (only if sweep)
        t, x, v   – time-domain arrays (only if no sweep)
    """
    omega0 = sqrt(spring_k / mass)
    zeta = damping_b / (2 * sqrt(mass * spring_k))
    omega_d = omega0 * sqrt(1 - zeta**2) if zeta < 1 else float("nan")

    if omegas is None:
        # Free response with unit initial displacement
        def rhs(t, y):
            x, v = y
            return [v, -(damping_b * v + spring_k * x) / mass]

        T = 2 * pi / omega0
        sol = solve_ivp(
            rhs,
            (0, 10 * T),
            [1.0, 0.0],
            t_eval=np.linspace(0, 10 * T, 10 * n_points_per_period),
            rtol=1e-9,
            atol=1e-12,
        )
        return dict(
            omega0=omega0, zeta=zeta, omega_d=omega_d,
            t=sol.t, x=sol.y[0], v=sol.y[1],
        )

    omegas = np.asarray(omegas, float)
    amps = np.empty_like(omegas)
    for i, w in enumerate(omegas):
        def rhs(t, y, w=w):
            x, v = y
            return [v, (F0 * sin(w * t) - damping_b * v - spring_k * x) / mass]

        T = 2 * pi / w
        t_total = t_transient + t_measure
        n_points = max(int(n_points_per_period * t_total / T), 200)
        sol = solve_ivp(
            rhs,
            (0, t_total),
            [0.0, 0.0],
            t_eval=np.linspace(0, t_total, n_points),
            rtol=1e-9,
            atol=1e-12,
        )
        mask = sol.t >= t_transient
        x_ss = sol.y[0][mask]
        amps[i] = 0.5 * (x_ss.max() - x_ss.min())
    return dict(
        omega0=omega0, zeta=zeta, omega_d=omega_d,
        omegas=omegas, amplitude=amps,
    )


# §9  WORK AND ENERGY
def kinetic_energy(m: float, v: float) -> float:
    """K = ½ m v²"""
    return 0.5 * m * v * v


def potential_energy_grav(m: float, h: float, g_local: float = g) -> float:
    """U = m g h"""
    return m * g_local * h


def potential_energy_spring(k: float, x: float) -> float:
    """U = ½ k x²"""
    return 0.5 * k * x * x


def work_constant_force(F: float, d: float, theta_deg: float = 0) -> float:
    """Work by constant force at angle θ to displacement:  W = F d cos θ."""
    return F * d * cos(np.deg2rad(theta_deg))


def work_variable_force(
    F_of_x: Callable[[float], float], x_start: float, x_end: float
) -> float:
    """Work by 1D variable force:  W = ∫ F(x) dx."""
    from scipy.integrate import quad

    return float(quad(F_of_x, x_start, x_end)[0])


def constant_F_to_travel_d_in_t(d: float, t: float, m: float) -> dict:
    """
    Starting from rest under constant net force F, travel distance d in time t.
        d = ½ a t² ⇒ a = 2d/t² , F = m a , W = F d = 2 m d² / t².

    Returns:
        a  – required acceleration [m/s²]
        F  – required net force [N]
        W  – work done = F · d [J]
    """
    a = 2 * d / (t * t)
    F = m * a
    return dict(a=a, F=F, W=F * d)


# §10  CONSERVATION OF ENERGY
def height_to_speed(h: float, v_top: float = 0, g_local: float = g) -> float:
    """Speed at the bottom after dropping height h (frictionless): v = √(v_top² + 2 g h)."""
    return sqrt(v_top * v_top + 2 * g_local * h)


def speed_at_height(v0: float, dh: float, g_local: float = g) -> float:
    """
    Speed after rising height Δh (frictionless):  v² = v0² − 2 g Δh.
    Use negative Δh for falling.
    """
    s = v0 * v0 - 2 * g_local * dh
    if s < 0:
        raise ValueError("Object cannot reach that height with given v0")
    return sqrt(s)


def pendulum_speed_at_angle(
    v0_bottom: float, R: float, theta_deg: float, g_local: float = g
) -> float:
    """
    Speed of pendulum bob at angle θ from the downward vertical.
    Height risen: h = R (1 − cos θ).
    """
    h = R * (1 - cos(np.deg2rad(theta_deg)))
    return speed_at_height(v0_bottom, h, g_local)


def pendulum_tension(
    v0_bottom: float, R: float, theta_deg: float, m: float, g_local: float = g
) -> dict:
    """
    Tension in the string of a simple pendulum at angle θ from vertical
    given speed v0 at the bottom.

    Radial Newton's 2nd law:  T − m g cos θ = m v²/R   ⇒   T = m v²/R + m g cos θ.

    Returns:
        v  – speed of the bob at angle θ [m/s]
        T  – string tension at angle θ [N]
        h  – height risen above the bottom: R (1 − cos θ) [m]
    """
    θ = np.deg2rad(theta_deg)
    v = pendulum_speed_at_angle(v0_bottom, R, theta_deg, g_local)
    T = m * v * v / R + m * g_local * cos(θ)
    return dict(v=v, T=T, h=R * (1 - cos(θ)))


def spring_launch_speed(k: float, x: float, m: float) -> float:
    """Speed of a mass launched by a spring compressed by x: v = x √(k/m)."""
    return x * sqrt(k / m)


def spring_max_compression(m: float, v: float, k: float) -> float:
    """
    Maximum compression when mass m hits a spring at speed v.
    ½mv² = ½kx²  →  x = v √(m/k).
    Inverse of spring_launch_speed.
    """
    return v * sqrt(m / k)


def spring_k_from_drop(m: float, h: float, d: float, g_local: float = g) -> float:
    """
    Spring constant when mass m is dropped from height h above a spring and
    compresses it by distance d.
    mg(h+d) = ½kd²  →  k = 2mg(h+d)/d².
    """
    return 2 * m * g_local * (h + d) / (d * d)


def hanging_spring_lowest(m: float, k: float, g_local: float = g) -> float:
    """
    Lowest point reached when mass m is attached to a vertical spring (constant k)
    and released from rest at the spring's natural length.
    mgh = ½kh²  →  h = 2mg/k.
    (Equilibrium is at h/2 = mg/k below the natural length.)
    """
    return 2 * m * g_local / k


# §11  MOMENTUM, COLLISIONS, COM
def momentum(m: float, v: float) -> float:
    """p = m v"""
    return m * v


def center_of_mass(masses, positions) -> float | np.ndarray:
    """COM of point masses. `positions` may be 1D scalars or 2D coordinates."""
    m = np.asarray(masses, float)
    p = np.asarray(positions, float)
    return (
        (m[:, None] * p).sum(0) / m.sum()
        if p.ndim == 2
        else float((m * p).sum() / m.sum())
    )


def elastic_1d(m1: float, v1i: float, m2: float, v2i: float) -> tuple[float, float]:
    """
    Standard 1D elastic-collision formulas:
        v1f = ((m1−m2) v1i + 2 m2 v2i) / (m1+m2)
        v2f = ((m2−m1) v2i + 2 m1 v1i) / (m1+m2)
    """
    M = m1 + m2
    v1f = ((m1 - m2) * v1i + 2 * m2 * v2i) / M
    v2f = ((m2 - m1) * v2i + 2 * m1 * v1i) / M
    return v1f, v2f


def inelastic_1d(m1: float, v1i: float, m2: float, v2i: float) -> dict:
    """
    Perfectly inelastic collision: objects stick together after impact.

    Returns:
        vf            – common final velocity [m/s]
        Ki            – total kinetic energy before collision [J]
        Kf            – total kinetic energy after collision [J]
        energy_lost   – kinetic energy lost: Ki − Kf [J]
    """
    vf = (m1 * v1i + m2 * v2i) / (m1 + m2)
    Ki = 0.5 * m1 * v1i**2 + 0.5 * m2 * v2i**2
    Kf = 0.5 * (m1 + m2) * vf * vf
    return dict(vf=vf, Ki=Ki, Kf=Kf, energy_lost=Ki - Kf)


def collision_2d(
    m1: float, v1i, m2: float, v2i, v1f
) -> dict:
    """
    2D collision via momentum conservation (per component).

    Given the masses and three of the four velocity vectors, solves
        m1 v1i + m2 v2i = m1 v1f + m2 v2f
    for v2f.

    Velocities are 2-vectors (any iterable of length 2; e.g. tuples, lists,
    numpy arrays).

    Returns:
        v2f          – final velocity of body 2 [m/s, m/s] (numpy)
        Ki           – total kinetic energy before [J]
        Kf           – total kinetic energy after [J]
        energy_lost  – Ki − Kf (>0 inelastic, 0 elastic, <0 → bad input)
        angle_deg    – angle between v1f and v2f in degrees
        is_elastic   – True if |energy_lost / Ki| < 1e−6
    """
    v1i = np.asarray(v1i, float)
    v2i = np.asarray(v2i, float)
    v1f = np.asarray(v1f, float)
    v2f = (m1 * v1i + m2 * v2i - m1 * v1f) / m2
    Ki = 0.5 * m1 * (v1i @ v1i) + 0.5 * m2 * (v2i @ v2i)
    Kf = 0.5 * m1 * (v1f @ v1f) + 0.5 * m2 * (v2f @ v2f)
    # Angle between final velocities
    n1 = np.linalg.norm(v1f)
    n2 = np.linalg.norm(v2f)
    if n1 > 0 and n2 > 0:
        cos_a = np.clip((v1f @ v2f) / (n1 * n2), -1.0, 1.0)
        angle_deg = float(np.degrees(np.arccos(cos_a)))
    else:
        angle_deg = float("nan")
    return dict(
        v2f=v2f, Ki=Ki, Kf=Kf, energy_lost=Ki - Kf,
        angle_deg=angle_deg, is_elastic=abs(Ki - Kf) < 1e-6 * max(Ki, 1.0),
    )


def explosion_2body(m1: float, m2: float, v2: float) -> float:
    """
    Two-body explosion from rest: m1 v1 + m2 v2 = 0  ⇒  v1 = −m2 v2 / m1.
    """
    return -m2 * v2 / m1


def fusion_energy_split(mass_ratio: float, E_total: float = 1.0) -> dict:
    """
    Two-body decay/fusion from rest: heavy product has mass ratio = m_H / m_L.

    Momentum conservation: m_H v_H = m_L v_L  ⇒ v_L = mass_ratio · v_H.
    KE ratio:  K_H / K_L = (m_H v_H²) / (m_L v_L²) = 1 / mass_ratio.
    ⇒ heavy fraction = 1 / (1 + mass_ratio).

    Returns:
        heavy_fraction  – fraction of E_total carried by the heavy product
        light_fraction  – fraction of E_total carried by the light product
        E_heavy         – kinetic energy of the heavy product [same units as E_total]
        E_light         – kinetic energy of the light product [same units as E_total]
    """
    heavy_frac = 1.0 / (1.0 + mass_ratio)
    return dict(
        heavy_fraction=heavy_frac,
        light_fraction=1 - heavy_frac,
        E_heavy=heavy_frac * E_total,
        E_light=(1 - heavy_frac) * E_total,
    )


# §12  ROTATION
# Moments of inertia (uniform bodies, about indicated axis)
def I_solid_sphere(m: float, r: float) -> float:
    return 0.4 * m * r * r


def I_hollow_sphere(m: float, r: float) -> float:
    return (2 / 3) * m * r * r


def I_solid_disc(m: float, r: float) -> float:
    return 0.5 * m * r * r


def I_hoop(m: float, r: float) -> float:
    return m * r * r


def I_rod_center(m: float, L: float) -> float:
    return m * L * L / 12


def I_rod_end(m: float, L: float) -> float:
    return m * L * L / 3


def I_point(m: float, r: float) -> float:
    return m * r * r


def parallel_axis(I_cm: float, m: float, d: float) -> float:
    """Steiner: I = I_cm + m d² (parallel-axis theorem)."""
    return I_cm + m * d * d


# Dynamics
def rotational_ke(inertia: float, omega: float) -> float:
    """K_rot = ½ I ω²"""
    return 0.5 * inertia * omega * omega


def angular_momentum(inertia: float, omega: float) -> float:
    """L = I ω"""
    return inertia * omega


def torque(F: float, r: float, theta_deg: float = 90) -> float:
    """|τ| = r F sin θ"""
    return r * F * sin(np.deg2rad(theta_deg))


def angular_acceleration(tau_net: float, inertia: float) -> float:
    """α = τ_net / I"""
    return tau_net / inertia


def rolling_without_slipping_v(omega: float, r: float) -> float:
    """v_cm = ω r for pure rolling."""
    return omega * r


def kinetic_energy_rolling(m: float, v_cm: float, I_cm: float, r: float) -> float:
    """K_total = ½ m v² + ½ I_cm ω²  with ω = v/r."""
    return 0.5 * m * v_cm**2 + 0.5 * I_cm * (v_cm / r) ** 2


def bowling_ball_after_release(
    m: float, r: float, v0: float, mu_k: float, g_local: float = g
) -> dict:
    """
    Bowling ball released sliding with no initial spin. Kinetic friction decelerates
    the CM and spins up the ball until v_cm = r ω (pure rolling).

        a = −μ_k g
        α = μ_k m g r / I_cm   (friction torque)
        t_roll: solve v0 + a t = r α t

    Returns:
        a                  – linear acceleration of the CM (negative, decelerating) [m/s²]
        alpha              – angular acceleration (positive, spinning up) [rad/s²]
        t_pure_rolling     – time until pure rolling begins [s]
        v_at_pure_rolling  – CM speed when pure rolling starts [m/s]
    """
    I_cm = I_solid_sphere(m, r)
    a = -mu_k * g_local
    α = mu_k * m * g_local * r / I_cm  # τ = f·r → α = μ m g r / I_cm
    # Sliding until v(t) = r ω(t): v0 + a t = r α t ⇒ t = v0/(rα − a)
    t_pure_roll = v0 / (r * α - a)
    v_at_roll = v0 + a * t_pure_roll
    return dict(
        a=a,
        alpha=α,
        t_pure_rolling=t_pure_roll,
        v_at_pure_rolling=v_at_roll,
    )


def atwood_with_pulley(
    m1: float, m2: float, I_pulley: float, R_pulley: float, g_local: float = g
) -> dict:
    """
    Atwood machine with a *massive* pulley. m1 is taken to be the heavier
    mass; if m2 > m1 the sign of `a` will simply flip.

      a = (m1 − m2) g / (m1 + m2 + I_p / R²)

    Tensions on the two sides are *unequal* because torque accelerates the
    pulley:
      T1 = m1 (g − a)     (heavier side, descending)
      T2 = m2 (g + a)     (lighter side, ascending)

    Sanity: I_pulley = 0 reduces to the classic Atwood formula.

    Returns:
        a           – signed acceleration of m1 [m/s²] (positive = m1 down)
        alpha       – angular acceleration of pulley [rad/s²]
        T1, T2      – string tensions [N]
        delta_T     – T1 − T2 = I_p · α / R  (zero for massless pulley)
    """
    denom = m1 + m2 + I_pulley / (R_pulley * R_pulley)
    a = (m1 - m2) * g_local / denom
    alpha = a / R_pulley
    T1 = m1 * (g_local - a)
    T2 = m2 * (g_local + a)
    return dict(a=a, alpha=alpha, T1=T1, T2=T2, delta_T=T1 - T2)


def collide_disc_drop(I1: float, omega1: float, I2_falling: float) -> dict:
    """
    A non-rotating disc lands on a spinning disc with frictionless bearing.
    Angular momentum about the spin axis is conserved (gravity exerts no
    torque about the vertical axis).  Linear KE of fall is lost on impact;
    rotational KE then decreases as friction equalises ω.

    Returns:
        omega_final  – common angular velocity after the discs equalise [rad/s]
        K_rot_i      – rotational kinetic energy before impact [J]
        K_rot_f      – rotational kinetic energy after equalising [J]
        K_lost_rot   – rotational KE lost to friction between the discs [J]
    """
    omega_f = I1 * omega1 / (I1 + I2_falling)
    K_rot_i = 0.5 * I1 * omega1**2
    K_rot_f = 0.5 * (I1 + I2_falling) * omega_f**2
    return dict(
        omega_final=omega_f,
        K_rot_i=K_rot_i,
        K_rot_f=K_rot_f,
        K_lost_rot=K_rot_i - K_rot_f,
    )


# §13  PLOT HELPERS
def plot_1d_motion(v0: float, a: float, t_max: float, *, ax=None) -> None:
    """Plot x(t), v(t), a(t) for constant-acc 1D motion."""
    t = np.linspace(0, t_max, 400)
    x = v0 * t + 0.5 * a * t * t
    v = v0 + a * t
    if ax is None:
        fig, ax = plt.subplots(3, 1, sharex=True, figsize=(6, 6))
    ax[0].plot(t, x)
    ax[0].set_ylabel("x [m]")
    ax[1].plot(t, v)
    ax[1].set_ylabel("v [m/s]")
    ax[2].plot(t, np.full_like(t, a))
    ax[2].set_ylabel("a [m/s²]")
    ax[2].set_xlabel("t [s]")
    for a_ in ax:
        a_.grid(True, alpha=0.3)


def plot_trajectory(
    v0: float, theta_deg: float, y0: float = 0, *, ax=None, g_local: float = g
) -> None:
    """Plot a projectile trajectory in the x-y plane."""
    proj = projectile(v0, theta_deg, y0, g_local)
    t = np.linspace(0, proj["t_ground"], 200)
    x, y = proj["trajectory"](t)
    if ax is None:
        fig, ax = plt.subplots()
    ax.plot(x, y)
    ax.set_xlabel("x [m]")
    ax.set_ylabel("y [m]")
    ax.grid(True, alpha=0.3)
    ax.set_aspect("equal", adjustable="box")


def fit_summary_df(fits: dict) -> pl.DataFrame:
    """Collect several fit-result dicts (from *_fit functions) into a Polars table."""
    rows = []
    for name, d in fits.items():
        rows.append(
            {
                "name": name,
                **{k: float(v) if not callable(v) else None for k, v in d.items()},
            }
        )
    return pl.DataFrame(rows)
