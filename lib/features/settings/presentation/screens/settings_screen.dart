import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/providers/settings_provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../subscription/presentation/screens/subscription_screen.dart';
import 'profile_screen.dart';
import 'help_support_screen.dart';
import 'info_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionNotifierProvider);
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppTheme.obsidianBlack,
                    AppTheme.obsidianBlack,
                  ]
                : [
                    AppTheme.lightSurface,
                    Colors.white,
                  ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            // Account Section
            _buildSectionHeader(loc.translate('account')),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(loc.translate('profile')),
              subtitle: Text(loc.translate('manageAccount')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: subscription.isPro || subscription.isUltimate
                    ? Colors.amber
                    : Colors.grey,
              ),
              title: Text('${loc.translate('subscription')}: ${subscription.plan.name}'),
              subtitle: Text(
                subscription.isPro || subscription.isUltimate
                    ? '\$${subscription.plan.monthlyPrice.toStringAsFixed(2)}/month'
                    : loc.translate('freePlan'),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionScreen(),
                  ),
                );
              },
            ),

            const Divider(height: 32, indent: 16, endIndent: 16),

            // App Settings
            _buildSectionHeader(loc.translate('appSettings')),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(loc.translate('theme')),
              subtitle: Text(
                settings.themeMode == ThemeMode.system
                    ? loc.translate('systemDefault')
                    : settings.themeMode == ThemeMode.light
                        ? loc.translate('lightMode')
                        : loc.translate('darkMode'),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showThemeSelector(context, ref);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(loc.translate('language')),
              subtitle: Text(
                  settings.locale.languageCode == 'ar' 
                      ? loc.translate('arabic') 
                      : loc.translate('english')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showLanguageSelector(context, ref);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: Text(loc.translate('storageLocation')),
              subtitle: Text(
                settings.storageLocation == 'Internal'
                    ? loc.translate('internalStorage')
                    : loc.translate('sdCard'),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showStorageSelector(context, ref);
              },
            ),

            const Divider(height: 32, indent: 16, endIndent: 16),

            // PDF Settings
            _buildSectionHeader(loc.translate('pdfSettings')),
            SwitchListTile(
              secondary: const Icon(Icons.auto_awesome),
              title: Text(loc.translate('autoSave')),
              subtitle: Text(loc.translate('autoSaveChanges')),
              value: settings.autoSave,
              activeColor: AppTheme.blueTurquoise,
              onChanged: (value) {
                settingsNotifier.toggleAutoSave(value);
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.cloud_upload),
              title: Text(loc.translate('cloudSync')),
              subtitle: Text(
                subscription.plan == SubscriptionPlan.free
                    ? loc.translate('availableInPro')
                    : loc.translate('syncAcrossDevices'),
              ),
              value: settings.cloudSync &&
                  subscription.plan != SubscriptionPlan.free,
              activeColor: AppTheme.blueTurquoise,
              onChanged: subscription.plan == SubscriptionPlan.free
                  ? null
                  : (value) {
                      settingsNotifier.toggleCloudSync(value);
                    },
            ),

            const Divider(height: 32, indent: 16, endIndent: 16),

            // About Section
            _buildSectionHeader(loc.translate('about')),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(loc.translate('appVersion')),
              subtitle: const Text('1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(loc.translate('termsOfService')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(
                      title: loc.translate('termsOfService'),
                      content: loc.translate('termsOfServiceDesc'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text(loc.translate('privacyPolicy')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(
                      title: loc.translate('privacyPolicy'),
                      content: loc.translate('privacyPolicyDesc'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: Text(loc.translate('shippingPolicy')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(
                      title: loc.translate('shippingPolicy'),
                      content: loc.translate('digitalDeliveryDesc'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(loc.translate('refundPolicy')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(
                      title: loc.translate('refundPolicy'),
                      content: loc.translate('refundCancellationDesc'),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(loc.translate('helpSupport')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpSupportScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_auto),
                title: Text(loc.translate('systemDefault')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setThemeMode(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: Text(loc.translate('lightMode')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(loc.translate('darkMode')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text(loc.translate('english')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text(loc.translate('arabic')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStorageSelector(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: Text(loc.translate('internalStorage')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setStorageLocation('Internal');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sd_storage),
                title: Text(loc.translate('sdCard')),
                onTap: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setStorageLocation('SD Card');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
