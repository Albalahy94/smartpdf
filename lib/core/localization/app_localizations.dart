import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'SmartPDF',
      'recent': 'Recent',
      'favorites': 'Favorites',
      'allFiles': 'All Files',
      'error_loading_pdf': 'Error loading PDF file.',
      'title': 'Document Title',
      'content': 'Write your document content here...',
      'savePdf': 'Generate PDF',
      'scanNextPageTitle': 'Scan Next Page',
      'scanNextPagePrompt': 'You have scanned {count} page(s). Do you want to add another page?',
      'done': 'Done',
      'scanMore': 'Scan More',
      'importPdf': 'Import PDF',
      'fromFiles': 'From Files',
      'browseDevice': 'Browse on device',
      'scanDoc': 'Scan Document',
      'captureCamera': 'Capture from camera',
      'createNew': 'Create New',
      'startScratch': 'Start from scratch',
      'upgradePro': 'Upgrade to Pro',
      'unlockUnlimited': 'Unlock unlimited features',
      'upgrade': 'Upgrade',
      'settings': 'Settings',
      'account': 'Account',
      'profile': 'Profile',
      'manageAccount': 'Manage your account',
      'subscription': 'Subscription',
      'freePlan': 'Free Plan',
      'appSettings': 'App Settings',
      'theme': 'Theme',
      'language': 'Language',
      'storageLocation': 'Storage Location',
      'pdfSettings': 'PDF Settings',
      'autoSave': 'Auto-save',
      'autoSaveChanges': 'Automatically save changes',
      'cloudSync': 'Cloud Sync',
      'syncAcrossDevices': 'Sync files across devices',
      'availableInPro': 'Available in Pro+',
      'about': 'About',
      'appVersion': 'App Version',
      'termsOfService': 'Terms of Service',
      'privacyPolicy': 'Privacy Policy',
      'shippingPolicy': 'Shipping & Delivery',
      'refundPolicy': 'Refund & Cancellation',
      'helpSupport': 'Help & Support',
      'systemDefault': 'System Default',
      'lightMode': 'Light Mode',
      'darkMode': 'Dark Mode',
      'internalStorage': 'Internal Storage',
      'sdCard': 'SD Card',
      'arabic': 'Arabic',
      'english': 'English',
      'noFiles': 'No PDF files yet',
      'tapImport': 'Tap the Import button to start',
      'aiTools': 'AI Tools',
      'aiPowered': 'AI-Powered Document Tools',
      'extractInsights': 'Extract insights and enhance your PDF documents',
      'summary': 'Summary',
      'generateSummary': 'Generate document summary',
      'extractTables': 'Extract Tables',
      'extractTableData': 'Extract table data',
      'extractNames': 'Extract Names',
      'findAllNames': 'Find all names',
      'extractNumbers': 'Extract Numbers',
      'findAllNumbers': 'Find all numbers',
      'extractDates': 'Extract Dates',
      'findAllDates': 'Find all dates',
      'cleanCopy': 'Clean Copy',
      'removeWatermarks': 'Remove watermarks',
      'copiedToClipboard': 'Copied to clipboard',
      'exportResult': 'Export Result',
      'comingSoon': 'Export feature coming soon',
      'freePlanLimit': 'Free plan: {count} summaries remaining this month',
      'processingTool': 'Processing {tool}... This may take a few seconds',
      'importedSuccessfully': '{name} imported successfully',
      'search': 'Search',
      'cancel': 'Cancel',
      'today': 'Today',
      'yesterday': 'Yesterday',
      'daysAgo': '{count} days ago',
      'proPlus': 'Pro+',
      'result': 'RESULT',
      
      // Account Deletion & Legal policy additions
      'deleteAccount': 'Delete Account',
      'deleteAccountWarning': 'Warning: Account Deletion is Permanent!',
      'deleteAccountDesc': 'Deleting your account will permanently purge your profile, remove all uploaded PDF files, and terminate all active AI subscriptions. This action cannot be undone. Are you sure you want to proceed?',
      'confirmDelete': 'Yes, Delete My Account',
      'requestSubmitted': 'Request Submitted',
      'deletionProcessing': 'Your account deletion request has been registered and is being processed. All your personal data and files will be completely purged within 48 hours.',
      'close': 'Close',
      'digitalDeliveryTitle': 'Digital Delivery Policy',
      'digitalDeliveryDesc': 'All purchases of subscriptions and AI credits are delivered digitally. Subscriptions are unlocked immediately in your account upon successful payment processing. Credit packages are updated dynamically in real-time. No physical shipping is required.',
      'refundCancellationTitle': 'Refund & Cancellation Policy',
      'refundCancellationDesc': 'You can cancel your subscription at any time directly through your Google Play Store Account settings. Refunds for digital items and subscription renewals are governed by the Google Play Refund Policy. Approved refunds will be credited back to your original payment method.',
      'privacyPolicyDesc': 'At SmartPDF, we value your privacy and security. Your PDF documents are processed safely using Google Gemini API endpoints, and we never store your file content on our servers. Your settings are saved locally on your device.',
      'termsOfServiceDesc': 'By using SmartPDF, you agree to our terms. You may not use the app for illegal distribution of copyrighted materials. Subscription benefits are non-transferable and subject to normal API usage constraints.',
    },
    'ar': {
      'appName': 'سمارت PDF',
      'recent': 'الأخيرة',
      'favorites': 'المفضلة',
      'allFiles': 'كل الملفات',
      'error_loading_pdf': 'حدث خطأ أثناء تحميل ملف الـ PDF.',
      'title': 'عنوان المستند',
      'content': 'اكتب محتوى المستند هنا...',
      'savePdf': 'توليد المستند',
      'scanNextPageTitle': 'مسح الصفحة التالية',
      'scanNextPagePrompt': 'لقد قمت بمسح {count} صفحة/صفحات. هل تريد إضافة صفحة أخرى؟',
      'done': 'إنهاء',
      'scanMore': 'مسح المزيد',
      'importPdf': 'استيراد ملف PDF',
      'fromFiles': 'من الملفات',
      'browseDevice': 'تصفح في الجهاز',
      'scanDoc': 'مسح ضوئي للمستند',
      'captureCamera': 'التقاط عبر الكاميرا',
      'createNew': 'إنشاء مستند جديد',
      'startScratch': 'البدء من الصفر',
      'upgradePro': 'الترقية للمحترفين',
      'unlockUnlimited': 'افتح كافة الميزات اللامحدودة',
      'upgrade': 'ترقية',
      'settings': 'الإعدادات',
      'account': 'الحساب',
      'profile': 'الملف الشخصي',
      'manageAccount': 'إدارة حسابك الشخصي',
      'subscription': 'الاشتراك',
      'freePlan': 'الخطة المجانية',
      'appSettings': 'إعدادات التطبيق',
      'theme': 'المظهر',
      'language': 'اللغة',
      'storageLocation': 'مكان التخزين',
      'pdfSettings': 'إعدادات الـ PDF',
      'autoSave': 'حفظ تلقائي',
      'autoSaveChanges': 'حفظ التعديلات تلقائياً',
      'cloudSync': 'النسخ السحابي',
      'syncAcrossDevices': 'مزامنة الملفات عبر الأجهزة',
      'availableInPro': 'متاح في باقة برو+',
      'about': 'حول التطبيق',
      'appVersion': 'إصدار التطبيق',
      'termsOfService': 'الشروط والأحكام',
      'privacyPolicy': 'سياسة الخصوصية',
      'shippingPolicy': 'الشحن والتوصيل',
      'refundPolicy': 'الاسترجاع والإلغاء',
      'helpSupport': 'المساعدة والدعم',
      'systemDefault': 'مظهر النظام',
      'lightMode': 'الوضع الفاتح',
      'darkMode': 'الوضع المظلم',
      'internalStorage': 'ذاكرة الهاتف الداخلية',
      'sdCard': 'بطاقة الذاكرة الخارجية',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
      'noFiles': 'لا توجد ملفات PDF بعد',
      'tapImport': 'انقر على زر استيراد للبدء',
      'aiTools': 'أدوات الذكاء الاصطناعي',
      'aiPowered': 'أدوات مستندات مدعومة بالذكاء الاصطناعي',
      'extractInsights': 'استخرج الرؤى والملخصات وحسّن مستنداتك بصورة ذكية',
      'summary': 'ملخص المستند',
      'generateSummary': 'إنشاء ملخص للمستند',
      'extractTables': 'استخراج الجداول',
      'extractTableData': 'استخراج البيانات الجدولية',
      'extractNames': 'استخراج الأسماء',
      'findAllNames': 'البحث عن جميع الأسماء',
      'extractNumbers': 'استخراج الأرقام',
      'findAllNumbers': 'البحث عن جميع الأرقام',
      'extractDates': 'استخراج التواريخ',
      'findAllDates': 'البحث عن جميع التواريخ',
      'cleanCopy': 'نسخة نظيفة',
      'removeWatermarks': 'إزالة العلامات المائية',
      'copiedToClipboard': 'تم نسخ النص إلى الحافظة',
      'exportResult': 'تصدير النتيجة',
      'comingSoon': 'ميزة التصدير ستتوفر قريباً',
      'freePlanLimit': 'الخطة المجانية: متبقي لديك {count} ملخصات هذا الشهر',
      'processingTool': 'جاري معالجة {tool}... قد يستغرق هذا بضع ثوانٍ',
      'importedSuccessfully': 'تم استيراد {name} بنجاح',
      'search': 'بحث',
      'cancel': 'إلغاء',
      'today': 'اليوم',
      'yesterday': 'أمس',
      'daysAgo': 'منذ {count} أيام',
      'proPlus': 'برو+',
      'result': 'النتيجة',
      
      // Account Deletion & Legal policy additions
      'deleteAccount': 'حذف الحساب',
      'deleteAccountWarning': 'تحذير: حذف الحساب نهائي ولا يمكن التراجع عنه!',
      'deleteAccountDesc': 'سيؤدي حذف حسابك إلى مسح ملفك الشخصي نهائياً، وحذف جميع ملفات PDF المرفوعة، وإلغاء جميع اشتراكات الذكاء الاصطناعي النشطة تلقائياً. لا يمكن التراجع عن هذا الإجراء. هل أنت متأكد من رغبتك في المتابعة؟',
      'confirmDelete': 'نعم، احذف حسابي نهائياً',
      'requestSubmitted': 'تم تقديم الطلب',
      'deletionProcessing': 'تم تسجيل طلب حذف حسابك وجاري معالجته بنجاح. سيتم مسح كافة ملفاتك وبياناتك الشخصية بالكامل من السيرفرات خلال 48 ساعة.',
      'close': 'إغلاق',
      'digitalDeliveryTitle': 'سياسة الشحن والتوصيل الرقمي',
      'digitalDeliveryDesc': 'يتم تقديم كافة الخدمات والاشتراكات وباقات الائتمان رقمياً بالكامل. يتم تفعيل الاشتراكات وباقات أدوات الذكاء الاصطناعي فوراً في حسابك بمجرد إتمام الدفع بنجاح. لا تتطلب ميزاتنا أي شحن أو توصيل مادي.',
      'refundCancellationTitle': 'سياسة الاسترجاع والإلغاء',
      'refundCancellationDesc': 'يمكنك إلغاء اشتراكك في أي وقت مباشرة من خلال إعدادات حسابك في متجر Google Play. تخضع عمليات استرداد الأموال للمشتريات الرقمية وتجديد الاشتراكات لسياسة الاسترداد الخاصة بـ Google Play. سيتم إرجاع المبالغ المعتمدة لوسيلة الدفع الأصلية.',
      'privacyPolicyDesc': 'في سمارت PDF، نقدر خصوصيتك وأمان مستنداتك بشدة. تتم معالجة ملفات PDF بأمان فائق عبر خوادم Google Gemini الرسمية الموثوقة، ولا نقوم مطلقاً بتخزين محتوى مستنداتك على سيرفراتنا. تفضيلاتك تُخزن محلياً بالكامل بداخل جهازك.',
      'termsOfServiceDesc': 'باستخدامك لتطبيق سمارت PDF، فإنك توافق على شروط الخدمة. يُمنع منعاً باتاً استخدام التطبيق لتوزيع مواد محمية بموجب حقوق النشر. مزايا باقات المحترفين غير قابلة للتحويل وتخضع لقيود الاستخدام الطبيعية للذكاء الاصطناعي.',
    }
  };

  String translate(String key, {Map<String, String>? arguments}) {
    String value = _localizedValues[locale.languageCode]?[key] ?? key;
    if (arguments != null) {
      arguments.forEach((argKey, argValue) {
        value = value.replaceAll('{$argKey}', argValue);
      });
    }
    return value;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
