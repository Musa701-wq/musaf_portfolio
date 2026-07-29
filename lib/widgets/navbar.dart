import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/data.dart';

class PortfolioNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const PortfolioNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  static const List<String> _tabs = [
    "Portfolio",
    "Projects",
    "Skills",
    "Experience",
    "Contact"
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
      child: Row(
        children: [
          // Logo with green dot accent
          GestureDetector(
            onTap: () => onTabChanged(0),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "MUSAF.DEV",
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (!isMobile)
            Row(
              children: List.generate(_tabs.length, (i) {
                final active = i == currentIndex;
                return GestureDetector(
                  onTap: () => onTabChanged(i),
                  child: _NavTab(label: _tabs[i], active: active),
                );
              }),
            ),
          const SizedBox(width: 20),
          // Hire Me with hover
          _HireMeButton(),
          if (isMobile) ...[
            const SizedBox(width: 10),
            PopupMenuButton<int>(
              color: Colors.white,
              elevation: 4,
              icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 22),
              onSelected: onTabChanged,
              itemBuilder: (_) => List.generate(
                _tabs.length,
                (i) => PopupMenuItem(
                  value: i,
                  child: Text(
                    _tabs[i],
                    style: GoogleFonts.inter(
                      color: i == currentIndex ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: i == currentIndex ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavTab extends StatefulWidget {
  final String label;
  final bool active;
  const _NavTab({required this.label, required this.active});

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: widget.active
              ? AppColors.greenTint
              : _hovered
                  ? AppColors.surface
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.active
                ? AppColors.primary.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            color: widget.active
                ? AppColors.primaryDark
                : _hovered
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
            fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }
}

class _HireMeButton extends StatefulWidget {
  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse("mailto:${PortfolioData.email}");
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primaryDark : AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _hovered ? 0.35 : 0.2),
                blurRadius: _hovered ? 12 : 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Text(
            "Hire Me",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

