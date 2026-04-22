import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/data.dart';
import '../widgets/footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String _selectedProject = "Flutter Application Development";

  static const List<String> _projectOptions = [
    "Flutter Application Development",
    "AI Integration",
    "Firebase Backend",
    "UI/UX Consultation",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── HEADER ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                isMobile ? 24 : 60, 48, isMobile ? 24 : 60, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's build something amazing\ntogether.",
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cardBorder),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.terminal_rounded,
                        size: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "SYSTEM_READY: WAITING_FOR_INPUT",
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 6),
                  // blinking cursor
                  Container(
                    width: 8,
                    height: 16,
                    color: AppColors.primary,
                  ),
                ]),
              ],
            ),
          ),

          // ── MAIN CONTENT ──
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 60, vertical: 0),
            child: isMobile
                ? Column(children: [
                    _FormCard(
                      selectedProject: _selectedProject,
                      projectOptions: _projectOptions,
                      onProjectChanged: (v) =>
                          setState(() => _selectedProject = v!),
                    ),
                    const SizedBox(height: 20),
                    const _DossierCard(),
                    const SizedBox(height: 20),
                    _InfoCards(isMobile: isMobile),
                  ])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(children: [
                          _FormCard(
                            selectedProject: _selectedProject,
                            projectOptions: _projectOptions,
                            onProjectChanged: (v) =>
                                setState(() => _selectedProject = v!),
                          ),
                          const SizedBox(height: 16),
                          _InfoCards(isMobile: isMobile),
                        ]),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(
                        flex: 4,
                        child: _DossierCard(),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 60),
          const PortfolioFooter(),
        ],
      ),
    );
  }
}

// ── FORM CARD ──────────────────────────────────────────────────────────────────
class _FormCard extends StatelessWidget {
  final String selectedProject;
  final List<String> projectOptions;
  final ValueChanged<String?> onProjectChanged;

  const _FormCard({
    required this.selectedProject,
    required this.projectOptions,
    required this.onProjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text("Establish Connection",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const Spacer(),
          Icon(Icons.alternate_email_rounded,
              color: AppColors.textMuted.withValues(alpha: 0.4), size: 40),
        ]),
        const SizedBox(height: 24),
        // Name + Email row
        Row(children: [
          Expanded(child: _inputField("IDENTIFIER_NAME", "Musaf Ali")),
          const SizedBox(width: 16),
          Expanded(child: _inputField("CONTACT_EMAIL", "musaf@ai.dev")),
        ]),
        const SizedBox(height: 16),
        // Project dropdown
        _fieldLabel("PROJECT_PARAMETERS"),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedProject,
              isExpanded: true,
              dropdownColor: AppColors.card,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textPrimary),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary),
              items: projectOptions
                  .map((o) => DropdownMenuItem(
                      value: o,
                      child: Text(o,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textPrimary))))
                  .toList(),
              onChanged: onProjectChanged,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Message
        _fieldLabel("TRANSMISSION_BODY"),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: TextField(
            maxLines: 5,
            style: GoogleFonts.inter(
                fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: "Define your vision...",
              hintStyle: GoogleFonts.inter(
                  fontSize: 14, color: AppColors.textMuted),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Send button
        GestureDetector(
          onTap: () async {
            final uri = Uri.parse("mailto:${PortfolioData.email}");
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("SEND TRANSMISSION",
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1)),
              const SizedBox(width: 10),
              const Icon(Icons.send_rounded, color: Colors.white, size: 16),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _fieldLabel(String label) => Text(label,
      style: GoogleFonts.jetBrainsMono(
          fontSize: 10,
          color: AppColors.textSecondary,
          letterSpacing: 0.8));

  Widget _inputField(String label, String hint) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(label),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: TextField(
              style: GoogleFonts.inter(
                  fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.textMuted),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
            ),
          ),
        ],
      );
}

// ── INFO CARDS (location + uptime) ────────────────────────────────────────────
class _InfoCards extends StatelessWidget {
  final bool isMobile;
  const _InfoCards({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _infoCard(
          Icons.location_on_outlined,
          "LOCAL_COORDINATES",
          PortfolioData.location,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _infoCard(
          Icons.access_time_rounded,
          "CURRENT_UPTIME",
          "GMT +5 (Available)",
        ),
      ),
    ]);
  }

  Widget _infoCard(IconData icon, String label, String value) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
          ]),
        ]),
      );
}

// ── DOSSIER CARD ──────────────────────────────────────────────────────────────
class _DossierCard extends StatelessWidget {
  const _DossierCard();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Technical Dossier
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text("Technical Dossier",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Text("ENCRYPTED",
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5)),
            ),
          ]),
          const SizedBox(height: 20),
          // Experience summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  width: 1),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("EXPERIENCE_SUMMARY",
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: AppColors.primary,
                          letterSpacing: 0.5)),
                  const SizedBox(height: 8),
                  Text(
                    "Associate Flutter Developer specializing in high-performance cross-platform architectures. Integrated AI features into mobile ecosystems. Core contributor to production Dart libraries.",
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.6),
                  ),
                ]),
          ),
          const SizedBox(height: 16),
          // Core architecture
          Text("CORE_ARCHITECTURE",
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ["Flutter SDK", "Dart", "Firebase", "GetX", "gRPC"]
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(t,
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: AppColors.textSecondary)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          // Download Resume
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse("mailto:${PortfolioData.email}");
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.download_rounded,
                        color: AppColors.textPrimary, size: 18),
                    const SizedBox(width: 10),
                    Text("Download Resume",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    const SizedBox(width: 8),
                    Text("PDF",
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 10,
                            color: AppColors.textSecondary)),
                  ]),
            ),
          ),
        ]),
      ),
      const SizedBox(height: 16),
      // Map card
      Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(fit: StackFit.expand, children: [
            Image.network(
              "https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800&q=60",
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.55),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.surface),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GEO_LOCATING...",
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text("GUJRAT, PAKISTAN",
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ]),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 16),
      // Node status card
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("NODE_STATUS: ACTIVE",
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text("Response time: < 4 hours",
                style: GoogleFonts.inter(
                    fontSize: 11, color: AppColors.textSecondary)),
          ]),
          const Spacer(),
          const Icon(Icons.image_outlined,
              size: 16, color: AppColors.textMuted),
          const SizedBox(width: 12),
          const Icon(Icons.code_rounded,
              size: 16, color: AppColors.textMuted),
        ]),
      ),
    ]);
  }
}
