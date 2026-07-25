import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/subscription.dart';
export '../models/subscription.dart';
import '../constants/subscription_plans.dart';
export '../constants/subscription_plans.dart';

part 'subscription_provider.g.dart';

import 'dart:io';

@riverpod
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Subscription build() {
    // For iOS (Apple App Store compliance): unlock all features for free, hide paywalls
    if (Platform.isIOS) {
      return Subscription(
        plan: SubscriptionPlan.ultimate,
        startDate: DateTime.now(),
        isActive: true,
        usageLimits: {
          'ocr_server': 0,
          'translation': 0,
          'summaries': 0,
          'pdf_to_word': 0,
        },
      );
    }

    // Default to free plan on Android/other
    return Subscription(
      plan: SubscriptionPlan.free,
      startDate: DateTime.now(),
      isActive: true,
      usageLimits: {
        'ocr_server': 0,
        'translation': 0,
        'summaries': 0,
        'pdf_to_word': 0,
      },
    );
  }

  void updatePlan(SubscriptionPlan plan) {
    state = state.copyWith(
      plan: plan,
      startDate: DateTime.now(),
      isActive: true,
    );
  }

  void updateUsage(String feature, int count) {
    final limits = Map<String, int>.from(state.usageLimits ?? {});
    limits[feature] = count;
    state = state.copyWith(usageLimits: limits);
  }

  bool canUseFeature(String feature) {
    return state.canUseFeature(feature);
  }

  int? getRemainingLimit(String feature) {
    final plan = state.plan;

    switch (feature) {
      case 'ocr_server':
        final used = state.usageLimits?['ocr_server'] ?? 0;
        return plan.ocrServerLimit != null
            ? (plan.ocrServerLimit! - used)
            : null;
      case 'translation':
        final used = state.usageLimits?['translation'] ?? 0;
        return plan.translationLimit != null
            ? (plan.translationLimit! - used)
            : null;
      case 'summaries':
        final used = state.usageLimits?['summaries'] ?? 0;
        return plan.summariesLimit != null
            ? (plan.summariesLimit! - used)
            : null;
      default:
        return null;
    }
  }
}
