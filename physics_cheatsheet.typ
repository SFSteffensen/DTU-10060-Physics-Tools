#import "@local/dtu-template:0.6.3": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/physica:0.9.8": *
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": plot

#show: super-T-as-transpose

#show: dtu-note.with(
  course: "10060",
  course-name: "Physics (Polytechnical Foundation)",
  title: "Seb's Collection of Solutions — Physics PF",
  date: datetime.today(),
  author: "Sebastian Faber Steffensen (s255609)",
  semester: "2026 Spring",
)

#set math.mat(delim: "[")
#set math.vec(delim: "[")

#outline()

#pagebreak()
= Quick Reference

== Important Formulas - Pocket Card

#align(center)[
  #table(
    columns: 2,
    stroke: 0.5pt,
    inset: 6pt,
    fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
    table.header([*What*], [*Formula*]),
    [Constant acceleration 1D],
    [$v = v_0 + a t$,$quad Delta x = v_0 t + 1/2 a t^2$, $quad v^2 = v_0^2 + 2 a Delta x$],
    [Free fall (y upward)],
    [$y(t) = y_0 + v_0 t - 1/2 g t^2$],
    [Projectile (from ground)],
    [$R = (v_0^2 sin(2 theta))/g$, $quad h_max = (v_0^2 sin^2 theta)/(2 g)$],
    [Centripetal acceleration],
    [$a_c = v^2 / r = omega^2 r$],
    [Newton's 2nd law],
    [$sum va(F) = m va(a)$],
    [Kinetic friction],
    [$f_k = mu_k n$ (opposite to motion)],
    [Static friction],
    [$f_s <= mu_s n$ (the inequality!)],
    [Kinetic energy],
    [$K = 1/2 m v^2$],
    [Grav. potential],
    [$U_"grav" = m g h$],
    [Spring potential],
    [$U_("spring") = 1/2 k x^2$],
    [Work (constant force)],
    [$W = F d cos theta$],
    [Work (variable force)],
    [$W = integral_(x_1)^(x_2) F(x) dd(x)$],
    [Power],
    [$P = (dd(W))/(dd(t)) = va(F) dot va(v)$],
    [Momentum],
    [$va(p) = m va(v)$, $quad sum va(p)_i = sum va(p)_f$ (closed system)],
    [Torque],
    [$tau = r F sin theta$],
    [Rotational analogue of $F=m a$],
    [$tau_("net") = I alpha$],
    [Angular momentum],
    [$L = I omega$ (conserved when $tau_("ext") = 0$)],
    [Rolling without slipping],
    [$v_("cm") = omega r$],
  )
]

== Formula Reference

=== Kinematics

#definition(title: [Constant Acceleration])[
  $
    v = v_0 + a t
  $
  $
    a = (v - v_0) / t, quad
    t = (v - v_0) / a, quad
    v_0 = v - a t
  $
]

#definition(title: [Displacement])[
  $
    Delta x = v_0 t + 1/2 a t^2
  $
  $
    v_0 = (Delta x - 1/2 a t^2) / t, quad
    a = 2(Delta x - v_0 t) / t^2, quad
    t = (-v_0 + sqrt(v_0^2 + 2 a Delta x)) / a
  $
]

#definition(title: [Velocity–Distance])[
  $
    v^2 = v_0^2 + 2 a Delta x
  $
  $
    a = (v^2 - v_0^2) / (2 Delta x), quad
    Delta x = (v^2 - v_0^2) / (2 a), quad
    v_0 = sqrt(v^2 - 2 a Delta x)
  $
]

#definition(title: [Free Fall])[
  $
    y(t) = y_0 + v_0 t - 1/2 g t^2, quad v(t) = v_0 - g t
  $
  $
    t_"top" = v_0 / g, quad
    h_"max" = v_0^2 / (2 g), quad
    t_"air" = 2 v_0 / g
  $
]

=== Projectile Motion

#definition(title: [Trajectory])[
  $
    x(t) = v_0 cos theta dot t, quad
    y(t) = y_0 + v_0 sin theta dot t - 1/2 g t^2
  $
  $
    v_x = v_0 cos theta quad #text("(constant)"), quad
    v_y(t) = v_0 sin theta - g t
  $
]

#definition(title: [Range, Height, Time of Flight (same launch/land height)])[
  $
    R = v_0^2 sin(2 theta) / g, quad
    h_"max" = v_0^2 sin^2 theta / (2 g), quad
    T = 2 v_0 sin theta / g
  $
  $
    v_0 = sqrt(R g / sin(2 theta)), quad
    theta = 1/2 arcsin(R g / v_0^2), quad
    g = v_0^2 sin(2 theta) / R
  $
]

#definition(title: [Speed at Any Height])[
  $
    v^2 = v_0^2 - 2 g (y - y_0)
  $
  $
    y - y_0 = (v_0^2 - v^2) / (2 g), quad
    v = sqrt(v_0^2 - 2 g (y - y_0))
  $
]

=== Energy

#definition(title: [Kinetic Energy])[
  $
    K = 1/2 m v^2
  $
  $
    m = 2 K / v^2, quad v = sqrt(2 K / m)
  $
]

#definition(title: [Gravitational Potential Energy])[
  $
    U_"grav" = m g h
  $
  $
    m = U / (g h), quad g = U / (m h), quad h = U / (m g)
  $
]

#definition(title: [Spring Potential Energy])[
  $
    U_"spring" = 1/2 k x^2
  $
  $
    k = 2 U / x^2, quad x = sqrt(2 U / k)
  $
]

#definition(title: [Work–Energy Theorem])[
  $
    W_"net" = Delta K = K_f - K_i
  $
  $
    K_f = K_i + W_"net", quad K_i = K_f - W_"net"
  $
]

#definition(title: [Conservation of Energy])[
  $
    K_1 + U_1 + W_"nc" = K_2 + U_2
  $
  $W_"nc"$ = work by non-conservative forces (friction $< 0$, engine $> 0$).

  Frictionless drop from rest: $v = sqrt(2 g h)$, $quad h = v^2 / (2 g)$.
]

#definition(title: [Power])[
  $
    P = (dd(W)) / (dd(t)) = va(F) dot va(v) = F v cos theta
  $
  $
    F = P / (v cos theta), quad v = P / (F cos theta), quad t = W / P
  $
]

=== Forces

#definition(title: [Newton's Second Law])[
  $
    sum va(F) = m va(a)
  $
  $
    a = F_"net" / m, quad m = F_"net" / a
  $
]

#definition(title: [Weight])[
  $
    W = m g
  $
  $
    m = W / g, quad g = W / m
  $
]

#definition(title: [Friction])[
  $
    f_k = mu_k n quad #text("(kinetic)"), quad f_s <= mu_s n quad #text("(static)")
  $
  $
    mu_k = f_k / n, quad n = f_k / mu_k
  $
  Normal force: flat surface $n = m g$; incline $n = m g cos theta$.
]

#definition(title: [Inclined Plane])[
  $
    F_parallel = m g sin theta, quad n = m g cos theta
  $
  $
    theta = arcsin(F_parallel / (m g)), quad m = F_parallel / (g sin theta)
  $
  Slides if $tan theta > mu_s$. Sliding acceleration: $a = g(sin theta - mu_k cos theta)$.
]

=== Circular Motion

#definition(title: [Centripetal Acceleration])[
  $
    a_c = v^2 / r = omega^2 r
  $
  $
    r = v^2 / a_c = a_c / omega^2, quad
    v = sqrt(a_c r), quad
    omega = sqrt(a_c / r)
  $
]

#definition(title: [Centripetal Force])[
  $
    F_c = m v^2 / r = m omega^2 r
  $
  $
    m = F_c r / v^2, quad r = m v^2 / F_c, quad v = sqrt(F_c r / m)
  $
]

#definition(title: [Angular Velocity])[
  $
    omega = 2 pi f = (2 pi) / T = "rpm" times 2 pi / 60
  $
  $
    f = omega / (2 pi), quad T = (2 pi) / omega
  $
]

=== Pendulum & Springs

#definition(title: [Pendulum Height])[
  $
    h = R (1 - cos theta)
  $
  $
    theta = arccos(1 - h/R), quad R = h / (1 - cos theta)
  $
]

#definition(title: [Pendulum Speed at Angle])[
  $
    v^2 = v_0^2 - 2 g R (1 - cos theta)
  $
  $
    v_0 = sqrt(v^2 + 2 g R (1 - cos theta)), quad
    R = (v_0^2 - v^2) / (2 g (1 - cos theta))
  $
]

#definition(title: [Pendulum String Tension])[
  $
    T = m v^2 / R + m g cos theta
  $
  $
    v = sqrt((T - m g cos theta) R / m), quad
    R = m v^2 / (T - m g cos theta)
  $
]

#definition(title: [Loop-the-Loop])[
  Min speed at top (normal force $= 0$): $v_"top" = sqrt(g R)$

  Min launch height from rest: $h_"min" = 5 R / 2$

  $
    R = v_"top"^2 / g = 2 h_"min" / 5
  $
]

#definition(title: [Spring Launch])[
  $
    1/2 k x^2 = 1/2 m v^2 quad => quad v = x sqrt(k / m)
  $
  $
    x = v sqrt(m / k), quad k = m v^2 / x^2, quad m = k x^2 / v^2
  $
]

=== Momentum & Collisions

#definition(title: [Momentum])[
  $
    va(p) = m va(v)
  $
  $
    m = p / v, quad v = p / m
  $
  Conservation (closed system): $sum va(p)_i = sum va(p)_f$.
]

#definition(title: [Impulse])[
  $
    Delta va(p) = va(F) Delta t
  $
  $
    va(F) = Delta va(p) / Delta t, quad Delta t = Delta va(p) / va(F)
  $
]

#definition(title: [Perfectly Inelastic Collision])[
  $
    v_f = (m_1 v_1 + m_2 v_2) / (m_1 + m_2)
  $
  $
    m_1 = m_2 (v_f - v_2) / (v_1 - v_f), quad
    v_1 = ((m_1 + m_2) v_f - m_2 v_2) / m_1
  $
]

#definition(title: [Elastic Collision (1D)])[
  $
    v_(1f) = ((m_1 - m_2) v_(1i) + 2 m_2 v_(2i)) / (m_1 + m_2)
  $
  $
    v_(2f) = ((m_2 - m_1) v_(2i) + 2 m_1 v_(1i)) / (m_1 + m_2)
  $
  Special case $v_(2i) = 0$, equal masses: $v_(1f) = 0$, $v_(2f) = v_(1i)$.
]

#definition(title: [Explosion from Rest])[
  $
    0 = m_1 v_1 + m_2 v_2 quad => quad v_1 = -(m_2 / m_1) v_2
  $
  $
    m_1 / m_2 = -v_2 / v_1, quad v_2 = -(m_1 / m_2) v_1
  $
]

=== Rotation

#definition(title: [Torque])[
  $
    tau = r F sin theta
  $
  $
    F = tau / (r sin theta), quad r = tau / (F sin theta), quad theta = arcsin(tau / (r F))
  $
]

#definition(title: [Rotational Newton's Second Law])[
  $
    sum tau_"net" = I alpha
  $
  $
    alpha = tau_"net" / I, quad I = tau_"net" / alpha
  $
]

#definition(title: [Angular Momentum])[
  $
    L = I omega
  $
  Conservation when $sum tau_"ext" = 0$:
  $
    I_1 omega_1 = I_2 omega_2 quad => quad omega_2 = I_1 omega_1 / I_2
  $
]

#definition(title: [Rolling Without Slipping])[
  $
    v_"cm" = omega r
  $
  $
    omega = v_"cm" / r, quad r = v_"cm" / omega
  $
  $
    K_"total" = 1/2 m v_"cm"^2 + 1/2 I_"cm" omega^2 = 1/2 m v_"cm"^2 (1 + I_"cm" / (m r^2))
  $
]

=== Error Propagation

#definition(title: [Gaussian Error Propagation])[
  $
    sigma_f = sqrt(sum_i (pdv(f, x_i) dot sigma_i)^2)
  $

  Sum/difference: $quad sigma_f = sqrt(sigma_a^2 + sigma_b^2)$

  Product/quotient: $quad (sigma_f / f)^2 = (sigma_a / a)^2 + (sigma_b / b)^2$

  Power: $quad sigma_f / f = abs(n) sigma_a / a$
]

#pagebreak()

= Experiments, Statistics and Error Propagation

#important[
  These problems will typically be the first 1–2 on the exam.
]

== Sample statistics

#definition(title: [Empirical mean and standard deviation])[
For $n$ measurements ${x_1, ..., x_n}$:
$
  overline(x) = 1/n sum_(i=1)^n x_i, quad s = sqrt(1/(n-1) sum_(i=1)^n (x_i - overline(x))^2)
$

*Important:* Use $n - 1$ in the denominator (Bessel correction). In `numpy` this corresponds to `ddof=1`.

Standard error of the mean: $sigma_(overline(x)) = s / sqrt(n)$.
]

#note-box()[
  *Procedure — "Is a new measurement consistent with previous ones?":*

  + Compute $overline(x)$ and $s$ for the previous measurements.
  + Compute deviation $d = abs(x_("new") - overline(x))$.
  + Compare with $2 s$ (≈ 95% interval) or $3 s$ (≈ 99.7%).
  + Conclusion: $d < 2 s$ $->$ consistent. $d > 3 s$ $->$ not consistent.
]

#example(title: [E25 Q1: Consistency])[
  Previous: 20.1, 20.2, 20.5, 19.8 g. New: 20.6 g.

  #solution()[
    $overline(x) = 20.15$, $s = 0.289$. Deviation $= 0.45 = 1.56 s$. Within $2 s$ $->$ *consistent $->$ A) Yes*.
  ]
]

== Power-law fit

#important[
  $T = A k^alpha$ is *linear in log-log*. Take $log$ of both sides:
  $
    log T = log A + alpha log k
  $
  Plot $log T$ vs $log k$ $->$ the slope is $alpha$, the intercept is $log A$.
]

#note-box()[
  *Quick hand calculation of $alpha$:*
  $
    alpha approx (log T_2 - log T_1) / (log k_2 - log k_1) = log(T_2 / T_1) / log(k_2 / k_1)
  $
  Use the outermost points of the dataset.
]

#example(title: [E25 Q2: Power-law fit])[
  $k = [1.2, 1.5, 2.2, 2.4, 3.4]$, $T = [2.56, 2.29, 1.89, 1.81, 1.52]$.

  #solution()[
    $alpha approx log(1.52/2.56) / log(3.4/1.2) = log(0.594) / log(2.833) = -0.521 / 1.041 approx -0.50$.

    *Answer: E) $alpha = -0.50$*. (Exact linear regression gives $-0.5006$.)
  ]
]

== Exponential fit

$y = A e^(k x)$ is *linear in semi-log on y*:
$
  ln y = ln A + k x
$

== Error Propagation (Gaussian, 1st order)

#definition(title: [Error Propagation])[
  For $f(x_1, ..., x_n)$ with independent uncertainties $sigma_i$:
  $
    sigma_f^2 = sum_(i=1)^n (pdv(f, x_i))^2 sigma_i^2
  $
]

#math-hint(
  )[
  *Special cases:*
  - *Sum/difference:* $f = a + b ==> sigma_f = sqrt(sigma_a^2 + sigma_b^2)$.
  - *Product/quotient:* $f = a b$ or $a / b ==> (sigma_f / f)^2 = (sigma_a/a)^2 + (sigma_b/b)^2$ (relative error).
  - *Power:* $f = a^n ==> sigma_f / f = abs(n) sigma_a / a$.

  *Note:* To find which variable contributes most to the uncertainty, compute $abs(pdv(f, x_i)) sigma_i$ for each $i$ — the largest is the dominant one.
]

#example(
  title: [E24 Q1: Free fall with uncertainty],
)[
  Stone thrown upward from $h = 1.60 plus.minus 0.05$ m with $v_0 = 4.20 plus.minus 0.05$ m/s, $g = 9.82 plus.minus 0.01$ m/s². Find $t$ when the stone hits the ground.

  #solution()[
    $0 = h + v_0 t - 1/2 g t^2$. Positive root: $t = (v_0 + sqrt(v_0^2 + 2 g h)) / g$.

    Insert: $t = (4.20 + sqrt(17.64 + 31.42))/9.82 = (4.20 + 7.004)/9.82 = 1.141$ s.

    Error propagation gives $sigma_t = 0.011$ s. *Answer: I) $1.141 plus.minus 0.011$ s*.

    *Dominant contribution (Q2):* $delta v_0 > delta h > delta g$.
  ]
]

=== Manual error propagation — step by step

#note-box()[
  *Procedure for any $f(x_1, ..., x_n)$:*

  + Write out the formula for $f$ explicitly.
  + For each uncertain variable $x_i$, compute the partial derivative $pdv(f, x_i)$ (treat all other variables as constants).
  + Evaluate each partial derivative at the central values.
  + Compute each term's contribution: $abs(pdv(f, x_i)) dot sigma_i$.
  + Combine in quadrature: $sigma_f = sqrt(sum_i (pdv(f, x_i) dot sigma_i)^2)$.

  *Identifying the dominant term:* compare the individual contributions $abs(pdv(f, x_i)) dot sigma_i$ before squaring — the largest one dominates $sigma_f$.
]

#example(title: [Manual propagation for $t = (v_0 + sqrt(v_0^2 + 2 g h))/g$])[
  Partial derivatives needed: $pdv(t, v_0)$, $pdv(t, h)$, $pdv(t, g)$.

  Let $D = sqrt(v_0^2 + 2 g h)$. Then:
  $
    pdv(t, v_0) = 1/g (1 + v_0/D), quad
    pdv(t, h)   = 1/D, quad
    pdv(t, g)   = -(v_0 + D)/g^2
  $

  Plug in $v_0 = 4.20$, $h = 1.60$, $g = 9.82$, $D = 7.004$:
  $
    pdv(t, v_0) dot sigma_(v_0) = 0.178 dot 0.05 = 0.0089 #text(" s")
  $
  $
    pdv(t, h) dot sigma_h = 0.143 dot 0.05 = 0.0071 #text(" s")
  $
  $
    pdv(t, g) dot sigma_g = 0.116 dot 0.01 = 0.0012 #text(" s")
  $
  $
    sigma_t = sqrt(0.0089^2 + 0.0071^2 + 0.0012^2) = 0.011 #text(" s")
  $

  Dominant: $v_0$ term. Order: $delta v_0 > delta h > delta g$.
]

#pagebreak()

= Kinematics 1D

== Basic Formulas (constant acceleration)

#important[
  The four basic formulas — without time, without distance, etc.:
  $
      & v = v_0 + a t               & quad #text("(without") Delta x #text(")") \
      & Delta x = v_0 t + 1/2 a t^2 & quad #text("(without") v #text(")") \
      & v^2 = v_0^2 + 2 a Delta x   & quad #text("(without") t #text(")") \
      & Delta x = 1/2 (v_0 + v) t   & quad #text("(without") a #text(")")
  $

  *Choose formula based on which variable is missing.*
]

== Free Fall

For vertical motion, $a = -g$ (positive y upward):
$
  y(t) = y_0 + v_0 t - 1/2 g t^2, quad v(t) = v_0 - g t
$

#note-box()[
  *Time to peak (thrown upward):* $t_("top") = v_0 / g$.

  *Maximum height from ground:* $h_max = v_0^2 / (2 g)$.

  *Time in air (lands at same height):* $t_("air") = 2 v_0 / g$.

  *Symmetry:* Rise time = fall time if start and end are at the same height.
]

== Meeting Problem (two objects)

#math-hint(
  )[
  *Trick:* Set up the equation $y_A(t) = y_B(t)$ and solve for $t$. If both have $-1/2 g t^2$, *$g$ cancels* — set the $g$-term aside and solve a linear equation!
]

#example(title: [E25 Q3: Two balls])[
  Ball 1 is thrown upward from the ground with $v_0 = 50$ m/s. Ball 2 is dropped from 100 m above ball 1.

  #solution()[
    $y_1(t) = 50 t - 1/2 g t^2$, $y_2(t) = 100 - 1/2 g t^2$.

    Set equal: $50 t = 100 ==> t = 2$ s. *The gravity terms cancel!*

    $y(2) = 50 dot 2 - 1/2 dot 9.82 dot 4 = 100 - 19.64 = 80.36$ m. *Answer: I) 80.4 m*.
  ]
]

== Reading a Graph

#important[
  *Remember graphical interpretations:*
  + On $x$-$t$ graph: slope = velocity. Curvature (second derivative) = acceleration.
  + On $v$-$t$ graph: slope = acceleration. Area under curve = displacement $Delta x$.
  + On $a$-$t$ graph: area under curve = $Delta v$.

  *Curvature:*
  - Concave up (∪-shape) ($f'' > 0$) $->$ positive acceleration.
  - Concave down (∩-shape) ($f'' < 0$) $->$ negative acceleration.
  - Straight line $->$ constant velocity, $a = 0$.
]

#example(
  title: [Ch 3 P7: Area under v-t],
)[
  #align(
    center,
  )[
    #cetz.canvas(
      length: 1cm,
      {
        import cetz.draw: *

        set-style(axes: (x: (tick: (label: (offset: 0.34)), label: (offset: 1.2), padding: 0)))

        plot.plot(
          size: (7.2, 3.4),
          axis-style: "school-book",
          x-label: [$t$ (s)],
          y-label: [$v$ (m/s)],
          x-min: 0,
          x-max: 8,
          y-min: -5,
          y-max: 10,
          x-tick-step: none,
          y-tick-step: none,
          x-ticks: (1, 2, 3, 4, 5, 6.4, 7, 8),
          y-ticks: (-5, 5, 10),
          {
            plot.add-fill-between(
              ((0, 10), (2, 10), (4, 5), (5, 5), (6.4, 0)),
              ((0, 0), (2, 0), (4, 0), (5, 0), (6.4, 0)),
              style: (fill: blue.lighten(82%), stroke: none),
            )
            plot.add-fill-between(((6.4, 0), (8, -5)), ((6.4, 0), (8, 0)), style: (fill: red.lighten(84%), stroke: none))
            plot.add(
              ((0, 10), (2, 10), (4, 5), (5, 5), (6.4, 0), (8, -5)),
              style: (stroke: rgb("#cc2f2f") + 1.4pt),
              mark: "o",
              mark-size: 0.12,
              mark-style: (fill: rgb("#cc2f2f"), stroke: none),
            )
          },
        )
      },
    )
  ]

  Area from $0$ to $4$ s: triangle + rectangle + triangle
  $
    A = 1/2 dot 2 dot 10 + 2 dot 5 + 1/2 dot 2 dot 5 = 10 + 10 + 5 = 25 #text(" m")
  $

  Negative part from $6$ to $8$ s: $A = 1/2 dot 2 dot (-5) = -5$ m.
]

== Braking Distance (car collision type)

#note-box(
  )[
  *Procedure — "Will they collide?":*

  + Compute braking distance: $Delta x = -v_0^2 / (2 a)$ (final velocity = 0).
  + Compare with available distance $ell$.
  + If $Delta x < ell$ $->$ stops in time. Distance remaining: $L = 2(ell - Delta x)$ (for two cars toward each other).
]

#example(title: [Ch 3 P4: Cars toward each other])[
  Two cars, each with 42.5 m to brake. $v_0 = 88$ km/h $= 24.4$ m/s, $a = -8$ m/s².

  #solution()[
    $Delta x = -24.4^2 / (2 dot (-8)) = 595.36/16 = 37.2$ m. Since $37.2 < 42.5$ $->$ no collision.

    Distance between them after stopping: $L = 2(42.5 - 37.2) = 10.4$ m.
  ]
]

#pagebreak()

= Kinematics 2D — Projectile and Relative Motion

== Projectile Motion (without air resistance)

#important[
  *Key idea:* $x$- and $y$-motion are *independent*.
  $
    x(t) = v_0 cos theta dot t, quad y(t) = y_0 + v_0 sin theta dot t - 1/2 g t^2
  $
  $
    v_x(t) = v_0 cos theta (#text("constant!")), quad v_y(t) = v_0 sin theta - g t
  $
]

#note-box()[
  *Three standard results (only valid if start and end at same height):*

  - *Time in air:* $T = (2 v_0 sin theta) / g$
  - *Height:* $h_max = (v_0^2 sin^2 theta) / (2 g)$
  - *Range:* $R = (v_0^2 sin(2 theta)) / g$

  *Maximum range:* $theta = 45 degree$, $R_max = v_0^2 / g$.

  *Symmetry:* $theta$ and $90 degree - theta$ give the same range (e.g. 30° and 60°).
]

#math-hint()[
  *Speed at a given point:* Use energy conservation from the starting point:
  $
    v^2 = v_0^2 - 2 g (y - y_0)
  $
  *Minimum* speed is at the highest point (only $v_x$ remains).
]

#example(title: [Ch 4 P1: Where is the speed greatest?])[
  Point 1 = starting position (low), Point 2 = peak, Point 3 = below starting height.

  $v^2 = v_0^2 - 2 g (y - y_0)$. Height order: $y_3 < y_1 < y_2$.

  Low y $->$ high speed. So $v_2 < v_1 < v_3$. *Answer: E*.
]

== Parabola Equation (eliminate $t$)

$
  y(x) = tan theta dot x - g/(2 v_0^2 cos^2 theta) x^2
$

Use this form when given $(x, y)$ and need to find $v_0$ or $theta$.

== Angled Throw with Height Difference

#note-box()[
  *Procedure — Throw from tower (E24 Ch 4 P4):*

  + Vertical motion (start at 0, end at $-H$):
    $y(T) = -H = -1/2 g T^2 ==> H = 1/2 g T^2$.

  + Horizontal motion: $L = v_0 T$.

  + If you have the angle $theta$ between the line from A to B and the horizontal:
    $tan theta = H/L = (g T)/(2 v_0)$.

  + Isolate $v_0 = (g T)/(2 tan theta)$.
]

== Relative Motion (1D)

#definition(title: [Relative velocities, 1D])[
  $
    v_(A "wrt" C) = v_(A "wrt" B) + v_(B "wrt" C)
  $

  *Vectors in 2D:* same formula, just as vectors.
]

#example(
  title: [E25 Q4: Boat and river],
)[
  Boat's speed in water $= v$, water's speed $= v_0$. Time with the current to travel distance $L$: $T$. Time against the current: $2 T$.

  #solution()[
    With current: $L = (v + v_0) T$. Against current: $L = (v - v_0) dot 2 T$.

    Set equal: $v + v_0 = 2(v - v_0) ==> v = 3 v_0$. *Answer: B*.
  ]
]

#math-hint(
  )[
  *Symbolic answer — no numbers!* When the answer should be a ratio (here $v$ expressed in $v_0$), there is NO numerical calculation. Find the equation, do symbolic algebra.
]

== Circular Motion

#important[
  *Angular velocity:* $omega = v/r = (2 pi)/T$.

  *Converting rpm $arrow.r$ rad/s:* $omega = "rpm" dot 2 pi / 60$.

  *Centripetal acceleration:* $a_c = v^2/r = omega^2 r$ (points radially inward).
]

#example(title: [E25 Q6: Centrifuge])[
  10000 rpm, $a_c = 8500 g$. Find radius.

  #solution()[
    $omega = 10000 dot 2 pi / 60 = 1047$ rad/s.

    $r = a_c / omega^2 = 8500 dot 9.82 / 1047^2 = 0.076$ m $= 7.6$ cm. *Answer: C*.
  ]
]

== Vertical and Horizontal Components of Acceleration (qualitative)

#note-box()[
  *Horizontal motion with changing speed:*
  - *$va(a)$ parallel to $va(v)$:* only speed changes, no turning.
  - *$va(a)$ anti-parallel to $va(v)$:* deceleration, no turning.
  - *$va(a)$ perpendicular to $va(v)$:* pure turning, constant speed.
  - *$va(a)$ at an angle:* both speed and direction change.

  *E24 Q4:* The car turns if $va(a)$ has a component *perpendicular* to $va(v)$ $->$ answers C, D, E, F.
]

== Bird-dive style problem (E25 Q5)

// Helper: draw one a_y vs t panel
// ox, oy = canvas origin of this panel
// label = "A".."H"
// curve-fn = function that takes draw context and draws the curve
#let panel(ox, oy, label, draw-curve) = {
  import cetz.draw: *
  let w = 3.8
  let h = 3.0
  let mx = 0.5 // x margin before axis
  let my = 0.6 // y margin below axis

  group({
    translate((ox, oy))

    // y-axis (a_y)
    line((mx, my), (mx, my + h), mark: (end: ">", size: 0.18), stroke: black + 1pt)
    content((mx - 0.15, my + h), [$a_y$], anchor: "east")

    // x-axis (t)
    line((mx, my + h * 0.5), (mx + w, my + h * 0.5), mark: (end: ">", size: 0.18), stroke: black + 1pt)
    content((mx + w + 0.05, my + h * 0.5 - 0.05), [$t$], anchor: "north-west")

    // panel label (top-left inside)
    content((mx + 0.25, my + h - 0.15), [*#label*], anchor: "north-west")

    // curve (drawn in local coords where zero = axis midline)
    // axis zero is at (mx, my + h*0.5)
    draw-curve(mx, my + h * 0.5, w)
  })
}

#cetz.canvas(
  {
    import cetz.draw: *

    let blue = rgb("#4ea8d2")
    let sty = (stroke: blue + 1.5pt)

    // --- Curve definitions ---
    // Each gets (x0, y0, w) where x0,y0 is the axis zero point, w is plot width

    // A: single positive pulse
    let curveA = (x0, y0, w) => {
      catmull(
        (x0 + 0.3, y0),
        (x0 + 0.7, y0),
        (x0 + 1.1, y0 + 0.85),
        (x0 + 1.5, y0),
        (x0 + 1.9, y0),
        (x0 + w - 0.2, y0),
        tension: 0.5,
        ..sty,
      )
    }

    // B: single negative pulse
    let curveB = (x0, y0, w) => {
      catmull((x0 + 0.3, y0), (x0 + 0.8, y0), (x0 + 1.3, y0 - 0.95), (x0 + 1.8, y0), (x0 + w - 0.2, y0), tension: 0.5, ..sty)
    }

    // C: negative pulse then positive pulse (CORRECT: 0 → neg → pos → 0)
    let curveC = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0),
        (x0 + 0.5, y0),
        (x0 + 0.9, y0 - 0.75),
        (x0 + 1.3, y0),
        (x0 + 1.7, y0 + 0.6),
        (x0 + 2.1, y0),
        (x0 + w - 0.2, y0),
        tension: 0.5,
        ..sty,
      )
    }

    // D: positive pulse then negative pulse (reversed order)
    let curveD = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0),
        (x0 + 0.5, y0),
        (x0 + 0.9, y0 + 0.6),
        (x0 + 1.3, y0),
        (x0 + 1.7, y0 - 0.75),
        (x0 + 2.1, y0),
        (x0 + w - 0.2, y0),
        tension: 0.5,
        ..sty,
      )
    }

    // E: step up (0 → positive constant)
    let curveE = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0),
        (x0 + 0.8, y0),
        (x0 + 1.2, y0 + 0.7),
        (x0 + 1.6, y0 + 0.82),
        (x0 + w - 0.2, y0 + 0.82),
        tension: 0.5,
        ..sty,
      )
    }

    // F: step down (0 → negative constant)
    let curveF = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0),
        (x0 + 0.8, y0),
        (x0 + 1.2, y0 - 0.7),
        (x0 + 1.6, y0 - 0.82),
        (x0 + w - 0.2, y0 - 0.82),
        tension: 0.5,
        ..sty,
      )
    }

    // G: positive constant then step down to 0
    let curveG = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0 + 0.82),
        (x0 + 0.8, y0 + 0.82),
        (x0 + 1.3, y0 + 0.82),
        (x0 + 1.7, y0 + 0.3),
        (x0 + 2.1, y0),
        (x0 + w - 0.2, y0),
        tension: 0.5,
        ..sty,
      )
    }

    // H: negative constant then step up to 0
    let curveH = (x0, y0, w) => {
      catmull(
        (x0 + 0.2, y0 - 0.82),
        (x0 + 0.8, y0 - 0.82),
        (x0 + 1.3, y0 - 0.82),
        (x0 + 1.7, y0 - 0.3),
        (x0 + 2.1, y0),
        (x0 + w - 0.2, y0),
        tension: 0.5,
        ..sty,
      )
    }

    // Layout: 4 columns × 2 rows, col spacing = 4.5, row spacing = 4.2
    let cs = 4.5
    let rs = 4.2

    panel(0 * cs, 1 * rs, "A", curveA)
    panel(1 * cs, 1 * rs, "B", curveB)
    panel(2 * cs, 1 * rs, "C", curveC)
    panel(3 * cs, 1 * rs, "D", curveD)
    panel(0 * cs, 0 * rs, "E", curveE)
    panel(1 * cs, 0 * rs, "F", curveF)
    panel(2 * cs, 0 * rs, "G", curveG)
    panel(3 * cs, 0 * rs, "H", curveH)
  },
)

#note-box()[
  *Bird flying horizontally high, dives, then horizontal low:*

  - Phase 1 (horizontal above): $a_y = 0$ (lift balances gravity).
  - Phase 2 (begins dive): $v_y$ goes from 0 to negative $->$ $a_y < 0$ (negative pulse).
  - Phase 3 (levels off): $v_y$ goes from negative to 0 $->$ $a_y > 0$ (positive pulse).
  - Phase 4 (horizontal below): $a_y = 0$ again.

  *Pattern:* $0 -> "neg" -> "pos" -> 0$. Order matters — negative comes BEFORE positive.
]

#pagebreak()

= Newton's Laws and Forces

== The Three Newton's Laws

#definition(
  title: [Newton's Laws],
)[
  *N1 (inertia):* An object continues with constant $va(v)$ unless net force $sum va(F) eq.not 0$.

  *N2:* $sum va(F) = m va(a)$ (vectorial, one component at a time).

  *N3 (action-reaction):* If A exerts force $va(F)_(A "on" B)$ on B, then B exerts force $-va(F)_(A "on" B)$ on A.
]

#important[
  *N3 trap:* Action-reaction pairs act on *different* objects. They *never cancel* each other in the same FBD.
]

== Free Body Diagram (FBD) — the ONLY important step

#important[
  *Procedure for ANY force problem:*

  + *Choose the object* — which body are you analyzing?
  + *Draw it isolated* (a simple box).
  + *Draw only the forces acting ON the object:*
    - Gravity: always, downward.
    - Normal force: for each contact surface, perpendicular away from the surface.
    - Friction: for each rough contact surface, parallel to the surface.
    - Tension: along any rope attached.
    - Applied forces: arrow in the given direction.

  + *Choose a coordinate system* matching the problem (incline $->$ x along the plane).
  + *Write Newton's 2nd law* for each axis separately.
]

#note-box(
  )[
  *Counting forces in stacked systems (E24 Q8-Q10):*

  For each object: 1 gravity + 1 normal/contact pair per contact surface + 1 friction per rough contact surface + applied forces.

  *Checklist — N3 pairs:* Each contact force on A from B has a partner force on B from A. If you can't find the partner, you *missed* a force.
]

== Static vs Kinetic Friction

#definition(title: [Two friction regimes])[
  *Static friction* — object is not sliding:
  $
    f_s <= mu_s N quad (#text("inequality — only as large as needed to prevent motion"))
  $

  *Kinetic friction* — object is already sliding:
  $
    f_k = mu_k N quad (#text("fixed magnitude, opposes direction of motion"))
  $

  Always $mu_k < mu_s$: it takes more force to start sliding than to keep sliding.
]

#important[
  *Decision procedure:*

  + *Check if static friction can hold:* compute the force needed to keep the object stationary. If $F_("needed") <= mu_s N$ $->$ no sliding, use $f_s = F_("needed")$.
  + *If it exceeds $mu_s N$:* sliding occurs. Switch to $f_k = mu_k N$ and apply Newton's 2nd law.
  + *Never use $mu_s$ once the object is moving.* Always $mu_k$ during motion.

  *On an incline:* block stays put if $tan theta <= mu_s$. Once sliding, $a = g(sin theta - mu_k cos theta)$.
]

#math-hint()[
  *Common exam trap:* the problem gives both $mu_s$ and $mu_k$. You must first *check* whether the object slips (static test), then use the correct coefficient. Using $mu_s$ in a dynamic situation or $mu_k$ before checking for slip are the two most common errors.
]

== Stacked Blocks with Force on the Middle One (E24 Q7-Q10)

#align(center)[
  #cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    set-style(rect: (stroke: rgb("#2d3748") + 0.9pt, fill: rgb("#edf2f7")), content: (padding: 0.08))

    let w_3 = 2.25
    let w_2 = 1.75
    let w_1 = 1.00
    let h = 0.72

    line((-0.55, 0), (w_3 + 2.7, 0), stroke: rgb("#4a5568") + 0.9pt)
    for x in range(-1, 10) {
      line((x * 0.45 - 0.25, 0), (x * 0.45 - 0.05, -0.18), stroke: gray + 0.45pt)
    }

    rect((0, 0), (0 + w_3, h), name: "m3")
    rect((2, h), (-1.5 + w_2, 2 * h), name: "m2")
    rect((1.7, 2 * h), (-0.5 + w_1, 3 * h), name: "m1")

    content("m1.center", [$m_1$])
    content("m2.center", [$m_2$])
    content("m3.center", [$m_3$])

    line("m2.east", (w_2 + 1.65, 1.5 * h), stroke: rgb("#cc2f2f") + 1.3pt, mark: (end: ">"))
    content((w_1 + 1.78, 2 * h), [$va(F)$], anchor: "west")
  })
]

#example(title: [E24 Q8-Q10: Forces on each link])[
  Three stacked blocks, F applied to *middle* (m₂):

  *Top block (m₁):* 3 forces
  - gravity $m_1 g$ (downward)
  - normal $n_(2 "on" 1)$ (upward from m₂)
  - friction $f_(2 "on" 1)$ (horizontal, forward — this is what accelerates m₁)

  *Middle block (m₂):* 6 forces
  - gravity $m_2 g$ (downward)
  - normal $n_(3 "on" 2)$ (upward from m₃)
  - normal $n_(1 "on" 2)$ (downward from m₁ — N3 partner to $n_(2 "on" 1)$)
  - friction $f_(1 "on" 2)$ (backward — N3 to $f_(2 "on" 1)$)
  - friction $f_(3 "on" 2)$ (horizontal — from m₃)
  - applied force $F$ (horizontal)

  *Bottom block (m₃):* 5 forces
  - gravity $m_3 g$ (downward)
  - normal from floor (upward)
  - normal $n_(2 "on" 3)$ (downward from m₂)
  - friction $f_(2 "on" 3)$ (horizontal forward — N3 to $f_(3 "on" 2)$)
  - friction from floor (backward — opposite to motion)
]

#math-hint(
  )[
  *General rule:* Per contact surface there is ALWAYS an N3 pair (normal + normal) and *possibly* an N3 pair (friction + friction). Count contact surfaces on the object $->$ 2 (normal+friction) times that number.
]

== Block on Inclined Plane

#cetz.canvas({
  import cetz.draw: *

  let theta = 30deg // incline angle

  // ── Geometry constants ──────────────────────────────────────────
  let base = 6.0 // horizontal base length
  let height = base * calc.tan(theta) // = base * tan(30°)

  // Key world-space points
  let O = (0, 0) // bottom-left corner
  let Br = (base, 0) // bottom-right corner
  let T = (base, height) // top of incline (right angle at Br)

  // Block sits at ~60% along the slope from O
  let t_block = 0.58
  let bx = base * t_block
  let by = height * t_block
  let block_pos = (bx, by) // bottom-centre of block (on the slope)

  // ── Filled inclined plane ────────────────────────────────────────
  line(O, Br, T, O, fill: rgb("#d9e8f5"), stroke: black + 1.2pt, close: true)

  // ── Right-angle marker at bottom-right ───────────────────────────
  let sq = 0.22
  line((base - sq, 0), (base - sq, sq), (base, sq), stroke: black + 0.8pt)

  // ── Theta arc and label ──────────────────────────────────────────
  arc((1, 0), start: 0deg, stop: theta, radius: 1, stroke: black + 0.9pt, name: "arc")
  content((0.70, 0.18), [$30°$])

  // ── Block (drawn in tilted coordinate scope) ─────────────────────
  let bw = 0.55 // block half-width along slope
  let bh = 0.55 // block half-height perp to slope

  scope({
    translate(block_pos)
    rotate(theta)
    rect((-bw, 0), (bw, bh), fill: rgb("#f0c060"), stroke: black + 1.2pt, name: "blk")
    content((0, bh / 2), [$m$])
  })

  // ── Direction unit vectors ────────────────────────────────────────
  let xd = (-calc.cos(theta), -calc.sin(theta)) // down the slope
  let yd = (-calc.sin(theta), calc.cos(theta)) // perp, away from surface
  let neg_yd = (calc.sin(theta), -calc.cos(theta)) // into the surface

  // ── All vectors originate from block centre ───────────────────────
  let ax_orig = (block_pos.at(0) + (bh / 2) * yd.at(0), block_pos.at(1) + (bh / 2) * yd.at(1))

  // ── Tilted coordinate axes ────────────────────────────────────────
  let ax_len = 1.4
  let x_tip = (ax_orig.at(0) + ax_len * xd.at(0), ax_orig.at(1) + ax_len * xd.at(1))
  let y_tip = (ax_orig.at(0) + ax_len * yd.at(0), ax_orig.at(1) + ax_len * yd.at(1))

  set-style(stroke: rgb("#c0392b") + 1pt)
  line(ax_orig, x_tip, mark: (end: ">", size: 0.18))
  line(ax_orig, y_tip, mark: (end: ">", size: 0.18))
  content((x_tip.at(0) - 0.12, x_tip.at(1) - 0.22), [$x$], stroke: none, fill: rgb("#c0392b"))
  content((y_tip.at(0) - 0.28, y_tip.at(1) + 0.05), [$y$], stroke: none, fill: rgb("#c0392b"))

  // ── Gravity vector (straight down from block centre) ─────────────
  let g_len = 1.8
  let g_tip = (ax_orig.at(0), ax_orig.at(1) - g_len)

  set-style(stroke: rgb("#27ae60") + 1.5pt)
  line(ax_orig, g_tip, mark: (end: ">", size: 0.2), name: "gvec")
  content((g_tip.at(0) + 0.25, g_tip.at(1) + 0.1), [$m g$], stroke: none, fill: rgb("#27ae60"))

  // ── Components ────────────────────────────────────────────────────
  let sin_comp = g_len * calc.sin(theta)
  let cos_comp = g_len * calc.cos(theta)

  let sin_tip = (ax_orig.at(0) + sin_comp * xd.at(0), ax_orig.at(1) + sin_comp * xd.at(1))
  let cos_tip = (ax_orig.at(0) + cos_comp * neg_yd.at(0), ax_orig.at(1) + cos_comp * neg_yd.at(1))

  // Dashed construction lines
  set-style(stroke: (paint: gray, dash: "dashed", thickness: 0.7pt))
  line(g_tip, sin_tip)
  line(g_tip, cos_tip)

  // sin component arrow
  set-style(stroke: rgb("#8e44ad") + 1.5pt)
  line(ax_orig, sin_tip, mark: (end: ">", size: 0.18))
  content((sin_tip.at(0) - 0.05, sin_tip.at(1) - 0.32), [$m g sin(30°)$], stroke: none, fill: rgb("#8e44ad"))

  // cos component arrow
  set-style(stroke: rgb("#e67e22") + 1.5pt)
  line(ax_orig, cos_tip, mark: (end: ">", size: 0.18))
  content((cos_tip.at(0) + 0.75, cos_tip.at(1) + 0.1), [$m g cos(30°)$], stroke: none, fill: rgb("#e67e22"))
})

#important[
  *Standard results for block on inclined plane, angle $theta$:*

  Gravity components:
  - Along plane (downward): $m g sin theta$
  - Perpendicular to plane (into plane): $m g cos theta$

  Normal force: $n = m g cos theta$.

  Friction coefficient and sliding:
  - *Does NOT slide* if $tan theta <= mu_s$.
  - *Slides* and accelerates: $a = g(sin theta - mu_k cos theta)$.
]

#example(title: [Ch 6 P1: Block pulled with angled force])[
  Block on rough horizontal surface, force $F$ at angle $theta$ above horizontal, $mu_k$.

  #solution()[
    *FBD:* gravity $m g$ (down), normal $n$ (up), applied $F$ (angled up), friction $f_k$ (backward).

    N2(y): $n + F sin theta - m g = 0 ==> n = m g - F sin theta$.

    *Note:* $n eq.not m g$ — the vertical component of the force reduces the normal force!

    N2(x): $m a = F cos theta - mu_k n = F cos theta - mu_k (m g - F sin theta)$
    $
      a = F/m (cos theta + mu_k sin theta) - mu_k g
    $

    *Constant speed:* set $a = 0$ and isolate $F$:
    $
      F = (mu_k m g)/(cos theta + mu_k sin theta)
    $

    *Optimal angle:* Differentiate the denominator w.r.t. $theta$ and set $= 0$:
    $
      -sin theta + mu_k cos theta = 0 ==> tan theta = mu_k
    $
    This is the angle where the pull is *smallest*.
  ]
]

== Atwood and Atwood-on-Incline

#align(center)[
  #cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let theta = 30deg
    let base = 5.8
    let height = base * calc.tan(theta)
    let O = (0, 0)
    let Br = (base, 0)
    let T = (base, height)

    let u = (calc.cos(theta), calc.sin(theta))
    let n = (-calc.sin(theta), calc.cos(theta))
    let along(t) = (base * t, height * t)
    let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
    let mul(s, p) = (s * p.at(0), s * p.at(1))

    line(O, Br, T, O, close: true, fill: rgb("#d9e8f5"), stroke: black + 1.1pt)
    arc((0.9, 0), start: 0deg, stop: theta, radius: 0.85, stroke: black + 0.8pt)
    content((0.72, 0.16), [$30 degree$])

    let block-base = along(0.55)
    let bw = 0.48
    let bh = 0.52
    let block-center = add(block-base, mul(bh / 2, n))
    let block-top-uphill = add(add(block-base, mul(bw, u)), mul(bh, n))

    scope({
      translate(block-base)
      rotate(theta)
      rect((-bw, 0), (bw, bh), fill: rgb("#f0c060"), stroke: black + 1.1pt, name: "block-M")
      content((0, bh / 2), [$M$])
    })

    let pulley-r = 0.34
    let pulley-c = add(T, mul(0.54, n))
    let pulley-slope = add(pulley-c, mul(-pulley-r, n))
    let pulley-right = add(pulley-c, (pulley-r, 0))
    let hang-top = add(pulley-right, (0, -1.25))
    let hang-w = 0.72
    let hang-h = 0.72

    line(block-top-uphill, pulley-slope, stroke: rgb("#2d3748") + 1pt)
    line(pulley-right, hang-top, stroke: rgb("#2d3748") + 1pt)
    circle(pulley-c, radius: pulley-r, fill: white, stroke: black + 1.1pt)
    circle(pulley-c, radius: 0.05, fill: black, stroke: none)
    line(add(pulley-c, (0, pulley-r)), add(pulley-c, (0.45, pulley-r + 0.4)), stroke: black + 0.8pt)
    line(add(pulley-c, (0.45, pulley-r + 0.4)), add(pulley-c, (0.85, pulley-r + 0.4)), stroke: black + 0.8pt)

    rect(
      (hang-top.at(0) - hang-w / 2, hang-top.at(1) - hang-h),
      (hang-top.at(0) + hang-w / 2, hang-top.at(1)),
      fill: rgb("#edf2f7"),
      stroke: black + 1.1pt,
      name: "block-m",
    )
    content("block-m.center", [$m$])

    line(block-center, add(block-center, mul(0.95, u)), stroke: rgb("#cc2f2f") + 1.1pt, mark: (end: ">"))
    content(add(block-center, mul(1.08, u)), [$S$], anchor: "west")
    line(
      (hang-top.at(0), hang-top.at(1) - hang-h / 2),
      (hang-top.at(0), hang-top.at(1) - hang-h / 2 + 0.85),
      stroke: rgb("#cc2f2f") + 1.1pt,
      mark: (end: ">"),
    )
    content((hang-top.at(0) + 0.18, hang-top.at(1) - hang-h / 2 + 0.55), [$S$], anchor: "west")
  })
]

#note-box()[
  *Procedure for coupled systems:*

  + *Assume common acceleration $a$* — blocks connected by rigid string have the same $|a|$.
  + *Draw FBD for EACH block separately.* Each block has its own tension arrow.
  + *N3:* tensions are equal at both ends (massless string, massless pulley).
  + *Write N2 for each block* (only along the direction of motion).
  + *Add the equations* — tension cancels, and you can isolate $a$.
]

#example(
  title: [Ch 6 P5: Atwood on incline, with friction],
)[
  Block $M$ on inclined plane (angle $theta$, rough, $mu_k$), connected by string over pulley to hanging block $m$.

  #solution(
    )[
    N2($M$, along plane, up is positive): $M a = M g sin theta - S - mu_k M g cos theta$

    N2($m$, vertical, down is positive for m): $m a = m g - S$

    *Note on signs:* if $M$ slides up along the plane, then $m$ moves downward — so the signs are consistent with one acceleration $a$.

    *Add:* $(M + m) a = M g sin theta - mu_k M g cos theta - m g$

    $
      a = g (M(sin theta - mu_k cos theta) - m) / (M + m)
    $

    *Extreme check:* $mu_k = 0, theta = 90 degree$: $a = g(M - m)/(M+m)$ — classic Atwood. ✓
  ]
]

== Circular Motion: Force Toward Center

#important[
  *Newton's 2nd law in the radial direction:* $sum F_("radially inward") = m v^2 / r = m omega^2 r$.

  Which force provides the centripetal force depends on the setup:
  - *Car in curve:* static friction.
  - *Banked curve (without friction):* horizontal component of normal force. $tan theta = v^2/(g r)$.
  - *Vertical curve (top of loop):* gravity + normal.
  - *Vertical pendulum:* tension.
  - *Conical pendulum:* horizontal component of tension.
]

#example(
  title: [Ch 6 P8: Coin on rotating disk],
)[
  Coin at distance $R/2$ from center. Static friction $mu_s$ is the only horizontal force. Find $T$ (period) when the coin begins to slide.

  #solution()[
    Sliding condition: $f_s = mu_s m g$ (max static friction).

    Centripetal force: $m omega^2 (R/2) = mu_s m g$ with $omega = 2 pi / T$:
    $
      m (2 pi / T)^2 (R/2) = mu_s m g ==> T = 2 pi sqrt(R / (2 mu_s g))
    $

    *Answer: A*. Mass cancels — the coin begins to slide at the same $T$ regardless of mass.
  ]
]

== Tension in Pendulum at Angle $theta$

// TODO: Draw a vertically hanging pendulum (mass m at end of string of length R), then the same pendulum at angle theta from vertical, with vectors for gravity, tension T, and an arrow for v at the bottom.

#important[
  *Pendulum with speed $v_0$ at bottom, find tension at angle $theta$ from vertical:*

  + *Energy conservation:* $v^2 = v_0^2 - 2 g R (1 - cos theta)$.
  + *Newton in radial direction:* $T - m g cos theta = m v^2 / R$.

  $
    T = m v^2 / R + m g cos theta
  $

  *Special cases:*
  - $theta = 0 degree$ (bottom): $T = m v^2/R + m g$ (max).
  - $theta = 90 degree$ (horizontal): $T = m v^2/R$ (gravity perpendicular to string).
  - $theta = 180 degree$ (top): $T = m v^2/R - m g$. Minimum speed to complete: $v_("top") = sqrt(g R)$ $->$ $T = 0$.
]

#example(title: [E25 Q9: Pendulum tension])[
  $R = 1.00$ m, $m = 1.00$ kg, $v_0 = 10.0$ m/s at the bottom. Find $T$ at $theta = 90 degree$.

  #solution()[
    $v^2 = 100 - 2 dot 9.82 dot 1 = 80.36$ m²/s².

    $T = m v^2 / R + 0 = 1.0 dot 80.36 / 1.0 = 80.4$ N. *Answer: F*.

    *Hint:* At $theta = 90 degree$ gravity is perpendicular to the string — it gives no radial contribution.
  ]
]

== Friction from Deceleration

#math-hint(
  )[
  *Classic trick:* If an object decelerates solely due to friction on a horizontal surface, and you have the $v(t)$ graph:
  $
    abs(a) = abs(Delta v / Delta t) ==> mu_k = abs(a) / g
  $
  *Mass cancels out!* No need to know the mass.
]

#example(title: [E25 Q8: Curling stone])[
  Read from graph: $v$ drops from 2 m/s to 0 over approx. 20 s.

  $a = 2/20 = 0.1$ m/s². $mu_k = 0.1/9.82 = 0.010$. *Answer: A) $mu_k approx 0.01$*.
]

#pagebreak()

= Equation of Motion (ODE-integration)

== Linear Air Resistance

#definition(title: [1D fall with linear drag])[
  $
    m dot.double(y) = -m g - b dot(y)
  $

  Terminal velocity (when $dot.double(y) = 0$, $dot(y) = -v_t$):
  $
    v_t = m g / b
  $

  Time constant: $tau = m/b$.
]

#note-box()[
  *Characteristic forms:*
  - $v(t)$: starts at 0, grows asymptotically to $-v_t$. Form: $v(t) = -v_t(1 - e^(-t/tau))$.
  - $a(t)$: starts at $-g$, goes asymptotically to 0. Form: $a(t) = -g e^(-t/tau)$.
  - $y(t)$: approximately linear for $t >> tau$ (terminal velocity).
]

== Quadratic Air Resistance

$
  m dot.double(y) = -m g - c dot(y) abs(dot(y)) ==> v_t = sqrt(m g / c)
$

== Numerical Solution (SciPy)

#math-hint()[
*In practice at exam:* Use `solve_ivp`:
```python
  from scipy.integrate import solve_ivp
  def rhs(t, y):
      x, v = y
      a = F(t, x, v) / m
      return [v, a]
  sol = solve_ivp(rhs, [0, t_max], [x0, v0], t_eval=...)
  ```
]

#pagebreak()

= Work and Energy

== Definitions

#definition(title: [Work and energy])[
  *Kinetic energy:* $K = 1/2 m v^2$.

  *Work of constant force:* $W = va(F) dot va(d) = F d cos theta$.

  *Work of variable force (1D):* $W = integral_(x_1)^(x_2) F(x) dd(x)$.

  *Work-energy theorem:* $W_("net") = Delta K = K_2 - K_1$.

  *Power:* $P = (dd(W))/(dd(t)) = va(F) dot va(v)$.
]

#important[
  *Sign of work:*
  - Force in direction of motion: $W > 0$.
  - Force perpendicular to motion: $W = 0$ (e.g. normal force, magnetic force).
  - Force opposite to motion: $W < 0$ (e.g. kinetic friction).
]

== Potential Energy

$
  U_("grav") = m g h (#text("ref. at chosen zero point")), quad U_("spring") = 1/2 k x^2 (#text("from equilibrium"))
$

Conservative force: $F = -(dd(U))/(dd(x))$.

== Power — Functional Form

#example(title: [Ch 7 P1: Power of constant force])[
  Constant $F$ pulls resting block. How does $P(t)$ look?

  #solution()[
    $a = F/m$ constant ==> $v(t) = (F/m) t$ (linear).

    $P = F v = (F^2/m) t$ — *linear* in $t$. *Answer: A*.
  ]
]

#math-hint()[
  *Remember:* For constant force $->$ $v prop t$ $->$ $P prop t$. For constant power $->$ $v prop sqrt(t)$.
]

== Work-energy on a Complex Path

#note-box()[
  *Procedure — "Find speed after X distance":*

  + List all forces that do work (gravity, friction, applied $F$).
  + Use $W_("net") = Delta K = 1/2 m v_f^2 - 1/2 m v_i^2$.
  + Specifically: $W_("friction") = -mu_k n dot d$ (negative!).
]

#example(
  title: [Ch 7 P2: Block with angled force],
)[
  Block $m$ pulled with force $F$ at angle $theta$. Find speed after length $L$ from rest.

  #solution(
    )[
    *Smooth surface:* Only $F$ does work.
    $W = F cos theta dot L = 1/2 m v^2 ==> v = sqrt((2 F cos theta L) / m)$.

    *Rough surface:* $W_F + W_("friction") = 1/2 m v^2$ with $f_k = mu_k n = mu_k (m g - F sin theta)$ (as in Ch 6 P1!).
    $
      v = sqrt((2(F(cos theta + mu_k sin theta) - mu_k m g) L)/m)
    $
  ]
]

== Work scaling-problem (E25 Q13)

#math-hint()[
  *Standard result:* Constant force from rest, distance $d$ in time $t$:
  $
    d = 1/2 a t^2 ==> a = 2 d / t^2 ==> F = m a, quad W = F d = (2 m d^2)/t^2
  $

  *Scaling:* For same $d$ but $t arrow.r 3 t$, we have $W arrow.r W/9$.

  *In general:* $W prop 1/t^2$ at constant $d$.
]

== Spring + Smooth Incline + Friction (classic exam)

#example(
  title: [Ch 7 P4: Hill + rough surface + spring],
)[
  Block $m = 5$ kg starts on upper platform with $v_1 = 5$ m/s, falls height $h = 12$ m, arrives with $v_2 = 10$ m/s. Slides $ell = 9.5$ m on rough surface ($mu_k = 0.35$), then hits spring ($k = 1000$ N/m), compresses distance $d$.

  #solution(
    )[
    *a) Work of friction from 1 to 2:* Use energy conservation between 1 and 2:
    $
      1/2 m v_1^2 + m g h + W_("friction") = 1/2 m v_2^2
    $
    $
      W_("friction") = 1/2 m (v_2^2 - v_1^2) - m g h = 1/2 dot 5 dot (100 - 25) - 5 dot 9.82 dot 12 = 187.5 - 589.2 = -401.7 #text(" J")
    $

    *b) Speed $v_3$ before spring:* Between 2 and 3, no height difference, only friction:
    $
      1/2 m v_3^2 = 1/2 m v_2^2 - mu_k m g ell
    $
    $
      v_3 = sqrt(v_2^2 - 2 mu_k g ell) = sqrt(100 - 2 dot 0.35 dot 9.82 dot 9.5) = sqrt(34.7) = 5.89 #text(" m/s")
    $

    *c) Max compression $d$:* From 3 to max compression (block stops). Friction works over entire $d$:
    $
      0 = 1/2 m v_3^2 - 1/2 k d^2 - mu_k m g d
    $
    $
      1/2 k d^2 + mu_k m g d - 1/2 m v_3^2 = 0
    $
    Quadratic equation in $d$. Insert and solve: $d approx 0.400$ m.
  ]
]

#pagebreak()

= Conservation of Energy

== Conservation Principle

#important[
  $
    K_1 + U_1 + W_("non-cons.") = K_2 + U_2
  $

  Where $W_("non-cons.")$ is the work done by non-conservative forces (friction, drag, externally applied) on the system (negative for friction).

  *Conservative forces:* gravity, spring, electrical (without resistance).
  *Non-conservative:* friction, air resistance, normally applied "push".
]

== Height-Speed Formulas

$
  v = sqrt(2 g h) #text(" (start from rest, fall height h)")
$
$
  v^2 = v_0^2 - 2 g Delta h #text(" (Δh = rise, negative for descent)")
$

== Loop-the-loop

Minimum speed at top of vertical loop: $v_("top") = sqrt(g R)$.
Minimum speed at bottom: $v_("bottom") = sqrt(5 g R)$ (energy conservation from bottom to top, $Delta h = 2R$).

#math-hint(
  )[
  *Classic block-from-ramp-to-loop:* Minimum starting height to complete loop with radius $R$:
  $
    h_("min") = 2.5 R = 5R/2
  $
  *Proof:* Energy conservation from start (rest at height $h$) to top of loop (height $2R$, speed $v_("top") = sqrt(g R)$):
  $m g h = m g (2R) + 1/2 m (g R) ==> h = 2 R + R/2 = 5R/2$. ✓
]

== Spring Mode

$
  1/2 k x^2 = 1/2 m v^2 #text("    or    ") 1/2 k x^2 = m g h
$

#math-hint()[
  *Important:* When a block is launched by a compressed spring (without friction): $v = x sqrt(k/m)$.
]

== Pendulum Energy

Height above bottom at angle $theta$ from vertical:
$
  h = R(1 - cos theta)
$

#math-hint()[
  *Not* $R sin theta$ or $R cos theta$ — it is $R(1 - cos theta)$!

  *Limit check:*
  - $theta = 0$: $h = R(1-1) = 0$ ✓
  - $theta = 90 degree$: $h = R(1-0) = R$ ✓
  - $theta = 180 degree$: $h = R(1-(-1)) = 2R$ ✓
]

== Drawing $E_m(t)$ (E25 Q14)

#cetz.canvas({
  import cetz.draw: *

  let blue = rgb("#3a6ea5")
  let sty = (stroke: blue + 1.8pt)

  let panel(ox, oy, label, draw-curve) = {
    let w = 3.8
    let h = 3.0
    let mx = 0.7
    let my = 0.5

    group({
      translate((ox, oy))

      // axes
      line((mx, my), (mx, my + h), mark: (end: ">", size: 0.18), stroke: black + 1pt)
      line((mx, my), (mx + w, my), mark: (end: ">", size: 0.18), stroke: black + 1pt)

      // axis labels
      content((mx - 0.15, my + h), [$E_m$], anchor: "east")
      content((mx + w + 0.05, my - 0.05), [$t$], anchor: "north-west")

      // panel label
      content((mx + 0.25, my + 0.35), [*#label*], anchor: "south-west")

      draw-curve(mx, my, w, h)
    })
  }

  // Each curve gets (mx, my, w, h) — plot in those local coords
  // y values are offsets from my; typical Em range mapped to ~0.4*h .. 0.85*h

  // A: rises slightly then two linear drops with a kink (zigzag down)
  let curveA = (mx, my, w, h) => {
    catmull(
      (mx, my + 2 * 0.88),
      (mx + 1, my + h * 0.88),
      (mx + 2.3, my + h * 0.42),
      (mx + 3.2, my + h * 0.42),
      tension: 1,
      ..sty,
    )
  }

  // B: flat high, sharp drop, flat low
  let curveB = (mx, my, w, h) => {
    catmull(
      (mx + 0, my + h * 0.62),
      (mx + 1.0, my + h * 0.82),
      (mx + 1.0, my + h * 0.70),
      (mx + 2.1, my + h * 0.30),
      (mx + 3.2, my + h * 0.30),
      tension: 1,
      ..sty,
    )
  }

  // C: flat high, long smooth ramp down, flat low
  let curveC = (mx, my, w, h) => {
    catmull(
      (mx + 0, my + h * 0.85),
      (mx + 0.8, my + h * 0.85),
      (mx + 2.6, my + h * 0.38),
      (mx + 3.2, my + h * 0.38),
      tension: 1,
      ..sty,
    )
  }

  // D: flat high, step drop, diagonal drop, flat low
  let curveD = (mx, my, w, h) => {
    line(
      (mx + 0.2, my + h * 0.85),
      (mx + 1.0, my + h * 0.85),
      (mx + 1.0, my + h * 0.65),
      (mx + 1.8, my + h * 0.40),
      (mx + 3.2, my + h * 0.40),
      ..sty,
    )
  }

  // E: starts mid, bumps to local max (open circle), smooth drop to low flat
  let curveE = (mx, my, w, h) => {
    catmull(
      (mx + 0.2, my + h * 0.58),
      (mx + 0.7, my + h * 0.62),
      (mx + 1.05, my + h * 0.72),
      (mx + 1.5, my + h * 0.60),
      (mx + 2.1, my + h * 0.45),
      (mx + 2.8, my + h * 0.35),
      (mx + 3.2, my + h * 0.35),
      tension: 0.47,
      ..sty,
    )
  }

  // F: starts mid, small bump (open circle), then steep smooth drop to low flat
  let curveF = (mx, my, w, h) => {
    catmull(
      (mx + 0.2, my + h * 0.50),
      (mx + 0.6, my + h * 0.54),
      (mx + 0.95, my + h * 0.62),
      (mx + 0.95, my + h * 0.50),
      (mx + 1.9, my + h * 0.30),
      (mx + 2.6, my + h * 0.22),
      (mx + 3.2, my + h * 0.21),
      tension: 0.6,
      ..sty,
    )
  }

  // G: flat high, smooth S-curve drop, flat low
  let curveG = (mx, my, w, h) => {
    catmull(
      (mx + 0.2, my + h * 0.85),
      (mx + 0.9, my + h * 0.85),
      (mx + 1.3, my + h * 0.82),
      (mx + 1.4, my + h * 0.58),
      (mx + 2, my + h * 0.36),
      (mx + 2.6, my + h * 0.33),
      (mx + 3.2, my + h * 0.33),
      tension: 0.5,
      ..sty,
    )
  }

  // H: flat high, sharp corner down, smooth curve to flat low
  let curveH = (mx, my, w, h) => {
    catmull(
      (mx + 0.2, my + h * 0.85),
      (mx + 1.1, my + h * 0.85),
      (mx + 1.15, my + h * 0.84),
      (mx + 1.3, my + h * 0.72),
      (mx + 1.7, my + h * 0.48),
      (mx + 2.2, my + h * 0.32),
      (mx + 3.2, my + h * 0.32),
      tension: 1,
      ..sty,
    )
  }

  let cs = 4.6
  let rs = 4.2

  panel(0 * cs, 1 * rs, "A", curveA)
  panel(1 * cs, 1 * rs, "B", curveB)
  panel(2 * cs, 1 * rs, "C", curveC)
  panel(3 * cs, 1 * rs, "D", curveD)
  panel(0 * cs, 0 * rs, "E", curveE)
  panel(1 * cs, 0 * rs, "F", curveF)
  panel(2 * cs, 0 * rs, "G", curveG)
  panel(3 * cs, 0 * rs, "H", curveH)
})

#note-box()[
  *Mechanical energy patterns:*

  - *Free fall, no friction:* $E_m$ constant (PE $->$ KE).
  - *Inelastic collision (instantaneous):* discontinuous drop (vertical line on graph).
  - *Elastic collision:* $E_m$ unchanged.
  - *Kinetic friction acting:* gradual linear decrease.
  - *Static friction (no sliding):* $E_m$ unchanged.

  *E25 Q14 (disk falls onto rotating disk):*
  + Fall: flat (PE $->$ KE)
  + Impact: sharp drop (collision)
  + Friction between disks equalizes $omega$: gradual decline
  + Common $omega$: flat again

  *Pattern:* flat $->$ drop $->$ gradual decline $->$ flat = *graph H*.
]

#pagebreak()

= Impulse and Conservation of Momentum

== Definitions

#definition(title: [Momentum])[
  *Momentum:* $va(p) = m va(v)$ (vector).

  *Conservation law:* $sum va(p)_i = sum va(p)_f$ if net external force = 0 over the time interval.

  *Center of mass:* $va(r)_("cm") = (sum m_i va(r)_i) / (sum m_i)$.

  *Newton in COM form:* $sum va(F)_("ext") = M_("total") va(a)_("cm")$.
]

#important[
  *Most important insight:* Internal forces NEVER change $va(p)_("total")$ or $va(a)_("cm")$. Only *external* forces act.
]

== Stacked Blocks COM Trick (E25 Q7)

#example(
  title: [E25 Q7: Two stacked blocks, F pulls the top one],
)[
  $m_1 = m_2 = 1$ kg, $F = 20$ N pulls top, $mu_s = 0.80$, $mu_k = 0.50$.

  #solution(
    )[
    *Do they slide? Check max static:* $f_max = mu_s m_1 g = 0.80 dot 1 dot 9.82 = 7.86$ N.

    *If not sliding, common $a$:* $a = F/(m_1 + m_2) = 10$ m/s². Friction required on bottom: $m_2 a = 10$ N. But $10 > 7.86$ $->$ sliding!

    *Sliding — find accelerations individually:*
    $a_1 = (F - mu_k m_1 g)/m_1 = (20 - 4.91)/1 = 15.1$ m/s².
    $a_2 = mu_k m_1 g / m_2 = 4.91/1 = 4.91$ m/s².

    *BUT $a_("cm")$:* COM acceleration comes ONLY from external force (internal forces, including friction between the blocks, have no effect):
    $
      a_("cm") = F_("ext") / M_("total") = 20 / 2 = 10 #text(" m/s²")
    $
    *Answer: D) 10 m/s²*. ✓

    *Check:* $a_("cm") = (m_1 a_1 + m_2 a_2)/M = (15.1 + 4.91)/2 = 10$. ✓
  ]
]

== Collision Types

#definition(title: [Collision Types])[
  *Elastic:* both $va(p)$ and $K$ are conserved.

  *Inelastic:* $va(p)$ conserved; $K$ not conserved (energy is lost).

  *Perfectly inelastic:* objects stick together after — $va(p)$ conserved.
]

== 1D Elastic Collision

$
  v_(1f) = ((m_1 - m_2) v_(1i) + 2 m_2 v_(2i))/(m_1 + m_2), quad v_(2f) = ((m_2 - m_1) v_(2i) + 2 m_1 v_(1i))/(m_1 + m_2)
$

#math-hint()[
  *Special case, $v_(2i) = 0$ (target at rest):*
  - $m_1 = m_2$: $v_(1f) = 0$, $v_(2f) = v_(1i)$ — they swap speeds.
  - $m_1 >> m_2$: $v_(1f) approx v_(1i)$, $v_(2f) approx 2 v_(1i)$ — light one flies off at double speed.
  - $m_1 << m_2$: $v_(1f) approx -v_(1i)$, $v_(2f) approx 0$ — light one bounces back, heavy one barely moves.
]

== Perfectly Inelastic

$
  v_f = (m_1 v_(1i) + m_2 v_(2i))/(m_1 + m_2)
$

Energy loss: $Delta K = K_i - K_f$. For $v_2 = 0$: the loss is $K_i dot m_2/(m_1 + m_2)$.

== Explosion from Rest (E25 Q10)

#math-hint()[
  *Two-body explosion from rest:*
  $
    0 = m_1 v_1 + m_2 v_2 ==> v_1 = -(m_2/m_1) v_2
  $

  *Opposite direction*, heavier body moves slower.
]

#example(title: [E25 Q10: Spring between two blocks])[
  $m_A = 2$ kg, $m_B = 6$ kg. Moves from rest, $v_B = 1$ m/s to the right. Find $v_A$.

  #solution()[
    $v_A = -(m_B/m_A) v_B = -3$ m/s. *Answer: D)* speed 3 m/s to the left.
  ]
]

== Fusion/Decay Energy Distribution (E25 Q11)

#important[
  *Two-body reaction from rest (fission/fusion/decay):* The *lighter* particle gets more KE.

  If mass ratio $m_H / m_L = r$, then the heavy particle gets the fraction:
  $
    f_H = 1/(1 + r), quad f_L = r/(1 + r)
  $

  *Proof:* $m_H v_H = m_L v_L ==> v_L = r v_H$. $K_H/K_L = m_H v_H^2/(m_L v_L^2) = (1/r)$.
  So $K_H : K_L = 1 : r$ $->$ fractions $1/(1+r)$ and $r/(1+r)$.

  *E25 Q11:* He vs n with mass ratio 4:1. He gets $1/5 = 20%$, n gets $4/5 = 80%$. *Answer: D*.
]

#pagebreak()

= Rotation

== Angular Kinematics

Analogous formulas to translation (with constant $alpha$):
$
  omega = omega_0 + alpha t, quad theta = omega_0 t + 1/2 alpha t^2, quad omega^2 = omega_0^2 + 2 alpha theta
$

Connection: $v = omega r$, $a_("tangential") = alpha r$, $a_("radial") = omega^2 r$.

== Moment of Inertia — Table

#align(center)[
  #table(
    columns: 3,
    stroke: 0.5pt,
    inset: 6pt,
    fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
    table.header([*Shape*], [*Axis*], [*$I$*]),
    [Point mass],
    [Distance $r$],
    [$m r^2$],
    [Thin ring/hoop],
    [Axial through center],
    [$m r^2$],
    [Solid disk/cylinder],
    [Axial through center],
    [$1/2 m r^2$],
    [Solid sphere],
    [Through center],
    [$2/5 m r^2$],
    [Hollow sphere (shell)],
    [Through center],
    [$2/3 m r^2$],
    [Thin rod, length $L$],
    [Through midpoint],
    [$1/12 m L^2$],
    [Thin rod, length $L$],
    [Through end],
    [$1/3 m L^2$],
  )
]

#math-hint()[
  *Memory trick:* $I$ increases when mass is farther from the axis. Therefore:
  - Hollow sphere ($2/3$) $>$ solid sphere ($2/5$) — mass farther from center.
  - Rod about end ($1/3$) $>$ about midpoint ($1/12$) — mass at one end is far from axis.
]

== Parallel Axis Theorem (Steiner)

#definition(title: [Steiner's Theorem])[
  $
    I_("parallel axis") = I_("cm") + m d^2
  $

  Where $d$ is the distance between the desired axis and a parallel axis through the COM.
]

*Check*: rod through end: $I = I_("cm") + m (L/2)^2 = m L^2/12 + m L^2/4 = m L^2/3$. ✓

== Torque and Newton's 2nd Law

$
  tau = r F sin theta, quad sum tau_("net") = I alpha, quad L = I omega
$

#important[
  *Conservation of angular momentum (when $sum tau_("ext") = 0$):*
  $
    I_1 omega_1 = I_2 omega_2
  $

  *Classic examples:*
  - Figure skater pulls arms in: $I$ decreases $->$ $omega$ increases.
  - Disk falls onto rotating disk: new $I$ includes the fallen disk.
  - Planet in eccentric orbit: $I = m r^2$ changes $->$ $omega$ changes (Kepler-II).
]

== Disk-on-Disk (E24 Q13)

#example(
  title: [E24 Q13: Find $I_2$ from common $omega$],
)[
  Disk $I_1$ spins with $omega_1$. Disk $I_2$ (at rest) falls onto it. Common speed after: $omega_2 = (3/5) omega_1$.

  #solution()[
    Angular momentum conserved about the spin axis (gravity has no moment about vertical axis):
    $
      I_1 omega_1 = (I_1 + I_2) omega_2
    $
    $
      I_1 omega_1 = (I_1 + I_2) (3/5) omega_1 ==> I_1 + I_2 = 5/3 I_1 ==> I_2 = 2/3 I_1
    $
    *Answer: D*.
  ]
]

== Rolling Without Slipping

#definition(title: [Pure rolling])[
  *Condition:* $v_("cm") = omega r$.

  *Total kinetic energy:* $K = 1/2 m v^2 + 1/2 I_("cm") omega^2 = 1/2 m v^2 (1 + I_("cm")/(m r^2))$.
]

#math-hint()[
  *Rolling down incline vs sliding block (same height):*
  $
    v_("rolling") / v_("sliding") = sqrt(1 / (1 + I/(m r^2)))
  $
  - Solid sphere: $sqrt(5/7) approx 0.845$.
  - Solid cylinder: $sqrt(2/3) approx 0.816$.
  - Thin ring: $sqrt(1/2) approx 0.707$.

  Rolling is ALWAYS slower than sliding — energy is split between translation and rotation.
]

== Sliding + Rolling (bowling ball, E25 Q12)

// TODO: Draw a bowling ball to the right on a rough horizontal surface. Draw arrows: v (horizontal right, COM), normal force (up), gravity (down), friction (horizontal left, at contact point on the bottom).

#important[
  *Bowling ball just released (E25 Q12):*

  Just after release: $v > 0$, $omega = 0$. Since $v eq.not r omega$, the *contact point slides* $->$ *kinetic friction*.

  *Kinetic friction (backward):*
  - $a = -mu_k g$ (negative — decelerates).
  - Torque about COM: $tau = f_k r > 0$ $->$ $alpha > 0$ (ball begins to roll).
  - $v$ decreases, $omega$ increases, until $v = r omega$. Then pure rolling, friction becomes static and vanishes (on horizontal surface).

  *Correct answer (E25 Q12): B, C, F, I*
  - B: $a < 0$ ✓
  - C: $alpha > 0$ ✓
  - F: kinetic friction ✓
  - I: $v eq.not plus.minus r omega$ ✓
]

#note-box()[
  *Time to pure rolling:* $v(t) = v_0 - mu_k g t$ and $omega(t) = (mu_k m g r / I) t$. Set $v = r omega$:
  $
    t_("rolling") = (v_0 I) / (mu_k m g (I + m r^2))
  $
  For solid sphere ($I = 2/5 m r^2$): $t_("rolling") = (2 v_0)/(7 mu_k g)$.
]

== String on Pulley — Kinematics (E24 Q12)

#example(
  title: [E24 Q12: $omega$ vs $y$ for falling block],
)[
  Block $m$ falls from rest, $y$ measured downward. String over pulley (radius $r$) without slipping. Sketch $omega(y)$.

  #solution(
    )[
    Constant net force $->$ constant $a$. From kinematics: $v^2 = 2 a y$, so $v = sqrt(2 a y) prop sqrt(y)$.

    No slipping: $omega = v/r prop sqrt(y)$ — *square root of y* $->$ *concave downward* (steep at 0, flatter later).

    *Answer: C*. ✓
  ]
]

#math-hint()[
  *Functional form quick reference:*
  - Constant speed: linear.
  - Constant acceleration from rest: $x prop t^2$ parabola (concave upward).
  - $v^2 = 2 a x$ $->$ $v prop sqrt(x)$ concave downward.
  - Exponential decay: concave upward from one side, downward from the other.
  - $1/r^2$: hyperbolic, drops fast.
]

== Circular Motion Structure Problems (E24 Q14)

#example(
  title: [E24 Q14: Fiber diameter],
)[
  $m = 50$ kg at $R = 1.0$ m, $v = 100$ m/s. Max tensile strength $sigma_("max") = 1600$ MPa. Find min diameter $d$.

  #solution()[
    Centripetal force = tension on fiber: $F_c = m v^2 / R = 500000$ N.

    Min cross-section: $A = F_c / sigma_("max") = 5 dot 10^5 / 1.6 dot 10^9 = 3.125 dot 10^(-4)$ m².

    $A = pi d^2 / 4 ==> d = sqrt(4 A / pi) = 0.020$ m $= 2.0$ cm. *Answer: A*.
  ]
]

#pagebreak()

= Common Exam Traps and Checklists

== The 10 Most Typical Mistakes

#important[
  + *Forgetting N3 pairs* when counting forces in stacked systems (E24 Q8-Q10).
  + *Assuming $f_s = mu_s n$* instead of $f_s <= mu_s n$ (static friction).
  + *Confusing $a_("cm")$ with individual accelerations* — internal forces don't change $a_("cm")$ (E25 Q7).
  + *Forgetting that gravity is perpendicular to the string* at $theta = 90 degree$ (E25 Q9 pendulum).
  + *Height in pendulum is $R(1 - cos theta)$* — not $R sin theta$ or $R cos theta$.
  + *Picking the negative root of a quadratic* — choose the physically meaningful one (usually positive $t$).
  + *Using $mu_s$ when there is sliding* — switch to $mu_k$ when things are moving.
  + *Mass doesn't cancel out* — in pure friction deceleration, pendulum period, projectile range the mass does cancel.
  + *Wrong $I$* — solid sphere is $2/5$, hollow is $2/3$. Check limit cases.
  + *Applying $f_k$ without checking direction* — friction ALWAYS points opposite to relative motion.
]

== What You MUST Know by Heart

#important[
  *Top 10 memory rules:*

  + *Kinematics*: $v = v_0 + a t$, $Delta x = v_0 t + 1/2 a t^2$, $v^2 = v_0^2 + 2 a Delta x$.
  + *Free fall*: time to top $= v_0/g$, max height $= v_0^2/(2g)$.
  + *Projectile*: range $= v_0^2 sin(2 theta)/g$ (same height).
  + *Centripetal*: $a_c = v^2/r = omega^2 r$.
  + *Pendulum at $theta$*: $T_("string") = m v^2/R + m g cos theta$.
  + *Energy conservation*: $1/2 m v^2 + m g h = $ constant.
  + *Momentum conservation*: $sum m v$ conserved for closed system.
  + *Two-body energy split from rest*: lighter particle gets $r/(1+r)$ fraction.
  + *Moments of inertia*: point $m r^2$, ring $m r^2$, disk $1/2 m r^2$, sphere $2/5 m r^2$.
  + *Angular momentum conservation*: $I_1 omega_1 = I_2 omega_2$ (no external torque).
]

== Set Phrases (exam script)

#note-box(
  )[
  *For force-counting questions (E24-style):*
  "Newton's 3rd law says every contact force has a partner. Block $X$ is in contact with ... so the forces are: gravity, normal from ..., friction from ..."

  *For sliding check in stacked blocks:*
  "First assume the blocks move together with $a = F/M_("total")$. The required friction on the bottom is $f_("required") = m_("bottom") a$. Compare with max static $mu_s n$..."

  *For energy/momentum choice:*
  "Since there are no external forces in the direction of motion, $sum p$ is conserved. Alternatively: since only conservative forces act, $E_m$ is conserved..."

  *For collision type:*
  "Since the blocks stick together after (or: the force is a brief impulse), it is an inelastic collision; $p$ is conserved but $K$ is not constant."

  *For pendulum tension:*
  "Use energy conservation to find $v^2$ at the given angle: $v^2 = v_0^2 - 2 g R (1 - cos theta)$. Use Newton's 2nd law radially: $T - m g cos theta = m v^2/R$."

  *For disk-on-disk:*
  "Since there is no external torque about the spin axis (gravity has no moment about the vertical axis through the axis), $L = I omega$ is conserved according to ..."

  *For uncertainty:*
  "According to Gaussian error propagation: $sigma_f^2 = sum (pdv(f, x_i))^2 sigma_(x_i)^2$. With $x_i = ..., sigma_(x_i) = ...$, I get $sigma_f = ...$"
]

== Graph Reading Questions

#note-box(
  )[
  *Sequence for "Which graph fits?":*

  + Describe the motion qualitatively: where is $v$ constant, where does it accelerate, where are there sudden changes?
  + Draw your *expected* graph before looking at the options.
  + For acceleration graphs: positive/negative pulse occurs at speed changes; flat at constant speed.
  + For energy graphs: sudden jumps = collision, gradual slope = friction, flat = no dissipation.
  + Match your sketch to the closest option.
]

== Final Answer Check

#important[
  + *Unit check*: the dimension must be correct.
  + *Sign check*: is the result positive/negative as expected?
  + *Order of magnitude check*: is the answer reasonable? (A centrifuge with radius 0.55 km is not reasonable.)
  + *Special cases*: insert $mu = 0$ or $theta = 0$ — do you get something you already know?
]
