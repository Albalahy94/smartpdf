import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/constants/subscription_plans.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/gradient_card.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSubscription = ref.watch(subscriptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Plans')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Choose Your Plan',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Unlock powerful features to enhance your PDF experience',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Free Plan
            _buildPlanCard(
              context,
              plan: SubscriptionPlan.free,
              isCurrent: currentSubscription.plan == SubscriptionPlan.free,
              features: [
                'Banner ad (Home screen only)',
                'On-device OCR only',
                '5 Server OCR files/month',
                '10 Translation texts/PDFs',
                '5 Summaries/month',
                '2 PDF → Word conversions',
                'No Cloud Sync',
                'Export with watermark',
              ],
            ),

            const SizedBox(height: 16),

            // Pro Plan
            _buildPlanCard(
              context,
              plan: SubscriptionPlan.pro,
              isCurrent: currentSubscription.plan == SubscriptionPlan.pro,
              isRecommended: true,
              features: [
                'No ads',
                '50 Server OCR files/month',
                '30,000 Translation words',
                'Unlimited PDF → Word',
                '100 Summaries/month',
                'Extract Tables',
                'Clean Copy',
                'Cloud Sync',
                'Scan Cleanup',
              ],
            ),

            const SizedBox(height: 16),

            // Ultimate Plan
            _buildPlanCard(
              context,
              plan: SubscriptionPlan.ultimate,
              isCurrent: currentSubscription.plan == SubscriptionPlan.ultimate,
              features: [
                'Everything unlimited',
                'Handwriting OCR',
                'Priority Processing',
                'API Access',
                '1GB Cloud Backup',
                'Advanced PDF Protection',
                'Premium Support',
              ],
            ),

            const SizedBox(height: 32),

            // Current Plan Info
            if (currentSubscription.plan != SubscriptionPlan.free)
              GradientCard(
                gradient: AppTheme.accentGradient,
                child: Column(
                  children: [
                    const Text(
                      'Current Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentSubscription.plan.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${currentSubscription.plan.monthlyPrice.toStringAsFixed(2)}/month',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required SubscriptionPlan plan,
    required bool isCurrent,
    bool isRecommended = false,
    required List<String> features,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isRecommended
                  ? AppTheme.blueTurquoise
                  : isCurrent
                  ? AppTheme.purple
                  : Colors.grey[300]!,
              width: isRecommended ? 3 : 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: isRecommended
                      ? AppTheme.primaryGradient
                      : isCurrent
                      ? AppTheme.secondaryGradient
                      : null,
                  color: isRecommended || isCurrent ? null : Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    if (isRecommended)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'RECOMMENDED',
                          style: TextStyle(
                            color: AppTheme.blueTurquoise,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (isRecommended) const SizedBox(height: 8),
                    Text(
                      plan.name.toUpperCase(),
                      style: TextStyle(
                        color: isRecommended || isCurrent
                            ? Colors.white
                            : Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${plan.monthlyPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isRecommended || isCurrent
                                ? Colors.white
                                : Colors.grey[800],
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '/month',
                            style: TextStyle(
                              color: isRecommended || isCurrent
                                  ? Colors.white70
                                  : Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Features
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: isRecommended
                                  ? AppTheme.blueTurquoise
                                  : isCurrent
                                  ? AppTheme.purple
                                  : Colors.grey[600],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: GradientButton(
                  text: isCurrent ? 'Current Plan' : 'Subscribe',
                  gradient: isRecommended
                      ? AppTheme.primaryGradient
                      : isCurrent
                      ? null
                      : AppTheme.secondaryGradient,
                  onPressed: isCurrent
                      ? null
                      : () {
                          ref
                              .read(subscriptionNotifierProvider.notifier)
                              .updatePlan(plan);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Subscribed to ${plan.name} plan!'),
                              backgroundColor: AppTheme.blueTurquoise,
                            ),
                          );
                        },
                  width: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
