import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/portfolio_models.dart';

class PortfolioData {
  static const String name = "Musaf Ali";
  static const String nameTag = "MUSAF.DEV";
  static const String location = "Gujrat, Pakistan";
  static const String phone = "0341-4879548";
  static const String email = "musafali0049@gmail.com";
  static const String linkedin = "https://www.linkedin.com/in/musaf-ali-902a6821b";
  static const String github = "https://github.com/Musa701-wq";

  static const String heroTitle = "Building Cross-Platform\nApps with Flutter & AI";
  static const String heroSubtitle =
      "Associate Flutter Developer specializing in high-performance mobile applications, Firebase integrations, and intelligent AI-powered features.";

  static const String summary =
      "Associate Flutter Developer with hands-on experience in building cross-platform mobile applications for Android and iOS. Strong expertise in Flutter and Dart with practical experience in MVC architecture, GetX state management, RESTful API integration, Firebase services, push notifications, analytics, and app monetization including In-App Purchases and AdMob. Experienced in deploying production-ready applications to the Apple App Store and Google Play Store.";

  static const List<String> terminalLines = [
    "Initializing flutter_engine...",
    "Loading GetX state management...",
    "Connecting Firebase services...",
    "AI integration synchronized.",
  ];

  static final List<SkillModel> skills = [
    // Core
    SkillModel(name: "Flutter", icon: FontAwesomeIcons.flutter, level: 0.90, category: "Core"),
    SkillModel(name: "Dart", icon: FontAwesomeIcons.code, level: 0.88, category: "Core"),
    SkillModel(name: "MVC Architecture", icon: FontAwesomeIcons.layerGroup, level: 0.85, category: "Core"),
    SkillModel(name: "GetX", icon: FontAwesomeIcons.bolt, level: 0.87, category: "Core"),
    // Backend & Cloud
    SkillModel(name: "Firebase Auth", icon: FontAwesomeIcons.fire, level: 0.88, category: "Backend"),
    SkillModel(name: "Firebase FCM", icon: FontAwesomeIcons.bell, level: 0.82, category: "Backend"),
    SkillModel(name: "REST APIs", icon: FontAwesomeIcons.server, level: 0.85, category: "Backend"),
    SkillModel(name: "SQLite / Hive", icon: FontAwesomeIcons.database, level: 0.80, category: "Backend"),
    // Monetization & AI
    SkillModel(name: "In-App Purchases", icon: FontAwesomeIcons.cartShopping, level: 0.85, category: "Monetization"),
    SkillModel(name: "Google AdMob", icon: FontAwesomeIcons.google, level: 0.83, category: "Monetization"),
    SkillModel(name: "Stripe Payments", icon: FontAwesomeIcons.stripeS, level: 0.80, category: "Monetization"),
    SkillModel(name: "Gemini AI API", icon: FontAwesomeIcons.robot, level: 0.78, category: "AI"),
    // Maps & Tools
    SkillModel(name: "Google Maps", icon: FontAwesomeIcons.mapLocationDot, level: 0.82, category: "Tools"),
    SkillModel(name: "Git", icon: FontAwesomeIcons.github, level: 0.85, category: "Tools"),
    SkillModel(name: "Android & iOS Deploy", icon: FontAwesomeIcons.mobileScreen, level: 0.88, category: "Tools"),
  ];

  static final List<ExperienceModel> experience = [
    ExperienceModel(
      role: "Associate Flutter Developer",
      company: "Sabasoft Games Studio — On-site",
      period: "Oct 2025 – Present",
      description:
          "Working on iOS and Android applications focusing on UI development, third-party integrations, analytics, monetization, and AI-based features. Implementing authentication systems, payments, advertisements, push notifications, and maintaining clean scalable architecture.",
      isCurrent: true,
      tags: ["Flutter", "GetX", "Firebase", "AdMob", "AI"],
    ),
    ExperienceModel(
      role: "Flutter Intern & Junior Developer",
      company: "RapidRise Tech — Remote",
      period: "Jan 2025 – Oct 2025",
      description:
          "Developed UI modules, integrated REST APIs, implemented maps, payments, Firebase services, notifications, and assisted in App Store & Play Store deployment workflows.",
      tags: ["Flutter", "REST APIs", "Google Maps", "Stripe", "Firebase"],
    ),
  ];

  static final List<ProjectModel> projects = [
    ProjectModel(
      title: "Renovate AI",
      description:
          "AI-powered home decor app for redesigning interior/exterior spaces using Gemini AI. Features wall painting, floor redesign, object removal, and reference-based image transformations.",
      techStack: "Flutter • Gemini AI • Firebase • In-App Purchases • AdMob",
      platform: "iOS",
      link: "https://apps.apple.com/pk/app/renovate-ai-smart-home-decor/id6756610861",
      tags: ["Gemini AI", "Flutter", "AdMob"],
    ),
    ProjectModel(
      title: "Code Course",
      description:
          "Educational app with structured programming courses in HTML, CSS, JS, Java, Python, C#. Progress tracking, analytics, and premium content via In-App Purchases.",
      techStack: "Flutter • Firebase • Realtime DB • Analytics • IAP",
      platform: "iOS",
      link: "https://apps.apple.com/pk/app/code-course-learn-to-code/id6755722567",
      tags: ["Firebase", "Flutter", "IAP"],
    ),
    ProjectModel(
      title: "Golumo – EV Charging",
      description:
          "EV charging station finder and booking app with real-time navigation, session booking, and secure Stripe payments.",
      techStack: "Flutter • Google Maps • Stripe • Firebase • REST APIs",
      platform: "Android",
      link: "https://play.google.com/store/apps/details?id=com.go.lumo1",
      tags: ["Google Maps", "Stripe", "Firebase"],
    ),
    ProjectModel(
      title: "PlantEyes",
      description:
          "AI plant identification and care management app with automated care reminders, disease detection, and a comprehensive plant knowledge database.",
      techStack: "Flutter • AI Recognition • Firebase • REST APIs",
      platform: "iOS",
      link: null,
      tags: ["AI", "Flutter", "Firebase"],
    ),
    ProjectModel(
      title: "IntelliDocs AI",
      description:
          "AI-powered PDF reader that transforms documents into interactive learning tools with summaries, quizzes, notes, and intelligent Q&A.",
      techStack: "Flutter • AI Text Analysis • PDF Processing • Firebase • IAP",
      platform: "iOS",
      link: null,
      tags: ["AI", "Flutter", "IAP"],
    ),
    ProjectModel(
      title: "SmartSole",
      description:
          "Virtual AI shoe try-on app allowing users to preview footwear on their own photos. Realistic AI visualization, personalized recommendations, and monetization.",
      techStack: "Flutter • AI Visualization • Firebase • REST APIs • AdMob",
      platform: "iOS",
      link: null,
      tags: ["AI", "Flutter", "AdMob"],
    ),
    ProjectModel(
      title: "PneumoScan",
      description:
          "Final Year Project — AI healthcare app for pneumonia detection via chest X-ray analysis. Secure image upload, ML inference, and medical-grade privacy interface.",
      techStack: "Flutter • Machine Learning • REST APIs • Firebase",
      platform: "Mobile",
      link: null,
      tags: ["ML", "Flutter", "Healthcare"],
    ),
  ];
}
