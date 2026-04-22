import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme_colors.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/animations.dart';
import '../widgets/footer.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                isMobile ? 20 : w * 0.05, 48, isMobile ? 20 : w * 0.05, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeSlideIn(
                  child: Text("Professional Journey",
                      style: GoogleFonts.inter(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w800,
                          color: c.textPrimary)),
                ),
                const SizedBox(height: 6),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 100),
                  child: Text("Experience & Education",
                      style: GoogleFonts.inter(
                          fontSize: 15, color: c.textSecondary)),
                ),
                const SizedBox(height: 40),
                isMobile
                    ? Column(children: [
                        _ExperienceColumn(c: c, isMobile: isMobile),
                        const SizedBox(height: 32),
                        _EducationCard(c: c),
                      ])
                    : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(
                            flex: 6,
                            child: _ExperienceColumn(c: c, isMobile: isMobile)),
                        const SizedBox(width: 32),
                        Expanded(flex: 4, child: _EducationCard(c: c)),
                      ]),
                const SizedBox(height: 60),
              ],
            ),
          ),
          PortfolioFooter(),
        ],
      ),
    );
  }
}

class _ExperienceColumn extends StatelessWidget {
  final AppThemeColors c;
  final bool isMobile;
  const _ExperienceColumn({required this.c, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Work Experience",
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: c.textPrimary)),
        const SizedBox(height: 20),
        ...PortfolioData.experience.asMap().entries.map((e) => FadeSlideIn(
              delay: Duration(milliseconds: 100 * e.key),
              child: _ExperienceCard(item: e.value, c: c),
            )),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel item;
  final AppThemeColors c;
  const _ExperienceCard({required this.item, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Timeline
        Column(children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.isCurrent ? c.primary : c.textMuted,
              boxShadow: item.isCurrent
                  ? [BoxShadow(color: c.primary.withValues(alpha: 0.5), blurRadius: 8)]
                  : null,
            ),
          ),
          Container(
            width: 1,
            height: 180,
            color: c.cardBorder,
            margin: const EdgeInsets.only(top: 4),
          ),
        ]),
        const SizedBox(width: 18),
        Expanded(
          child: HoverCard(
            glowColor: c.primary,
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: c.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: item.isCurrent
                      ? c.primary.withValues(alpha: 0.4)
                      : c.cardBorder,
                ),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(item.period,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: item.isCurrent ? c.primary : c.textSecondary,
                          letterSpacing: 0.5)),
                  if (item.isCurrent) ...[
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: c.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("PRESENT",
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: c.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ]),
                const SizedBox(height: 10),
                Text(item.company,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary)),
                const SizedBox(height: 4),
                Text(item.role,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: c.primaryLight,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                Text(item.description,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: c.textSecondary, height: 1.6)),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tags.map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: c.cardBorder),
                        ),
                        child: Text(t,
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 10, color: c.textSecondary)),
                      )).toList(),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final AppThemeColors c;
  const _EducationCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Education",
          style: GoogleFonts.inter(
              fontSize: 18, fontWeight: FontWeight.w700, color: c.textPrimary)),
      const SizedBox(height: 20),
      HoverCard(
        glowColor: c.primary,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: c.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.cardBorder),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: c.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.school_outlined, color: c.primary, size: 28),
            ),
            const SizedBox(height: 16),
            Text("BS Software Engineering",
                style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary)),
            const SizedBox(height: 6),
            Text("University of Gujrat, Pakistan",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: c.primaryLight,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text("Nov 2021 – July 2025",
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 12, color: c.textSecondary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: c.cardBorder),
              ),
              child: Row(children: [
                Icon(Icons.emoji_events_outlined, color: c.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text("BSSE — Software Engineering",
                      style: GoogleFonts.inter(
                          fontSize: 13, color: c.textSecondary)),
                ),
              ]),
            ),
          ]),
        ),
      ),
    ]);
  }
}
