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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedService = "Flutter Mobile Application";
  bool _submitted = false;

  static const List<String> _services = [
    "Flutter Mobile Application",
    "AI & Gemini API Integration",
    "Firebase & Backend Setup",
    "App Store & Play Store Deployment",
    "Consultation & Code Review",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 850;

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
                Container(
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
                        "GET IN TOUCH",
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
                const SizedBox(height: 16),
                Text(
                  "Let's Build Something Great",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 42,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 620,
                  child: Text(
                    "Have a new mobile application idea, AI feature request, or open job role? Reach out directly via email, phone, or message below.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Contact Content
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 1100),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: 50,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildContactInfoGrid(context),
                      const SizedBox(height: 32),
                      _buildMessageForm(context),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildContactInfoGrid(context)),
                      const SizedBox(width: 40),
                      Expanded(flex: 6, child: _buildMessageForm(context)),
                    ],
                  ),
          ),

          const PortfolioFooter(),
        ],
      ),
    );
  }

  Widget _buildContactInfoGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Information",
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Based in Johar Town Lahore, Pakistan. Available for full-time roles, contract work, and consulting.",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),

        // Info Cards
        _ContactDetailTile(
          icon: Icons.location_on_outlined,
          title: "Location",
          value: PortfolioData.location,
          subtitle: "Johar Town, Lahore, Pakistan",
          onTap: null,
        ),
        const SizedBox(height: 16),
        _ContactDetailTile(
          icon: Icons.email_outlined,
          title: "Email Address",
          value: PortfolioData.email,
          subtitle: "Click to send direct email",
          onTap: () async {
            final uri = Uri.parse("mailto:${PortfolioData.email}");
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        const SizedBox(height: 16),
        _ContactDetailTile(
          icon: Icons.phone_outlined,
          title: "Phone Number",
          value: PortfolioData.phone,
          subtitle: "Available for calls & WhatsApp",
          onTap: () async {
            final uri = Uri.parse("tel:${PortfolioData.phone}");
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        const SizedBox(height: 16),
        _ContactDetailTile(
          icon: Icons.link_rounded,
          title: "LinkedIn Profile",
          value: "linkedin.com/in/musaf-ali",
          subtitle: "Connect on LinkedIn",
          onTap: () async {
            final uri = Uri.parse(PortfolioData.linkedin);
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
      ],
    );
  }

  Widget _buildMessageForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: _submitted
          ? Column(
              children: [
                const Icon(Icons.check_circle_outline, size: 56, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(
                  "Message Received!",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Thank you for getting in touch. I will respond to your message shortly.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => setState(() => _submitted = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Send Another Message"),
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Send a Message",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Service Dropdown
                  Text(
                    "Selected Interest / Service",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _selectedService,
                    onChanged: (val) => setState(() => _selectedService = val!),
                    items: _services
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s, style: GoogleFonts.inter(fontSize: 13.5)),
                            ))
                        .toList(),
                    decoration: _inputDecoration("Select service category"),
                  ),
                  const SizedBox(height: 16),

                  // Name Field
                  Text(
                    "Your Name",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    validator: (v) => (v == null || v.trim().isEmpty) ? "Please enter your name" : null,
                    decoration: _inputDecoration("e.g. John Doe"),
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  Text(
                    "Your Email Address",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    validator: (v) => (v == null || !v.contains("@")) ? "Please enter a valid email" : null,
                    decoration: _inputDecoration("e.g. john@example.com"),
                  ),
                  const SizedBox(height: 16),

                  // Message Field
                  Text(
                    "Project / Job Message",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 4,
                    validator: (v) => (v == null || v.trim().isEmpty) ? "Please enter a message" : null,
                    decoration: _inputDecoration("Describe your requirements or inquiry..."),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _submitted = true);
                        }
                      },
                      icon: const Icon(Icons.send_rounded, size: 16),
                      label: Text(
                        "Submit Inquiry",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}

class _ContactDetailTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final VoidCallback? onTap;

  const _ContactDetailTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.onTap,
  });

  @override
  State<_ContactDetailTile> createState() => _ContactDetailTileState();
}

class _ContactDetailTileState extends State<_ContactDetailTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.cardBorder,
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.02),
                blurRadius: _hovered ? 12 : 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.greenTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: AppColors.primaryDark, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onTap != null)
                const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
