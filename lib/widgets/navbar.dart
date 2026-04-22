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

  static const List<String> _tabs = ["Portfolio", "Skills", "Experience", "Contact"];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      height: 56,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
      child: Row(
        children: [
          // Logo with subtle glow
          Text(
            "MUSAF.AI",
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              letterSpacing: 0.5,
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
              color: AppColors.card,
              icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 20),
              onSelected: onTabChanged,
              itemBuilder: (_) => List.generate(
                _tabs.length,
                (i) => PopupMenuItem(
                  value: i,
                  child: Text(_tabs[i],
                      style: GoogleFonts.inter(
                          color: AppColors.textPrimary, fontSize: 14)),
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
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.active
                  ? AppColors.primary
                  : _hovered
                      ? AppColors.primary.withValues(alpha: 0.4)
                      : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            color: widget.active
                ? AppColors.textPrimary
                : _hovered
                    ? AppColors.textPrimary.withValues(alpha: 0.8)
                    : AppColors.textSecondary,
            fontWeight:
                widget.active ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primaryLight
                : AppColors.primary,
            borderRadius: BorderRadius.circular(6),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]
                : [],
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
