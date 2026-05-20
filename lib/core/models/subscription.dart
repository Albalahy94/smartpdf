import 'package:freezed_annotation/freezed_annotation.dart';
import '../constants/subscription_plans.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required SubscriptionPlan plan,
    required DateTime startDate,
    DateTime? endDate,
    required bool isActive,
    String? transactionId,
    Map<String, int>? usageLimits,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}

extension SubscriptionExtension on Subscription {
  bool get isPro => plan == SubscriptionPlan.pro;
  bool get isUltimate => plan == SubscriptionPlan.ultimate;
  bool get hasAds => plan == SubscriptionPlan.free;
  
  bool canUseFeature(String feature) {
    if (plan == SubscriptionPlan.ultimate) return true;
    if (plan == SubscriptionPlan.pro) {
      return feature != 'handwriting_ocr' && feature != 'api_access';
    }
    // Free plan limits
    return feature != 'cloud_sync' && 
           feature != 'extract_tables' && 
           feature != 'clean_copy';
  }
}

