import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme_colors.dart';
import '../utils/data.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 60, vertical: 40),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.cardBorder)),
      ),
      child: isMobile ? _mobile(c) : _desktop(c),
    );
  }

  Widget _desktop(AppThemeColors c) => Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Brand
          Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("MUSAF.DEV",
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.w800,
                    color: c.textPrimary, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text("Associate Flutter Developer\nbuilding cross-platform apps\nwith Flutter & AI.",
                style: GoogleFonts.inter(
                    fontSize: 13, color: c.textSecondary, height: 1.7)),
            const SizedBox(height: 16),
            Row(children: [
              _iconLink(Icons.mail_outline_rounded, "mailto:${PortfolioData.email}", c),
              const SizedBox(width: 10),
              _iconLink(Icons.link_rounded, PortfolioData.linkedin, c),
              const SizedBox(width: 10),
              _iconLink(Icons.code_rounded, PortfolioData.github, c),
            ]),
          ])),
          const SizedBox(width: 40),
          // Nav
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Navigation",
                style: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w700, color: c.textPrimary)),
            const SizedBox(height: 12),
            _HoverNavLink(label: "Portfolio", c: c),
            _HoverNavLink(label: "Projects", c: c),
            _HoverNavLink(label: "Skills", c: c),
            _HoverNavLink(label: "Experience", c: c),
            _HoverNavLink(label: "Contact", c: c),
          ])),
          // Contact
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Contact",
                style: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w700, color: c.textPrimary)),
            const SizedBox(height: 12),
            _infoRow(Icons.location_on_outlined, "Gujrat, Pakistan", c),
            const SizedBox(height: 8),
            _infoRow(Icons.mail_outline_rounded, PortfolioData.email, c),
            const SizedBox(height: 8),
            _infoRow(Icons.phone_outlined, PortfolioData.phone, c),
            const SizedBox(height: 10),
            Row(children: [
              Container(width: 7, height: 7,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: c.accentGreen)),
              const SizedBox(width: 6),
              Text("Available for work",
                  style: GoogleFonts.inter(
                      fontSize: 12, color: c.accentGreen, fontWeight: FontWeight.w500)),
            ]),
          ])),
        ]),
        const SizedBox(height: 32),
        Divider(color: c.cardBorder),
        const SizedBox(height: 16),
        Row(children: [
          Text("© 2026 Musaf Ali. All rights reserved.",
              style: GoogleFonts.inter(fontSize: 12, color: c.textSecondary)),
          const Spacer(),
          Text("Built with Flutter",
              style: GoogleFonts.jetBrainsMono(fontSize: 11, color: c.primary)),
        ]),
      ]);

  Widget _mobile(AppThemeColors c) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("MUSAF.DEV",
            style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.w800, color: c.textPrimary)),
        const SizedBox(height: 6),
        Text("Associate Flutter Developer",
            style: GoogleFonts.inter(fontSize: 13, color: c.textSecondary)),
        const SizedBox(height: 16),
        Row(children: [
          _iconLink(Icons.mail_outline_rounded, "mailto:${PortfolioData.email}", c),
          const SizedBox(width: 10),
          _iconLink(Icons.link_rounded, PortfolioData.linkedin, c),
          const SizedBox(width: 10),
          _iconLink(Icons.code_rounded, PortfolioData.github, c),
        ]),
        const SizedBox(height: 24),
        Divider(color: c.cardBorder),
        const SizedBox(height: 16),
        Text("© 2026 Musaf Ali. All rights reserved.",
            style: GoogleFonts.inter(fontSize: 12, color: c.textSecondary)),
      ]);

  Widget _infoRow(IconData icon, String text, AppThemeColors c) =>
      Row(children: [
        Icon(icon, size: 13, color: c.textSecondary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(text,
              style: GoogleFonts.inter(fontSize: 12, color: c.textSecondary),
              overflow: TextOverflow.ellipsis),
        ),
      ]);

  Widget _iconLink(IconData icon, String url, AppThemeColors c) =>
      GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: c.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.cardBorder),
          ),
          child: Icon(icon, size: 16, color: c.primary),
        ),
      );
}

class _HoverNavLink extends StatefulWidget {
  final String label;
  final AppThemeColors c;
  const _HoverNavLink({required this.label, required this.c});

  @override
  State<_HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<_HoverNavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.inter(
            fontSize: 13,
            color: _hovered ? widget.c.primary : widget.c.textSecondary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
