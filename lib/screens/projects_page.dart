import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/data.dart';
import '../models/portfolio_models.dart';
import '../widgets/footer.dart';
import '../widgets/animations.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String _selectedCategory = "All";
  String _searchQuery = "";

  final List<String> _categories = [
    "All",
    "iOS",
    "Android",
    "AI & ML",
    "Firebase",
    "Healthcare"
  ];

  List<ProjectModel> get _filteredProjects {
    return PortfolioData.projects.where((p) {
      final matchesCategory = _selectedCategory == "All" ||
          p.platform.toLowerCase().contains(_selectedCategory.toLowerCase()) ||
          p.tags.any((t) => t.toLowerCase().contains(_selectedCategory.toLowerCase())) ||
          p.techStack.toLowerCase().contains(_selectedCategory.toLowerCase());

      final matchesSearch = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.techStack.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final isTablet = w >= 768 && w < 1100;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
                          "PROVEN PRODUCTION WORK",
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
                    "Featured Projects",
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
                    width: 680,
                    child: Text(
                      "Explore 9 production-grade applications featuring Gemini AI, NFC tracking, REST API integrations, Stripe payments, Firebase Auth, and App Store/Play Store deployments.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 14 : 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Search Bar
                FadeSlideIn(
                  delay: const Duration(milliseconds: 220),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 680),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: "Search by project name, tech stack (AI, Stripe, NFC)...",
                        hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
                        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Category Filter Chips
                FadeSlideIn(
                  delay: const Duration(milliseconds: 280),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: _categories.map((cat) {
                      final selected = cat == _selectedCategory;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: selected,
                        onSelected: (val) {
                          if (val) setState(() => _selectedCategory = cat);
                        },
                        labelStyle: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: selected ? AppColors.primary : AppColors.cardBorder,
                          ),
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Projects Grid
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : w * 0.08,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Showing ${_filteredProjects.length} of ${PortfolioData.projects.length} Projects",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (_selectedCategory != "All" || _searchQuery.isNotEmpty)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedCategory = "All";
                            _searchQuery = "";
                          });
                        },
                        icon: const Icon(Icons.clear, size: 16, color: AppColors.primary),
                        label: Text(
                          "Reset Filters",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_filteredProjects.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(60),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.folder_off_outlined, size: 48, color: AppColors.textMuted),
                        const SizedBox(height: 16),
                        Text(
                          "No projects match your search criteria",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Try searching for another technology like Flutter, AI, or Firebase.",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: _filteredProjects.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final proj = entry.value;
                          return SizedBox(
                            width: itemWidth,
                            child: FadeSlideIn(
                              delay: Duration(milliseconds: (idx % 6) * 70),
                              child: Card3DTilt(
                                glowColor: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                                child: _ProjectCard(project: proj),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
              ],
            ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

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
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: _hovered ? 20 : 8,
              offset: Offset(0, _hovered ? 8 : 2),
            )
          ],
        ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Platform & Badge Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.greenTint,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          p.platform.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      if (p.link != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Text(
                            "Live Store",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    p.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    p.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tech Stack Badge
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Text(
                      p.techStack,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Action button
                  Row(
                    children: [
                      if (p.link != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(p.link!);
                              if (await canLaunchUrl(uri)) await launchUrl(uri);
                            },
                            icon: const Icon(Icons.launch, size: 14),
                            label: Text(
                              "Open Store Page",
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.check, size: 14),
                            label: Text(
                              "Production Ready",
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(color: AppColors.cardBorder),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
