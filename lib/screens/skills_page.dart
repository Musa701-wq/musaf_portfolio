import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme_colors.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/footer.dart';
import '../widgets/animations.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _SkillsHeader(),
          _TechnicalMastery(),
          _NeuralEngineBox(),
          _ProfessionalJourney(),
          PortfolioFooter(),
        ],
      ),
    );
  }
}

// ── HEADER ────────────────────────────────────────────────────────────────────
class _SkillsHeader extends StatelessWidget {
  const _SkillsHeader();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          isMobile ? 20 : w * 0.05, 48, isMobile ? 20 : w * 0.05, 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FadeSlideIn(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: c.cardBorder),
              borderRadius: BorderRadius.circular(20),
              color: c.surface,
            ),
            child: Text("SYSTEM_STATUS: EXPERT",
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 10, color: c.accentGreen, letterSpacing: 0.5)),
          ),
        ),
        const SizedBox(height: 24),
        FadeSlideIn(
          delay: const Duration(milliseconds: 100),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w800,
                  color: c.textPrimary,
                  height: 1.15),
              children: [
                const TextSpan(text: "Engineering "),
                TextSpan(
                    text: "Next-Gen\n",
                    style: TextStyle(color: c.primary)),
                const TextSpan(text: "Intelligence with Flutter."),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ── TECHNICAL MASTERY ─────────────────────────────────────────────────────────
class _TechnicalMastery extends StatelessWidget {
  const _TechnicalMastery();

  static const List<_MasteryItem> _items = [
    _MasteryItem(
      title: "Flutter Framework",
      desc: "Advanced architectural patterns (BLoC, Clean Architecture) for multi-platform delivery.",
      level: 0.90,
      icon: Icons.flutter_dash,
    ),
    _MasteryItem(
      title: "AI/ML Integration",
      desc: "Deploying TensorFlow Lite models and Gemini API orchestration within mobile ecosystems.",
      level: 0.92,
      icon: Icons.psychology_outlined,
    ),
    _MasteryItem(
      title: "Dart Systems",
      desc: "Isolates, reactive programming, and high-performance package development.",
      level: 0.93,
      icon: Icons.data_object_rounded,
    ),
    _MasteryItem(
      title: "Firebase Stack",
      desc: "Real-time DB, Cloud Functions, and dynamic security rule implementations.",
      level: 0.90,
      icon: Icons.local_fire_department_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.05, vertical: 0),
      child: Column(children: [
        Center(
          child: FadeSlideIn(
            child: Text("Technical Mastery",
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary)),
          ),
        ),
        const SizedBox(height: 24),
        isMobile
            ? Column(
                children: _items.asMap().entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: FadeSlideIn(
                        delay: Duration(milliseconds: 100 * e.key),
                        child: HoverCard(
                            glowColor: c.primary,
                            child: _MasteryCard(item: e.value, c: c)),
                      ),
                    )).toList(),
              )
            : Row(
                children: _items.asMap().entries.map((e) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: e.key < _items.length - 1 ? 16 : 0),
                        child: FadeSlideIn(
                          delay: Duration(milliseconds: 100 * e.key),
                          child: HoverCard(
                              glowColor: c.primary,
                              child: _MasteryCard(item: e.value, c: c)),
                        ),
                      ),
                    )).toList(),
              ),
      ]),
    );
  }
}

class _MasteryItem {
  final String title;
  final String desc;
  final double level;
  final IconData icon;
  const _MasteryItem(
      {required this.title,
      required this.desc,
      required this.level,
      required this.icon});
}

class _MasteryCard extends StatelessWidget {
  final _MasteryItem item;
  final AppThemeColors c;
  const _MasteryCard({required this.item, required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(item.icon, color: c.primary, size: 24),
          _CircularPercent(value: item.level, c: c),
        ]),
        const SizedBox(height: 16),
        Text(item.title,
            style: GoogleFonts.inter(
                fontSize: 15, fontWeight: FontWeight.w700, color: c.textPrimary)),
        const SizedBox(height: 8),
        Text(item.desc,
            style: GoogleFonts.inter(
                fontSize: 12, color: c.textSecondary, height: 1.5)),
        const SizedBox(height: 16),
        AnimatedProgressBar(
          value: item.level,
          color: c.primary,
          backgroundColor: c.cardBorder,
          height: 3,
          delay: const Duration(milliseconds: 400),
        ),
      ]),
    );
  }
}

// Animated circular percent
class _CircularPercent extends StatefulWidget {
  final double value;
  final AppThemeColors c;
  const _CircularPercent({required this.value, required this.c});

  @override
  State<_CircularPercent> createState() => _CircularPercentState();
}

class _CircularPercentState extends State<_CircularPercent>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _anim = Tween<double>(begin: 0, end: widget.value)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 300),
        () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => SizedBox(
        width: 48,
        height: 48,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              value: _anim.value,
              strokeWidth: 3,
              backgroundColor: widget.c.cardBorder,
              valueColor: AlwaysStoppedAnimation<Color>(widget.c.primary),
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            "${(_anim.value * 100).toInt()}%",
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: widget.c.primary,
                fontWeight: FontWeight.w700),
          ),
        ]),
      ),
    );
  }
}

// ── NEURAL ENGINE BOX ─────────────────────────────────────────────────────────
class _NeuralEngineBox extends StatelessWidget {
  const _NeuralEngineBox();

  static const List<String> _termLines = [
    "> INITIALIZING SKILL_MATRIX_V4.JSON",
    "> DEPLOYING STATE_MANAGEMENT: RIVERPOD // BLOC",
    "> OPTIMIZING RENDER_CYCLES: 120FPS_FLUID",
    "> SYNCING_EXTERNAL_API: GEMINI-1.8-PRO",
  ];

  static const List<String> _tags = [
    "POSTGRESQL", "AWS LAMBDA", "PYTHON", "GIT OPS",
    "DOCKER", "KUBERNETES", "CI/CD", "gRPC",
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.05, vertical: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.cardBorder),
      ),
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _header(c),
              const SizedBox(height: 20),
              ..._termLines.map((l) => _termLine(l, c)),
              const SizedBox(height: 20),
              Wrap(spacing: 8, runSpacing: 8,
                  children: _tags.map((t) => _tagChip(t, c)).toList()),
            ])
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(c),
                      const SizedBox(height: 20),
                      ..._termLines.map((l) => _termLine(l, c)),
                    ]),
              ),
              const SizedBox(width: 40),
              Wrap(spacing: 8, runSpacing: 8,
                  children: _tags.map((t) => _tagChip(t, c)).toList()),
            ]),
    );
  }

  Widget _header(AppThemeColors c) => Row(children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: c.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(Icons.memory_rounded, color: c.primary, size: 13),
        ),
        const SizedBox(width: 10),
        Text("ACTIVE NEURAL ENGINE ANALYSIS",
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10, color: c.textSecondary, letterSpacing: 0.8)),
      ]);

  Widget _termLine(String line, AppThemeColors c) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TypewriterText(
          text: line,
          style: GoogleFonts.jetBrainsMono(fontSize: 12, color: c.textSecondary),
          charDuration: const Duration(milliseconds: 18),
        ),
      );

  Widget _tagChip(String label, AppThemeColors c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: c.cardBorder),
        ),
        child: Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10, color: c.textSecondary)),
      );
}

// ── PROFESSIONAL JOURNEY ──────────────────────────────────────────────────────
class _ProfessionalJourney extends StatelessWidget {
  const _ProfessionalJourney();

  static const List<String> _imgs = [
    "https://images.unsplash.com/photo-1497366216548-37526070297c?w=600&q=70",
    "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600&q=70",
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.05, vertical: 60),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.cardBorder)),
      ),
      child: Column(children: [
        Center(
          child: Text("Professional Journey",
              style: GoogleFonts.inter(
                  fontSize: 22, fontWeight: FontWeight.w600, color: c.textPrimary)),
        ),
        const SizedBox(height: 40),
        // Entry 0
        isMobile
            ? _mobileEntry(PortfolioData.experience[0], _imgs[0], c)
            : FadeSlideIn(
                delay: const Duration(milliseconds: 100),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 5, child: HoverCard(glowColor: c.primary, child: _textCard(PortfolioData.experience[0], c, isCurrent: true))),
                  const SizedBox(width: 24),
                  Expanded(flex: 4, child: _imageCard(_imgs[0])),
                ]),
              ),
        const SizedBox(height: 28),
        // Entry 1
        isMobile
            ? _mobileEntry(PortfolioData.experience[1], _imgs[1], c)
            : FadeSlideIn(
                delay: const Duration(milliseconds: 200),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 4, child: _imageCard(_imgs[1])),
                  const SizedBox(width: 24),
                  Expanded(flex: 5, child: HoverCard(glowColor: c.primary, child: _textCard(PortfolioData.experience[1], c))),
                ]),
              ),
      ]),
    );
  }

  Widget _imageCard(String url) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          color: Colors.black.withValues(alpha: 0.45),
          colorBlendMode: BlendMode.darken,
          errorBuilder: (_, __, ___) => Container(height: 220, color: const Color(0xFF161B22)),
        ),
      );

  Widget _textCard(ExperienceModel exp, AppThemeColors c, {bool isCurrent = false}) =>
      Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isCurrent ? c.primary.withValues(alpha: 0.4) : c.cardBorder),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(exp.period,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: isCurrent ? c.primary : c.textSecondary,
                  letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Text(exp.company,
              style: GoogleFonts.inter(
                  fontSize: 20, fontWeight: FontWeight.w800, color: c.textPrimary)),
          const SizedBox(height: 4),
          Text(exp.role,
              style: GoogleFonts.inter(
                  fontSize: 14, color: c.primaryLight, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Text(exp.description,
              style: GoogleFonts.inter(
                  fontSize: 13, color: c.textSecondary, height: 1.6)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: exp.tags.map((t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: c.cardBorder),
                  ),
                  child: Text(t,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 10, color: c.textSecondary)),
                )).toList(),
          ),
        ]),
      );

  Widget _mobileEntry(ExperienceModel exp, String imgUrl, AppThemeColors c) =>
      Column(children: [
        _imageCard(imgUrl),
        const SizedBox(height: 16),
        _textCard(exp, c),
        const SizedBox(height: 24),
      ]);
}
