import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/footer.dart';
import '../widgets/animations.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Group skills by category
    final Map<String, List<SkillModel>> groupedSkills = {};
    for (var s in PortfolioData.skills) {
      groupedSkills.putIfAbsent(s.category, () => []).add(s);
    }

    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final isTablet = w >= 768 && w < 1100;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);

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
                          "TECHNICAL PROFICIENCY",
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
                    "Skills & Core Expertise",
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
                      "Comprehensive technical stack across cross-platform mobile development, MVC & GetX state management, REST APIs, Firebase cloud, payments, and artificial intelligence.",
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

          // Categories Grid
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : w * 0.08,
              vertical: 40,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
                final categoriesList = groupedSkills.entries.toList();

                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: categoriesList.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final catName = entry.value.key;
                    final skillsList = entry.value.value;

                    return SizedBox(
                      width: itemWidth,
                      child: FadeSlideIn(
                        delay: Duration(milliseconds: (idx % 6) * 80),
                        child: Card3DTilt(
                          glowColor: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          child: _SkillCategoryCard(
                            categoryName: catName,
                            skills: skillsList,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String categoryName;
  final List<SkillModel> skills;
  const _SkillCategoryCard({required this.categoryName, required this.skills});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AnimatedContainer(
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
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Colors.black.withValues(alpha: 0.03),
                    blurRadius: _hovered ? 20 : 8,
                    offset: Offset(0, _hovered ? 8 : 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.greenTint,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.skills.first.icon,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          widget.categoryName,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppColors.cardBorder, height: 1),
                  const SizedBox(height: 16),
                  // Skill Items
                  Column(
                    children: widget.skills.map((skill) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(skill.icon, size: 14, color: AppColors.primary),
                                    const SizedBox(width: 8),
                                    Text(
                                      skill.name,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${(skill.level * 100).toInt()}%",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Progress Bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: skill.level,
                                minHeight: 5,
                                backgroundColor: AppColors.surface,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _hovered ? 6 : 4,
                decoration: const BoxDecoration(
                  gradient: AppGradients.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
