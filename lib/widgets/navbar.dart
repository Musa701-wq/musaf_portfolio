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
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 900;

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A), // Dark Slate
        border: Border(
          bottom: BorderSide(color: Color(0xFF1E293B), width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 36),
      child: Row(
        children: [
          // Logo with green dot accent & badge
          GestureDetector(
            onTap: () => onTabChanged(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "MUSAF.DEV",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (!isMobile)
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_tabs.length, (i) {
                    final active = i == currentIndex;
                    return GestureDetector(
                      onTap: () => onTabChanged(i),
                      child: _NavTab(label: _tabs[i], active: active),
                    );
                  }),
                ),
              ),
            ),
          if (!isMobile) const SizedBox(width: 16),
          // Hire Me with hover
          _HireMeButton(),
          if (isMobile) ...[
            const SizedBox(width: 8),
            PopupMenuButton<int>(
              color: const Color(0xFF1E293B),
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
              onSelected: onTabChanged,
              itemBuilder: (_) => List.generate(
                _tabs.length,
                (i) => PopupMenuItem(
                  value: i,
                  child: Text(
                    _tabs[i],
                    style: GoogleFonts.inter(
                      color: i == currentIndex ? AppColors.primary : Colors.white70,
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
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: widget.active
              ? AppColors.primary.withValues(alpha: 0.15)
              : _hovered
                  ? const Color(0xFF1E293B)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.active
                ? AppColors.primary
                : _hovered
                    ? Colors.white24
                    : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            color: widget.active
                ? AppColors.primaryLight
                : _hovered
                    ? Colors.white
                    : Colors.white70,
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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse("mailto:${PortfolioData.email}");
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: _hovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            gradient: AppGradients.button,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _hovered ? 0.5 : 0.25),
                blurRadius: _hovered ? 14 : 6,
                offset: Offset(0, _hovered ? 4 : 2),
              )
            ],
          ),
          child: Text(
            "Hire Me",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

