import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme_colors.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/footer.dart';
import '../widgets/animations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _HeroSection(),
          _TechBanner(),
          _ProjectsSection(),
          _SyntheticSection(),
          PortfolioFooter(),
        ],
      ),
    );
  }
}

// ─── HERO ─────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;
    final h = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 0 : h * 0.88),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : w * 0.05,
        vertical: isMobile ? 40 : 60,
      ),
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FadeSlideIn(child: _badge(c)),
              const SizedBox(height: 24),
              FadeSlideIn(delay: const Duration(milliseconds: 100), child: _title(c, isMobile)),
              const SizedBox(height: 14),
              FadeSlideIn(delay: const Duration(milliseconds: 180), child: _subtitle(c, isMobile)),
              const SizedBox(height: 28),
              FadeSlideIn(delay: const Duration(milliseconds: 260), child: _buttons(c)),
              const SizedBox(height: 32),
              FadeSlideIn(delay: const Duration(milliseconds: 340), child: _TerminalBox(c: c)),
            ])
          : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                flex: 5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  FadeSlideIn(child: _badge(c)),
                  const SizedBox(height: 28),
                  FadeSlideIn(delay: const Duration(milliseconds: 100), child: _title(c, isMobile)),
                  const SizedBox(height: 16),
                  FadeSlideIn(delay: const Duration(milliseconds: 180), child: _subtitle(c, isMobile)),
                  const SizedBox(height: 32),
                  FadeSlideIn(delay: const Duration(milliseconds: 260), child: _buttons(c)),
                  const SizedBox(height: 40),
                  FadeSlideIn(delay: const Duration(milliseconds: 340), child: _TerminalBox(c: c)),
                ]),
              ),
              SizedBox(width: w * 0.04),
              Expanded(
                flex: 4,
                child: Column(children: [
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 200),
                    offsetY: 20,
                    child: _ProfileCard(c: c),
                  ),
                  const SizedBox(height: 16),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 360),
                    child: Row(children: [
                      Expanded(child: _StatCard(value: "7+", label: "Apps Shipped", c: c)),
                      const SizedBox(width: 14),
                      Expanded(child: _StatCard(value: "99%", label: "Uptime AI", c: c)),
                    ]),
                  ),
                ]),
              ),
            ]),
    );
  }

  Widget _badge(AppThemeColors c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: c.cardBorder),
          borderRadius: BorderRadius.circular(20),
          color: c.surface,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 7, height: 7,
              decoration: BoxDecoration(shape: BoxShape.circle, color: c.accentGreen)),
          const SizedBox(width: 8),
          Text("SYSTEM READY: ASSOCIATE FLUTTER DEVELOPER",
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10, color: c.textSecondary, letterSpacing: 0.4)),
        ]),
      );

  Widget _title(AppThemeColors c, bool isMobile) => RichText(
        text: TextSpan(
          style: GoogleFonts.inter(
              fontSize: isMobile ? 32 : 50,
              fontWeight: FontWeight.w800,
              color: c.textPrimary,
              height: 1.15),
          children: [
            const TextSpan(text: "Building the Future of\nMobile with "),
            TextSpan(text: "Flutter & AI",
                style: TextStyle(color: c.primary)),
          ],
        ),
      );

  Widget _subtitle(AppThemeColors c, bool isMobile) => Text(
        PortfolioData.heroSubtitle,
        style: GoogleFonts.inter(
            fontSize: isMobile ? 14 : 15,
            color: c.textSecondary,
            height: 1.7),
      );

  Widget _buttons(AppThemeColors c) => Wrap(spacing: 12, runSpacing: 12, children: [
        _PrimaryButton(label: "View Portfolio →", url: "mailto:${PortfolioData.email}", c: c),
        _OutlineButton(label: "Download CV", url: "mailto:${PortfolioData.email}", c: c),
      ]);
}

class _TerminalBox extends StatelessWidget {
  final AppThemeColors c;
  const _TerminalBox({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text("CORE_ENGINE_STATUS",
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10, color: c.textSecondary, letterSpacing: 0.5)),
          const Spacer(),
          Text("ACTIVE",
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10, color: c.accentGreen, letterSpacing: 0.5)),
        ]),
        const SizedBox(height: 14),
        ...PortfolioData.terminalLines.map((line) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(children: [
                Text(">>> ", style: GoogleFonts.jetBrainsMono(fontSize: 13, color: c.primary)),
                Text(line, style: GoogleFonts.jetBrainsMono(fontSize: 13, color: c.textSecondary)),
              ]),
            )),
      ]),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final AppThemeColors c;
  const _ProfileCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Container(
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.cardBorder),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.asset('assets/images/my-pic.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, __, ___) => Container(
                        height: 260, color: c.surface,
                        child: Icon(Icons.person_outline, color: c.textMuted, size: 60))),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.55, 1.0],
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 14, left: 16, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Musaf Ali",
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text("Associate Flutter Developer",
                      style: GoogleFonts.jetBrainsMono(fontSize: 11, color: c.primary)),
                ],
              )),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, runSpacing: 8,
                children: ["Flutter & Dart", "Firebase", "GetX / MVC", "AI Integration", "App Store"]
                    .map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                          decoration: BoxDecoration(
                            color: c.surface,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: c.cardBorder),
                          ),
                          child: Text(s, style: GoogleFonts.jetBrainsMono(fontSize: 10, color: c.textSecondary)),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Icon(Icons.location_on_outlined, size: 13, color: c.textSecondary),
                const SizedBox(width: 4),
                Text("Gujrat, Pakistan", style: GoogleFonts.inter(fontSize: 12, color: c.textSecondary)),
                const SizedBox(width: 14),
                Container(width: 7, height: 7,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: c.accentGreen)),
                const SizedBox(width: 5),
                Text("Available for work",
                    style: GoogleFonts.inter(fontSize: 12, color: c.accentGreen, fontWeight: FontWeight.w500)),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final AppThemeColors c;
  const _StatCard({required this.value, required this.label, required this.c});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.cardBorder),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AnimatedCounter(
            value: value,
            style: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w800, color: c.primary),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: c.textSecondary)),
        ]),
      ),
    );
  }
}

// ─── TECH BANNER ──────────────────────────────────────────────────────────────
class _TechBanner extends StatelessWidget {
  const _TechBanner();

  static const List<String> _techs = [
    "FLUTTER", "DART", "TENSORFLOW", "PYTORCH", "FIREBASE", "SUPABASE"
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.symmetric(horizontal: BorderSide(color: c.cardBorder)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 32,
        runSpacing: 10,
        children: _techs.map((t) => Text(t,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 11, color: c.textMuted, letterSpacing: 1.5))).toList(),
      ),
    );
  }
}

// ─── PROJECTS SECTION ─────────────────────────────────────────────────────────
class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.05, vertical: 60),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 7, height: 7,
              decoration: BoxDecoration(shape: BoxShape.circle, color: c.primary)),
          const SizedBox(width: 8),
          Text("SYSTEM STATUS: DISPLAYING FEATURED OPERATIONS",
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10, color: c.textSecondary, letterSpacing: 0.5)),
        ]),
        const SizedBox(height: 18),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
                fontSize: isMobile ? 28 : 38,
                fontWeight: FontWeight.w800,
                color: c.textPrimary,
                height: 1.2),
            children: [
              const TextSpan(text: "High-Performance\n"),
              TextSpan(text: "Flutter Solutions",
                  style: TextStyle(color: c.primary)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.cardBorder),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _tLine("> Initializing portfolio_viewer.exe...", c),
            _tLine("> Filtering by: Precision Engineering, AI Integration, Scalable UX.", c),
            _tLine("> Projects found: ${PortfolioData.projects.length}. Rendering now.", c),
          ]),
        ),
        const SizedBox(height: 32),
        if (isMobile)
          Column(
            children: List.generate(
              PortfolioData.projects.length > 6 ? 6 : PortfolioData.projects.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 100 * i),
                  child: HoverCard(
                    child: _ProjectCard(project: PortfolioData.projects[i], index: i, c: c),
                  ),
                ),
              ),
            ),
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              PortfolioData.projects.length > 3 ? 3 : PortfolioData.projects.length,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 2 ? 20 : 0),
                  child: FadeSlideIn(
                    delay: Duration(milliseconds: 150 * i),
                    child: HoverCard(
                      child: _ProjectCard(project: PortfolioData.projects[i], index: i, c: c),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }

  Widget _tLine(String t, AppThemeColors c) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(t, style: GoogleFonts.jetBrainsMono(fontSize: 12, color: c.textSecondary)),
      );
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;
  final AppThemeColors c;
  const _ProjectCard({required this.project, required this.index, required this.c});

  static const List<String> _imgs = [
    "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600&q=80",
    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&q=80",
    "https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=600&q=80",
    "https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=600&q=80",
    "https://images.unsplash.com/photo-1456324504439-367cee3b3c32?w=600&q=80",
    "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    final imgUrl = _imgs[index % _imgs.length];
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.cardBorder),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 190,
            child: Stack(fit: StackFit.expand, children: [
              Image.network(imgUrl, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: c.surface)),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 1.0],
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 12, left: 14, right: 14,
                child: Text(project.title,
                    style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white))),
            ]),
          ),
          Container(
            color: c.card,
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, children: [
              Wrap(spacing: 6, children: project.tags.take(2).map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: c.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: c.primary.withValues(alpha: 0.3)),
                    ),
                    child: Text(t, style: GoogleFonts.jetBrainsMono(
                        fontSize: 9, color: c.primary)),
                  )).toList()),
              const SizedBox(height: 8),
              Text(project.title,
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w700, color: c.textPrimary)),
              const SizedBox(height: 5),
              Text(project.description,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: c.textSecondary, height: 1.5),
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  if (project.link != null) {
                    final uri = Uri.parse(project.link!);
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: c.cardBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("View Case Study",
                        style: GoogleFonts.inter(
                            fontSize: 12, color: c.textSecondary, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 12, color: c.textSecondary),
                  ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ─── SYNTHETIC SECTION ────────────────────────────────────────────────────────
class _SyntheticSection extends StatelessWidget {
  const _SyntheticSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.05, vertical: 60),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.cardBorder)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: c.cardBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.memory_rounded, color: c.primary, size: 20),
            ),
          ),
          const Expanded(child: Divider()),
        ]),
        const SizedBox(height: 48),
        isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _left(c, isMobile),
                const SizedBox(height: 28),
                _codeBox(c),
              ])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 4, child: _left(c, isMobile)),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _codeBox(c)),
              ]),
      ]),
    );
  }

  Widget _left(AppThemeColors c, bool isMobile) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Synthetic Intelligence Core",
              style: GoogleFonts.inter(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary)),
          const SizedBox(height: 12),
          Text("Every project leverages Flutter-first architecture optimized for heavy computation, state management, and seamless AI integration.",
              style: GoogleFonts.inter(fontSize: 14, color: c.textSecondary, height: 1.7)),
          const SizedBox(height: 28),
          _feat(c, Icons.speed_rounded, "High FPS Performance", "60fps guaranteed on low-end silicon."),
          const SizedBox(height: 16),
          _feat(c, Icons.lock_outline_rounded, "Quantum-Ready Security", "Encrypted payloads for sensitive AI data."),
        ],
      );

  Widget _feat(AppThemeColors c, IconData icon, String title, String sub) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: c.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: c.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: c.textPrimary)),
            const SizedBox(height: 2),
            Text(sub, style: GoogleFonts.inter(fontSize: 12, color: c.textSecondary)),
          ])),
        ],
      );

  Widget _codeBox(AppThemeColors c) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.cardBorder),
        ),
        child: Text(
          '''class MusafLogic {
  final List<Project> featured = [
    RenovateAI(env: AI.do_generative),
    Golumo(security: Encryption.AES256),
    PlantEyes(engine: Engine.tensorflowLite),
  ];

  void render() {
    featured.forEach((p) => p.initialize());
    print("UI_REFRESH_RATE: 120Hz");
    print("STATUS: SYSTEM_STABLE");
  }
}''',
          style: GoogleFonts.jetBrainsMono(
              fontSize: 12, color: c.textSecondary, height: 1.7),
        ),
      );
}

// ─── REUSABLE BUTTONS ─────────────────────────────────────────────────────────
class _PrimaryButton extends StatefulWidget {
  final String label;
  final String url;
  final AppThemeColors c;
  const _PrimaryButton({required this.label, required this.url, required this.c});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? widget.c.primaryLight : widget.c.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [BoxShadow(color: widget.c.primary.withValues(alpha: 0.4), blurRadius: 16)]
                : [],
          ),
          child: Text(widget.label,
              style: GoogleFonts.inter(
                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final String url;
  final AppThemeColors c;
  const _OutlineButton({required this.label, required this.url, required this.c});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? widget.c.primary.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _hovered ? widget.c.primary : widget.c.cardBorder),
          ),
          child: Text(widget.label,
              style: GoogleFonts.inter(
                  color: _hovered ? widget.c.primary : widget.c.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14)),
        ),
      ),
    );
  }
}
