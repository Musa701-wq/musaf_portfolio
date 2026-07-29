import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/portfolio_models.dart';

class PortfolioData {
  static const String name = "Musaf Ali";
  static const String nameTag = "MUSAF.DEV";
  static const String location = "Johar Town Lahore, Pakistan";
  static const String phone = "0341-4879548";
  static const String email = "musafali0049@gmail.com";
  static const String linkedin = "https://www.linkedin.com/in/musaf-ali-902a6821b";
  static const String github = "https://github.com/Musa701-wq";

  static const String heroTitle = "Building Production-Ready\nApps with Flutter & AI";
  static const String heroSubtitle =
      "Associate Flutter Developer with 1.5+ years of hands-on experience building high-performance cross-platform mobile apps for iOS & Android with GetX, Firebase, APIs, AdMob, and Gemini AI.";

  static const String summary =
      "Associate Flutter Developer with more than 1.5 year of hands-on experience in building cross-platform mobile applications for Android and iOS. Strong expertise in Flutter and Dart with practical experience in MVC architecture, GetX state management, RESTful API integration, Firebase services, analytics, and app monetization including In-App Purchases and AdMob. Experienced in developing clean, scalable, and production-ready mobile applications.";

  static const List<String> terminalLines = [
    "Initializing flutter_engine v3.22...",
    "Loading GetX state management & MVC...",
    "Connecting Firebase & REST API Gateways...",
    "Gemini AI & NFC Modules Synchronized.",
    "STATUS: 9 PRODUCTION APPS READY.",
  ];

  static final List<EducationModel> education = [
    EducationModel(
      degree: "Bachelor of Science in Software Engineering",
      institution: "University of Gujrat, Pakistan",
      period: "Nov 2021 – July 2025",
      location: "Gujrat, Pakistan",
      details:
          "Specialized in Software Architecture, Mobile App Engineering, Artificial Intelligence, and Database Systems. Developed PneumoScan AI as Final Year Project.",
    ),
  ];

  static final List<SkillModel> skills = [
    // Languages & Frameworks
    SkillModel(name: "Flutter", icon: FontAwesomeIcons.flutter, level: 0.92, category: "Core Framework"),
    SkillModel(name: "Dart", icon: FontAwesomeIcons.code, level: 0.90, category: "Core Framework"),
    // Architecture & State Management
    SkillModel(name: "MVC Architecture", icon: FontAwesomeIcons.layerGroup, level: 0.88, category: "Architecture"),
    SkillModel(name: "GetX State Management", icon: FontAwesomeIcons.bolt, level: 0.90, category: "Architecture"),
    // Backend & APIs
    SkillModel(name: "RESTful APIs", icon: FontAwesomeIcons.server, level: 0.88, category: "Backend & APIs"),
    SkillModel(name: ".NET Backend Integration", icon: FontAwesomeIcons.microsoft, level: 0.82, category: "Backend & APIs"),
    SkillModel(name: "Node.js Integration", icon: FontAwesomeIcons.nodeJs, level: 0.80, category: "Backend & APIs"),
    // Firebase Services
    SkillModel(name: "Firebase Auth", icon: FontAwesomeIcons.fire, level: 0.90, category: "Firebase Services"),
    SkillModel(name: "Firebase Analytics", icon: FontAwesomeIcons.chartLine, level: 0.85, category: "Firebase Services"),
    SkillModel(name: "Realtime Database", icon: FontAwesomeIcons.database, level: 0.86, category: "Firebase Services"),
    SkillModel(name: "Push Notifications (FCM)", icon: FontAwesomeIcons.bell, level: 0.88, category: "Firebase Services"),
    // Auth
    SkillModel(name: "Google & Apple Login", icon: FontAwesomeIcons.shieldHalved, level: 0.88, category: "Authentication"),
    // Monetization & Payments
    SkillModel(name: "In-App Purchases (IAP)", icon: FontAwesomeIcons.cartShopping, level: 0.88, category: "Monetization"),
    SkillModel(name: "Google AdMob", icon: FontAwesomeIcons.rectangleAd, level: 0.86, category: "Monetization"),
    SkillModel(name: "Stripe Payments", icon: FontAwesomeIcons.stripeS, level: 0.82, category: "Monetization"),
    // AI & Advanced Features
    SkillModel(name: "Gemini AI API", icon: FontAwesomeIcons.robot, level: 0.85, category: "AI & Advanced"),
    SkillModel(name: "NFC Token Scanning", icon: FontAwesomeIcons.nfcSymbol, level: 0.84, category: "AI & Advanced"),
    SkillModel(name: "AI Image Processing", icon: FontAwesomeIcons.wandMagicSparkles, level: 0.82, category: "AI & Advanced"),
    SkillModel(name: "PDF Generation & Sharing", icon: FontAwesomeIcons.filePdf, level: 0.85, category: "AI & Advanced"),
    SkillModel(name: "Local Notifications", icon: FontAwesomeIcons.commentDots, level: 0.86, category: "AI & Advanced"),
    // Maps & Location
    SkillModel(name: "Google Maps API", icon: FontAwesomeIcons.mapLocationDot, level: 0.85, category: "Maps & Location"),
    SkillModel(name: "OpenStreetMap Integration", icon: FontAwesomeIcons.map, level: 0.80, category: "Maps & Location"),
    // Database & Storage
    SkillModel(name: "SQLite & Hive", icon: FontAwesomeIcons.hardDrive, level: 0.84, category: "Storage & DB"),
    // Tools
    SkillModel(name: "Git & GitHub", icon: FontAwesomeIcons.github, level: 0.88, category: "Tools & IDES"),
    SkillModel(name: "Android Studio & VS Code", icon: FontAwesomeIcons.laptopCode, level: 0.90, category: "Tools & IDES"),
    SkillModel(name: "App Store & Play Store Deploy", icon: FontAwesomeIcons.mobileScreenButton, level: 0.88, category: "Tools & IDES"),
  ];

  static final List<ExperienceModel> experience = [
    ExperienceModel(
      role: "Associate Flutter Developer",
      company: "Sabasoft Games Studio — On-site",
      period: "Jan 2025 – Present",
      description:
          "Currently working on iOS and Android applications focusing on UI development, third-party integrations, analytics, monetization, and AI-based features. Responsible for implementing authentication systems, payments, advertisements, and maintaining clean and scalable application architecture.",
      isCurrent: true,
      tags: ["Flutter", "GetX", "Firebase", "AdMob", "AI Integration", "IAP"],
    ),
    ExperienceModel(
      role: "Flutter Intern Job",
      company: "RapidRise Tech — Remote",
      period: "Sep 2024 – Jan 2025",
      description:
          "Worked on Flutter-based applications by developing UI modules, integrating REST APIs, implementing maps, payments, and Firebase services. Gained practical experience in real-world production workflows.",
      tags: ["Flutter", "REST APIs", "Google Maps", "Stripe", "Firebase"],
    ),
  ];

  static final List<ProjectModel> projects = [
    ProjectModel(
      title: "Elite Guard – Security Monitoring System",
      description:
          "Security guard management application for monitoring activities across sites. Features NFC-based check-in/out attendance tracking, .NET REST API integration, document & site issuing management, and instant FCM push notification alerts.",
      techStack: "Flutter • Dart • NFC Integration • REST APIs • .NET Backend • Push Notifications • Firebase",
      platform: "Android / iOS",
      link: null,
      tags: ["NFC", "Flutter", ".NET", "Firebase"],
    ),
    ProjectModel(
      title: "Renovate AI – Smart Home Decor",
      description:
          "AI-powered home decor app for redesigning interior/exterior spaces using Gemini AI API for wall painting, floor redesign, object removal, space filling, and reference image transformations. Features Google/Apple Auth, Firebase Analytics, IAP, and AdMob monetization.",
      techStack: "Flutter • Dart • Gemini AI API • Firebase Auth • Analytics • In-App Purchases • AdMob • REST APIs",
      platform: "iOS App Store",
      link: "https://apps.apple.com/pk/app/renovate-ai-smart-home-decor/id6756610861",
      tags: ["Gemini AI", "iOS", "Flutter", "AdMob", "IAP"],
    ),
    ProjectModel(
      title: "LABMATE – Medical Reports & Tracker",
      description:
          "Healthcare mobile app integrated with Node.js REST APIs for medical report management, MRI/X-ray scan processing, medicine tracking with local notification reminders, patient history, report sharing, and PDF export functionality.",
      techStack: "Flutter • Dart • Node.js Backend • REST APIs • PDF Generation • Local Notifications",
      platform: "Android / iOS",
      link: null,
      tags: ["Healthcare", "Node.js", "Flutter", "PDF Export"],
    ),
    ProjectModel(
      title: "Code Course – Programming Learning App",
      description:
          "Educational mobile app offering structured programming courses in HTML, CSS, JavaScript, Java, Python, and C#. Features progress tracking, Firebase Auth, Realtime DB analytics, and In-App Purchases for premium course unlocking.",
      techStack: "Flutter • Dart • Firebase Auth • Realtime DB • Analytics • In-App Purchases • Local Storage",
      platform: "iOS App Store",
      link: "https://apps.apple.com/pk/app/code-course-learn-to-code/id6755722567",
      tags: ["Education", "iOS", "Firebase", "IAP"],
    ),
    ProjectModel(
      title: "Golumo – EV Station Finder & Booking",
      description:
          "EV charging station finder and session booking app featuring Google Maps API real-time location tracking and navigation, Stripe payment gateway for transactions, Firebase services, and REST APIs for station availability.",
      techStack: "Flutter • Dart • Google Maps API • Stripe Gateway • Firebase Services • REST APIs",
      platform: "Google Play Store",
      link: "https://play.google.com/store/apps/details?id=com.go.lumo1",
      tags: ["Google Maps", "Stripe", "Android", "Firebase"],
    ),
    ProjectModel(
      title: "PlantEyes – AI Plant Identifier & Care",
      description:
          "AI-powered mobile app for plant species identification and disease diagnosis via image analysis. Includes automated care scheduling with watering/fertilizing reminders, plant knowledge database, Firebase notifications, and REST APIs.",
      techStack: "Flutter • Dart • AI Image Recognition • Firebase • REST APIs • Local Notifications",
      platform: "iOS App Store",
      link: "https://apps.apple.com/pk/app/planteyes-ai-plant-identifier/id6755722567",
      tags: ["AI Recognition", "iOS", "Flutter", "Firebase"],
    ),
    ProjectModel(
      title: "IntelliDocs AI – AI PDF Reader & Assistant",
      description:
          "AI document analysis app transforming PDFs into interactive learning tools with instant AI summaries, auto-generated quizzes, smart notes, Q&A assistant, Firebase user management, and In-App Purchases.",
      techStack: "Flutter • Dart • AI Text Analysis • PDF Processing • Firebase • In-App Purchases • SQLite",
      platform: "iOS App Store",
      link: null,
      tags: ["AI Text Analysis", "iOS", "Flutter", "IAP"],
    ),
    ProjectModel(
      title: "RevivePix – AI Photo Enhancer",
      description:
          "AI photo restoration app repairing blurry, damaged, scratched, and low-quality images using AI face enhancement, scratch removal, colorization, high-res export, Firebase Analytics, and In-App Purchases.",
      techStack: "Flutter • Dart • AI Image Processing • Firebase Auth • Analytics • In-App Purchases • REST APIs",
      platform: "iOS App Store",
      link: null,
      tags: ["AI Image Processing", "iOS", "Flutter", "IAP"],
    ),
    ProjectModel(
      title: "PneumoScan – AI Pneumonia Detection",
      description:
          "Final Year Project — Healthcare AI mobile app for pneumonia detection via chest X-ray image analysis. Integrates machine learning models via secure REST APIs, HIPAA-compliant medical UI design, and secure cloud storage.",
      techStack: "Flutter • Dart • Machine Learning Integration • REST APIs • Firebase • Medical Security",
      platform: "Mobile FYP",
      link: null,
      tags: ["Machine Learning", "Healthcare", "Flutter", "FYP"],
    ),
  ];
}
