import 'package:flutter/material.dart';

/// Fade + slide up on build
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offsetY = 30,
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(
            begin: Offset(0, widget.offsetY / 100), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacity,
        child: SlideTransition(position: _slide, child: widget.child),
      );
}

/// Hover card — glows on mouse enter + lifts up
class HoverCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final BorderRadius borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF58A6FF),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _glow = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: AnimatedBuilder(
        animation: _glow,
        builder: (_, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          // Lift effect — moves up by 6px on hover
          transform: Matrix4.translationValues(
              0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            boxShadow: [
              BoxShadow(
                color: widget.glowColor
                    .withValues(alpha: _glow.value * 0.3),
                blurRadius: 20 * _glow.value,
                spreadRadius: 1 * _glow.value,
                offset: Offset(0, 4 * _glow.value),
              ),
            ],
          ),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Animated counter — counts up from 0
class AnimatedCounter extends StatefulWidget {
  final String value; // e.g. "7+" or "99%"
  final TextStyle style;

  const AnimatedCounter({super.key, required this.value, required this.style});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  int get _target {
    final digits = RegExp(r'\d+').firstMatch(widget.value)?.group(0);
    return int.tryParse(digits ?? '0') ?? 0;
  }

  String get _suffix =>
      widget.value.replaceAll(RegExp(r'\d'), '').trim();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _anim = Tween<double>(begin: 0, end: _target.toDouble())
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Text(
          "${_anim.value.toInt()}$_suffix",
          style: widget.style,
        ),
      );
}

/// Animated progress bar
class AnimatedProgressBar extends StatefulWidget {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final Duration delay;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    required this.color,
    required this.backgroundColor,
    this.height = 3,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _anim = Tween<double>(begin: 0, end: widget.value)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => ClipRRect(
          borderRadius: BorderRadius.circular(widget.height),
          child: LinearProgressIndicator(
            value: _anim.value,
            backgroundColor: widget.backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            minHeight: widget.height,
          ),
        ),
      );
}

/// Typewriter text effect
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration charDuration;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.charDuration = const Duration(milliseconds: 40),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayed = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _type();
  }

  void _type() async {
    while (_index < widget.text.length) {
      await Future.delayed(widget.charDuration);
      if (!mounted) return;
      setState(() {
        _displayed += widget.text[_index];
        _index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Text(
        _displayed,
        style: widget.style,
      );
}

/// Scroll-triggered fade in using VisibilityDetector alternative
class ScrollFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const ScrollFadeIn({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
            .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacity,
        child: SlideTransition(position: _slide, child: widget.child),
      );
}

/// Interactive 3D Perspective Tilt Card with dynamic depth & glow
class Card3DTilt extends StatefulWidget {
  final Widget child;
  final double maxTiltDegrees;
  final Color glowColor;
  final BorderRadius borderRadius;

  const Card3DTilt({
    super.key,
    required this.child,
    this.maxTiltDegrees = 6.0,
    this.glowColor = const Color(0xFF10B981),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  State<Card3DTilt> createState() => _Card3DTiltState();
}

class _Card3DTiltState extends State<Card3DTilt> {
  double _rotateX = 0;
  double _rotateY = 0;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _rotateX = 0;
        _rotateY = 0;
      }),
      onHover: (event) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final size = renderBox.size;
          final localPos = event.localPosition;
          final px = (localPos.dx / size.width) - 0.5;
          final py = (localPos.dy / size.height) - 0.5;
          final maxRad = widget.maxTiltDegrees * (3.1415926535 / 180.0);
          setState(() {
            _rotateX = -py * maxRad * 2;
            _rotateY = px * maxRad * 2;
          });
        }
      },
      child: AnimatedContainer(
        duration: _hovered ? const Duration(milliseconds: 80) : const Duration(milliseconds: 350),
        curve: _hovered ? Curves.easeOutQuad : Curves.easeOutCubic,
        transform: (Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY))
          .multiplied(Matrix4.translationValues(0.0, _hovered ? -6.0 : 0.0, 0.0)),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: widget.glowColor.withValues(alpha: _hovered ? 0.22 : 0.05),
              blurRadius: _hovered ? 24 : 10,
              spreadRadius: _hovered ? 2 : 0,
              offset: Offset(_rotateY * 8, 6 + (-_rotateX * 8)),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Gradient text widget that renders text with a shader gradient
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.gradient,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}

/// Floating Ambient Glowing Background mesh circles
class AnimatedGlowBackground extends StatelessWidget {
  final Widget child;
  const AnimatedGlowBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -80,
          top: -60,
          child: Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF10B981).withValues(alpha: 0.12),
                  const Color(0xFF10B981).withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -100,
          bottom: -80,
          child: Container(
            width: 420,
            height: 420,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF06B6D4).withValues(alpha: 0.10),
                  const Color(0xFF06B6D4).withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
