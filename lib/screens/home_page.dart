import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
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
          _FeaturedProjectsSection(),
          _ArchitectureSection(),
          PortfolioFooter(),
        ],
      ),
    );
  }
}

// ─── HERO SECTION ─────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 850;
    final h = MediaQuery.of(context).size.height;

    return AnimatedGlowBackground(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: isMobile ? 0 : h * 0.88),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : w * 0.06,
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
              FadeSlideIn(
                delay: const Duration(milliseconds: 340),
                child: Card3DTilt(
                  glowColor: c.primary,
                  borderRadius: BorderRadius.circular(16),
                  child: _TerminalBox(c: c),
                ),
              ),
              const SizedBox(height: 32),
              FadeSlideIn(
                delay: const Duration(milliseconds: 400),
                child: Card3DTilt(
                  glowColor: c.primary,
                  borderRadius: BorderRadius.circular(24),
                  child: _ProfileCard(c: c),
                ),
              ),
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
                  const SizedBox(height: 36),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 340),
                    child: Card3DTilt(
                      glowColor: c.primary,
                      borderRadius: BorderRadius.circular(16),
                      child: _TerminalBox(c: c),
                    ),
                  ),
                ]),
              ),
              SizedBox(width: w * 0.05),
              Expanded(
                flex: 4,
                child: Column(children: [
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 200),
                    offsetY: 20,
                    child: Card3DTilt(
                      glowColor: c.primary,
                      borderRadius: BorderRadius.circular(24),
                      child: _ProfileCard(c: c),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 360),
                    child: Row(children: [
                      Expanded(child: _StatCard(value: "9+", label: "Apps Built", c: c)),
                      const SizedBox(width: 14),
                      Expanded(child: _StatCard(value: "1.5+", label: "Years Exp", c: c)),
                    ]),
                  ),
                ]),
              ),
            ]),
      ),
    );
  }

  Widget _badge(AppThemeColors c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(color: c.primary.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(20),
          gradient: AppGradients.accentPill,
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: c.accentGreen,
                boxShadow: [
                  BoxShadow(
                    color: c.primary.withValues(alpha: 0.6),
                    blurRadius: 6,
                    spreadRadius: 1,
                  )
                ],
              )),
          const SizedBox(width: 8),
          Text(
            "ASSOCIATE FLUTTER DEVELOPER • LAHORE",
            style: GoogleFonts.inter(
                fontSize: 11, fontWeight: FontWeight.w700, color: c.primaryDark, letterSpacing: 0.8),
          ),
        ]),
      );

  Widget _title(AppThemeColors c, bool isMobile) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "Building High-Performance Apps with ",
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 46,
              fontWeight: FontWeight.w800,
              color: c.textPrimary,
              height: 1.15,
            ),
          ),
          GradientText(
            "Flutter & AI",
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 46,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
            gradient: AppGradients.heroText,
          ),
        ],
      );

  Widget _subtitle(AppThemeColors c, bool isMobile) => Text(
        PortfolioData.heroSubtitle,
        style: GoogleFonts.inter(
            fontSize: isMobile ? 14 : 15.5,
            color: c.textSecondary,
            height: 1.7),
      );

  Widget _buttons(AppThemeColors c) => Wrap(spacing: 12, runSpacing: 12, children: [
        _PrimaryButton(label: "Get In Touch →", url: "mailto:${PortfolioData.email}", c: c),
        _OutlineButton(label: "GitHub Profile", url: PortfolioData.github, c: c),
      ]);
}

class _TerminalBox extends StatelessWidget {
  final AppThemeColors c;
  const _TerminalBox({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text("CORE_ARCHITECTURE_STATUS",
              style: GoogleFonts.inter(
                  fontSize: 11, fontWeight: FontWeight.w700, color: c.textPrimary, letterSpacing: 0.5)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: c.greenTint, borderRadius: BorderRadius.circular(4)),
            child: Text("ONLINE",
                style: GoogleFonts.inter(
                    fontSize: 10, fontWeight: FontWeight.w700, color: c.primaryDark, letterSpacing: 0.5)),
          ),
        ]),
        const SizedBox(height: 14),
        ...PortfolioData.terminalLines.map((line) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(children: [
                Text("❯ ", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: c.primary)),
                Expanded(
                  child: Text(line,
                      style: GoogleFonts.jetBrainsMono(fontSize: 12.5, color: c.textSecondary),
                      overflow: TextOverflow.ellipsis),
                ),
              ]),
            )),
      ]),
    );
  }
}

class _ProfileCard extends StatefulWidget {
  final AppThemeColors c;
  const _ProfileCard({required this.c});

  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? c.primary.withValues(alpha: 0.4) : c.cardBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? c.primary.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: _isHovered ? 28 : 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner & Profile Avatar Frame
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Soft Decorative Gradient Banner
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        c.primary.withValues(alpha: 0.12),
                        c.primaryDark.withValues(alpha: 0.04),
                        c.surface,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: c.primary.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                      // Floating Status Indicator
                      Positioned(
                        left: 18,
                        top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: c.isDark ? Colors.black45 : Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: c.cardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: c.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: c.primary.withValues(alpha: 0.6),
                                      blurRadius: 6,
                                      spreadRadius: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                "Available for Work",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: c.primaryDark,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Centered Profile Avatar Ring
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [c.primary, c.primaryLight],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: c.primary.withValues(alpha: _isHovered ? 0.35 : 0.2),
                            blurRadius: _isHovered ? 22 : 12,
                            spreadRadius: _isHovered ? 3 : 1,
                          )
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: c.card,
                        ),
                        child: CircleAvatar(
                          radius: 64,
                          backgroundColor: c.surface,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/my-pic.png',
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, -0.4),
                              width: 128,
                              height: 128,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.person_outline_rounded,
                                color: c.textMuted,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Profile Title Block
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Musaf Ali",
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: c.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.verified_rounded, size: 20, color: c.primary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: c.greenTint,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: c.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.code_rounded, size: 14, color: c.primaryDark),
                          const SizedBox(width: 6),
                          Text(
                            "Associate Flutter Developer",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: c.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: c.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          PortfolioData.location,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),
            Divider(height: 1, color: c.cardBorder.withValues(alpha: 0.6)),
            const SizedBox(height: 16),

            // Skill Badges Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  "Flutter & Dart",
                  "GetX / MVC",
                  "Firebase",
                  "Gemini AI",
                  "NFC & Maps",
                  "In-App Purchases"
                ].map((s) => _SkillChip(label: s, c: c)).toList(),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  final AppThemeColors c;
  const _SkillChip({required this.label, required this.c});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: _hovered ? c.greenTint : c.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? c.primary.withValues(alpha: 0.4) : c.cardBorder,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
            color: _hovered ? c.primaryDark : c.textSecondary,
          ),
        ),
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
    return Card3DTilt(
      glowColor: c.primary,
      maxTiltDegrees: 8,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.cardBorder),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AnimatedCounter(
            value: value,
            style: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w800, color: c.primary),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: c.textSecondary)),
        ]),
      ),
    );
  }
}

// ─── TECH BANNER ──────────────────────────────────────────────────────────────
class _TechBanner extends StatelessWidget {
  const _TechBanner();

  static const List<String> _techs = [
    "FLUTTER",
    "DART",
    "GETX",
    "FIREBASE",
    "GEMINI AI",
    "STRIPE",
    "NFC",
    "REST APIS"
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.symmetric(horizontal: BorderSide(color: c.cardBorder)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 28,
        runSpacing: 12,
        children: _techs
            .map((t) => Text(
                  t,
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w700, color: c.textMuted, letterSpacing: 1.5),
                ))
            .toList(),
      ),
    );
  }
}

// ─── FEATURED PROJECTS SECTION ────────────────────────────────────────────────
class _FeaturedProjectsSection extends StatelessWidget {
  const _FeaturedProjectsSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : w * 0.06,
        vertical: 60,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: c.primary)),
          const SizedBox(width: 8),
          Text(
            "SELECTED SHOWCASE WORK",
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w700, color: c.primaryDark, letterSpacing: 1),
          ),
        ]),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
                fontSize: isMobile ? 28 : 38,
                fontWeight: FontWeight.w800,
                color: c.textPrimary,
                height: 1.2),
            children: [
              const TextSpan(text: "High-Impact Mobile Solutions\nBuilt with "),
              TextSpan(text: "Precision", style: TextStyle(color: c.primary)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Column(
          children: PortfolioData.projects.take(4).map((proj) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card3DTilt(
              glowColor: c.primary,
              borderRadius: BorderRadius.circular(20),
              child: _ProjectRowCard(project: proj, c: c),
            ),
          )).toList(),
        ),
      ]),
    );
  }
}

class _ProjectRowCard extends StatefulWidget {
  final ProjectModel project;
  final AppThemeColors c;
  const _ProjectRowCard({required this.project, required this.c});

  @override
  State<_ProjectRowCard> createState() => _ProjectRowCardState();
}

class _ProjectRowCardState extends State<_ProjectRowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final c = widget.c;
    final isMobile = MediaQuery.of(context).size.width < 700;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? c.primary : c.cardBorder,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? c.primary.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.03),
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _content(p, c),
                const SizedBox(height: 16),
                _button(p, c),
              ])
            : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(child: _content(p, c)),
                const SizedBox(width: 24),
                _button(p, c),
              ]),
      ),
    );
  }

  Widget _content(ProjectModel p, AppThemeColors c) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: c.greenTint, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  p.platform.toUpperCase(),
                  style: GoogleFonts.inter(
                      fontSize: 11, fontWeight: FontWeight.w700, color: c.primaryDark),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p.title,
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: c.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            p.description,
            style: GoogleFonts.inter(fontSize: 13.5, color: c.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 12),
          Text(
            p.techStack,
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: c.primaryDark),
          ),
        ],
      );

  Widget _button(ProjectModel p, AppThemeColors c) {
    if (p.link != null) {
      return ElevatedButton.icon(
        onPressed: () async {
          final uri = Uri.parse(p.link!);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        icon: const Icon(Icons.launch, size: 14),
        label: Text("Open Link", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: null,
      icon: const Icon(Icons.check, size: 14),
      label: Text("Production Ready", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
      style: OutlinedButton.styleFrom(
        foregroundColor: c.textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: c.cardBorder),
      ),
    );
  }
}

// ─── ARCHITECTURE SECTION ─────────────────────────────────────────────────────
class _ArchitectureSection extends StatelessWidget {
  const _ArchitectureSection();

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : w * 0.06,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.cardBorder)),
      ),
      child: isMobile
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
    );
  }

  Widget _left(AppThemeColors c, bool isMobile) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Scalable Architecture & Clean Code",
              style: GoogleFonts.inter(
                  fontSize: isMobile ? 24 : 30, fontWeight: FontWeight.w800, color: c.textPrimary)),
          const SizedBox(height: 12),
          Text(
            "Every mobile app is engineered with MVC architecture, GetX state management, robust RESTful API handlers, and clean dependency management for long-term scalability.",
            style: GoogleFonts.inter(fontSize: 14.5, color: c.textSecondary, height: 1.7),
          ),
          const SizedBox(height: 24),
          _feat(c, Icons.layers_outlined, "MVC & GetX Architecture", "Clean separation of presentation, logic, and data."),
          const SizedBox(height: 16),
          _feat(c, Icons.monetization_on_outlined, "App Monetization & IAP", "AdMob ads & In-App Purchases integration."),
        ],
      );

  Widget _feat(AppThemeColors c, IconData icon, String title, String sub) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: c.greenTint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: c.primaryDark, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: c.textPrimary)),
              const SizedBox(height: 2),
              Text(sub, style: GoogleFonts.inter(fontSize: 12.5, color: c.textSecondary)),
            ]),
          ),
        ],
      );

  Widget _codeBox(AppThemeColors c) => Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, size: 18, color: c.primary),
                const SizedBox(width: 8),
                Text(
                  "architecture_sample.dart",
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: c.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '''class MusafPortfolioApp {
  final List<String> coreStack = [
    "Flutter", "Dart", "GetX", "MVC",
    "Firebase Auth", "REST APIs", "AdMob",
    "In-App Purchases", "Gemini AI"
  ];

  void initializeApp() {
    print("Connecting API Gateways...");
    print("Loading Production UI Modules...");
    print("Ready for Deployment to App Store & Play Store.");
  }
}''',
              style: GoogleFonts.jetBrainsMono(fontSize: 12.5, color: c.textSecondary, height: 1.6),
            ),
          ],
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
          duration: const Duration(milliseconds: 200),
          transform: _hovered ? Matrix4.translationValues(0, -3, 0) : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.c.primary.withValues(alpha: _hovered ? 0.45 : 0.25),
                blurRadius: _hovered ? 18 : 8,
                offset: Offset(0, _hovered ? 6 : 3),
              )
            ],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
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
          duration: const Duration(milliseconds: 200),
          transform: _hovered ? Matrix4.translationValues(0, -3, 0) : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            color: _hovered ? widget.c.greenTint : widget.c.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? widget.c.primary : widget.c.cardBorder,
              width: 1.5,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: widget.c.primary.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
            ],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: _hovered ? widget.c.primaryDark : widget.c.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
