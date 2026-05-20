enum SubscriptionPlan {
  free,
  pro,
  ultimate,
}

extension SubscriptionPlanExtension on SubscriptionPlan {
  String get name {
    switch (this) {
      case SubscriptionPlan.free:
        return 'Free';
      case SubscriptionPlan.pro:
        return 'Pro';
      case SubscriptionPlan.ultimate:
        return 'Ultimate';
    }
  }

  double get monthlyPrice {
    switch (this) {
      case SubscriptionPlan.free:
        return 0.0;
      case SubscriptionPlan.pro:
        return 3.99;
      case SubscriptionPlan.ultimate:
        return 7.99;
    }
  }

  String get productId {
    switch (this) {
      case SubscriptionPlan.free:
        return 'smartpdf_free';
      case SubscriptionPlan.pro:
        return 'smartpdf_pro_monthly';
      case SubscriptionPlan.ultimate:
        return 'smartpdf_ultimate_monthly';
    }
  }

  bool get hasAds {
    return this == SubscriptionPlan.free;
  }

  bool get hasCloudSync {
    return this != SubscriptionPlan.free;
  }

  bool get hasUnlimitedPdfToWord {
    return this != SubscriptionPlan.free;
  }

  bool get hasHandwritingOcr {
    return this == SubscriptionPlan.ultimate;
  }

  bool get hasApiAccess {
    return this == SubscriptionPlan.ultimate;
  }

  int? get ocrServerLimit {
    switch (this) {
      case SubscriptionPlan.free:
        return 5; // files/month
      case SubscriptionPlan.pro:
        return 50; // files/month
      case SubscriptionPlan.ultimate:
        return null; // unlimited
    }
  }

  int? get translationLimit {
    switch (this) {
      case SubscriptionPlan.free:
        return 10; // texts or PDFs
      case SubscriptionPlan.pro:
        return 30000; // words
      case SubscriptionPlan.ultimate:
        return null; // unlimited
    }
  }

  int? get summariesLimit {
    switch (this) {
      case SubscriptionPlan.free:
        return 5; // files/month
      case SubscriptionPlan.pro:
        return 100; // files/month
      case SubscriptionPlan.ultimate:
        return null; // unlimited
    }
  }
}

