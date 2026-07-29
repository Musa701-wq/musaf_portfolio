import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'utils/theme_colors.dart';
import 'utils/theme_provider.dart';
import 'widgets/navbar.dart';
import 'widgets/splash_screen.dart';
import 'screens/home_page.dart';
import 'screens/projects_page.dart';
import 'screens/skills_page.dart';
import 'screens/experience_page.dart';
import 'screens/contact_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      notifier: _themeNotifier,
      child: AnimatedBuilder(
        animation: _themeNotifier,
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Musaf Ali | Portfolio',
          theme: _themeNotifier.isDark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          home: const _AppEntry(),
        ),
      ),
    );
  }
}

class _AppEntry extends StatefulWidget {
  const _AppEntry();

  @override
  State<_AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<_AppEntry> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return SplashScreen(onDone: () => setState(() => _loaded = true));
    }
    return const MainShell();
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  int _prevIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    ProjectsPage(),
    SkillsPage(),
    ExperiencePage(),
    ContactPage(),
  ];


  void _onTabChanged(int i) {
    setState(() {
      _prevIndex = _currentIndex;
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);
    final goingRight = _currentIndex > _prevIndex;

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          PortfolioNavbar(
            currentIndex: _currentIndex,
            onTabChanged: _onTabChanged,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, anim) {
                final begin = Offset(goingRight ? 0.05 : -0.05, 0);
                return FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: begin,
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                        parent: anim, curve: Curves.easeOutCubic)),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(_currentIndex),
                child: _screens[_currentIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
