import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/subscription/presentation/screens/subscription_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/conversion/presentation/screens/conversion_screen.dart';
import '../../features/translation/presentation/screens/translation_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/viewer/:fileId',
        name: 'viewer',
        builder: (context, state) {
          // TODO: Get file from state or provider
          // For now, using placeholder
          final fileId = state.pathParameters['fileId'] ?? '';
          // This should be replaced with actual file retrieval
          return const Scaffold(
            body: Center(child: Text('PDF Viewer - File loading...')),
          );
        },
      ),
      GoRoute(
        path: '/subscription',
        name: 'subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/ocr',
        name: 'ocr',
        builder: (context, state) {
          // TODO: Get PDF file from state
          return const Scaffold(
            body: Center(child: Text('OCR Screen - File loading...')),
          );
        },
      ),
      GoRoute(
        path: '/translation',
        name: 'translation',
        builder: (context, state) => const TranslationScreen(),
      ),
      GoRoute(
        path: '/ai-tools',
        name: 'ai-tools',
        builder: (context, state) {
          // TODO: Get PDF file from state
          return const Scaffold(
            body: Center(child: Text('AI Tools Screen - File loading...')),
          );
        },
      ),
      GoRoute(
        path: '/conversion',
        name: 'conversion',
        builder: (context, state) => const ConversionScreen(),
      ),
    ],
  );
}
