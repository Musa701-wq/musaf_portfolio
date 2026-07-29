import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/theme_colors.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/footer.dart';
import '../widgets/animations.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            color: AppColors.surface,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : w * 0.08,
              vertical: isMobile ? 40 : 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeSlideIn(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.greenTint,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "CAREER & ACADEMICS",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    "Work Experience & Education",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 28 : 42,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 160),
                  child: SizedBox(
                    width: 650,
                    child: Text(
                      "Over 1.5 years of industry engineering experience building production-grade mobile applications on-site and remotely, backed by a Bachelor of Science in Software Engineering.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 14 : 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Experience Section Title
                Row(
                  children: [
                    const Icon(Icons.work_outline, color: AppColors.primary, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      "Professional Experience",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Experience Items
                ...PortfolioData.experience.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final exp = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: FadeSlideIn(
                      delay: Duration(milliseconds: idx * 120),
                      child: _ExperienceCard(exp: exp),
                    ),
                  );
                }),

                const SizedBox(height: 40),
                const Divider(color: AppColors.cardBorder),
                const SizedBox(height: 40),

                // Education Section Title
                Row(
                  children: [
                    const Icon(Icons.school_outlined, color: AppColors.primary, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      "Education & Credentials",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Education Cards
                ...PortfolioData.education.asMap().entries.map((entry) {
                  final edu = entry.value;
                  return _EducationCard(edu: edu);
                }),
              ],
            ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceModel exp;
  const _ExperienceCard({required this.exp});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.exp;
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
            color: _hovered ? AppColors.primary : AppColors.cardBorder,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _roleCompany(exp),
                      const SizedBox(height: 10),
                      _periodBadge(exp),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _roleCompany(exp)),
                      _periodBadge(exp),
                    ],
                  ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 16),
            // Description
            Text(
              exp.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: exp.tags
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.greenTint,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          t,
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleCompany(ExperienceModel exp) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.role,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp.company,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      );

  Widget _periodBadge(ExperienceModel exp) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: exp.isCurrent ? AppColors.greenTint : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: exp.isCurrent ? AppColors.primary.withValues(alpha: 0.4) : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (exp.isCurrent) ...[
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              exp.period,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: exp.isCurrent ? AppColors.primaryDark : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
}

class _EducationCard extends StatelessWidget {
  final EducationModel edu;
  const _EducationCard({required this.edu});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
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
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.institution,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      edu.period,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          edu.degree,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          edu.institution,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        edu.period,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.cardBorder, height: 1),
          const SizedBox(height: 16),
          Text(
            edu.details,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
