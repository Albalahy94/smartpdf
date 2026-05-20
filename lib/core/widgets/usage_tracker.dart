import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/subscription_provider.dart';
import '../constants/subscription_plans.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

class UsageTracker extends ConsumerWidget {
  final String feature;
  final String featureName;

  const UsageTracker({
    super.key,
    required this.feature,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionNotifierProvider);
    final remaining = ref
        .read(subscriptionNotifierProvider.notifier)
        .getRemainingLimit(feature);
    final used = subscription.usageLimits?[feature] ?? 0;

    // For unlimited plans or when no specific limit logic applies for the plan
    // (though in this app structure, everything has limits defined or is unlimited)
    if (remaining == null && subscription.plan == SubscriptionPlan.pro) {
      return _buildUnlimitedCard();
    }

    // Determine limit based on plan
    final limit = subscription.plan == SubscriptionPlan.free
        ? _getFreeLimit(feature)
        : subscription.plan == SubscriptionPlan.pro
            ? _getProLimit(feature)
            : null;

    if (limit == null) {
      // If logic returns null but it's not explicitly caught above, assume unlimited or hidden
      return _buildUnlimitedCard();
    }

    final percentage = (used / limit).clamp(0.0, 1.0);
    final isLow = remaining != null && remaining <= (limit * 0.2);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featureName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2D3142),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isLow
                      ? Colors.red[50]
                      : AppTheme.blueTurquoise.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$used / $limit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isLow ? Colors.red : AppTheme.blueTurquoise,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.grey[100],
              valueColor: AlwaysStoppedAnimation<Color>(
                isLow ? Colors.red : AppTheme.blueTurquoise,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(
                  duration: 2000.ms,
                  color: Colors.white
                      .withOpacity(0.5)), // Subtle shimmer on the bar
          const SizedBox(height: 8),
          Text(
            '$remaining remaining this month',
            style: TextStyle(
              fontSize: 13,
              color: isLow ? Colors.red[700] : Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 0.1, curve: Curves.easeOut);
  }

  Widget _buildUnlimitedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.blueTurquoise.withOpacity(0.1),
            AppTheme.turquoise.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.blueTurquoise.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.blueTurquoise.withOpacity(0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Icon(Icons.all_inclusive_rounded,
                color: AppTheme.blueTurquoise, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                featureName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2D3142),
                ),
              ),
              const Text(
                'Unlimited Access',
                style: TextStyle(
                  color: AppTheme.blueTurquoise,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 0.1, curve: Curves.easeOut);
  }

  int? _getFreeLimit(String feature) {
    switch (feature) {
      case 'ocr_server':
        return AppConstants.freeOcrServerLimit;
      case 'translation':
        return AppConstants.freeTranslationLimit;
      case 'summaries':
        return AppConstants.freeSummariesLimit;
      default:
        return null;
    }
  }

  int? _getProLimit(String feature) {
    // Pro plans are generally unlimited for these in this app context,
    // but if specific limits exist, they return here.
    // If null is returned, it falls back to unlimited UI.
    switch (feature) {
      case 'ocr_server':
        return AppConstants.proOcrServerLimit; // Might be null or a high number
      case 'summaries':
        return AppConstants.proSummariesLimit;
      default:
        return null;
    }
  }
}
