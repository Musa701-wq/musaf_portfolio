import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SplashScreen({super.key, required this.onDone});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late AnimationController _barCtrl;
  late AnimationController _fadeCtrl;
  late Animation<double> _logoOpacity;
  late Animation<double> _bar;
  late Animation<double> _fadeOut;

  final List<String> _bootLines = [
    "INITIALIZING MUSAF.DEV...",
    "LOADING FLUTTER_ENGINE...",
    "SYNCING FIREBASE_SERVICES...",
    "RENDERING PORTFOLIO_UI...",
    "SYSTEM_READY.",
  ];
  int _lineIndex = 0;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _barCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _logoOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut));
    _bar = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _barCtrl, curve: Curves.easeInOut));
    _fadeOut = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));

    _start();
  }

  void _start() async {
    await _logoCtrl.forward();
    // type boot lines
    for (int i = 0; i < _bootLines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (mounted) setState(() => _lineIndex = i + 1);
    }
    _barCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 900));
    await _fadeCtrl.forward();
    widget.onDone();
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _barCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeOut,
      builder: (_, child) => Opacity(opacity: _fadeOut.value, child: child),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                FadeTransition(
                  opacity: _logoOpacity,
                  child: Text(
                    "MUSAF.AI",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: _logoOpacity,
                  child: Text(
                    "Associate Flutter Developer",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Boot lines
                ...List.generate(_lineIndex, (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(children: [
                        Text("> ",
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 12, color: AppColors.primary)),
                        Text(_bootLines[i],
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 12,
                                color: i == _lineIndex - 1
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary)),
                      ]),
                    )),
                const SizedBox(height: 32),
                // Progress bar
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: AnimatedBuilder(
                    animation: _bar,
                    builder: (_, __) => FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _bar.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedBuilder(
                  animation: _bar,
                  builder: (_, __) => Text(
                    "${(_bar.value * 100).toInt()}%",
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 11, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
