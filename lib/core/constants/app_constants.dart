import 'subscription_plans.dart';

class AppConstants {
  // App Info
  static const String appName = 'SmartPDF';
  static const String appVersion = '1.0.0';

  // Subscription Plans
  static const String freePlan = 'free';
  static const String proPlan = 'pro';
  static const String ultimatePlan = 'ultimate';

  // Pro Plan - $3.99/month
  static const int proOcrServerLimit = 50;
  static const int proTranslationLimit = 30000; // words
  static const int proSummariesLimit = 100;

  // Ultimate Plan - $7.99/month
  static const int ultimateCloudBackup = 1024; // 1GB in MB

  // Free Plan Limits
  static const int freeOcrServerLimit = 5; // files/month
  static const int freeTranslationLimit = 10; // texts or PDFs
  static const int freeSummariesLimit = 5; // files/month
  static const int freePdfToWordLimit = 2; // files

  // Performance Targets
  static const int pdfViewerLoadTime = 1; // seconds
  static const int ocrProcessingTime = 6; // seconds per page
  static const int translationTime = 12; // seconds
  static const int summaryTime = 5; // seconds

  // Server File Cleanup
  static const int serverFileRetentionMinutes = 30;
}

