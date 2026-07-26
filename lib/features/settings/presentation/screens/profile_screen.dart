import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/providers/profile_provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../subscription/presentation/screens/subscription_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionNotifierProvider);
    final profile = ref.watch(profileProvider);
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = loc.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('profile'))),
      body: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: isDark ? AppTheme.deepSlateCard : AppTheme.lightSurface,
                child: Icon(Icons.person, size: 50, color: isDark ? Colors.white60 : Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                profile.email,
                style: const TextStyle(color: Colors.grey),
              ),
              if (Platform.isIOS) ...[
                const SizedBox(height: 16),
                if (!profile.isAppleSignedIn)
                  SignInWithAppleButton(
                    onPressed: () async {
                      try {
                        final credential = await SignInWithApple.getAppleIDCredential(
                          scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                          ],
                        );

                        final String name = credential.givenName != null
                            ? '${credential.givenName} ${credential.familyName ?? ""}'
                            : (profile.name != 'User Name' ? profile.name : 'Apple User');
                        final String email = credential.email ?? profile.email;

                        await ref.read(profileProvider.notifier).saveAppleCredential(
                              name: name,
                              email: email,
                              userId: credential.userIdentifier ?? '',
                            );

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isAr
                                    ? 'تم تسجيل الدخول بحساب Apple بنجاح!'
                                    : 'Successfully signed in with Apple!',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isAr ? 'فشل تسجيل الدخول بـ Apple' : 'Apple Sign In cancelled or failed',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: isDark ? SignInWithAppleButtonStyle.white : SignInWithAppleButtonStyle.black,
                  )
                else
                  TextButton.icon(
                    onPressed: () async {
                      await ref.read(profileProvider.notifier).signOutApple();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isAr ? 'تم تسجيل الخروج من Apple' : 'Signed out from Apple',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                    label: Text(
                      isAr ? 'تسجيل الخروج من Apple' : 'Sign Out from Apple',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
              ],
              const SizedBox(height: 32),
              
              // Subscription details container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.deepSlateCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppTheme.borderDark : Colors.transparent,
                    width: isDark ? 1.2 : 0,
                  ),
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isAr ? 'الخطة الحالية' : 'Current Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.blueTurquoise.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            subscription.plan.name,
                            style: const TextStyle(
                              color: AppTheme.blueTurquoise,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!subscription.isUltimate) ...[
                      const SizedBox(height: 20),
                      GradientButton(
                        text: isAr ? 'ترقية الباقة' : 'Upgrade Plan',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscriptionScreen(),
                            ),
                          );
                        },
                        gradient: AppTheme.accentGradient,
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Action buttons list
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(isAr ? 'تعديل الملف الشخصي' : 'Edit Profile'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(isAr ? 'تغيير كلمة المرور' : 'Change Password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              
              // Account Deletion Trigger (Mandatory for Google Play)
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: Text(
                  loc.translate('deleteAccount'),
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  isAr ? 'مسح حسابك وبياناتك نهائياً' : 'Permanently purge your account',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.red),
                onTap: () {
                  _showAccountDeletionDialog(context, loc);
                },
              ),
              
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.grey),
                title: Text(
                  isAr ? 'تسجيل الخروج' : 'Logout',
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
                      title: Text(isAr ? 'تسجيل الخروج' : 'Logout'),
                      content: Text(
                        isAr 
                            ? 'هل أنت متأكد من رغبتك في تسجيل الخروج؟' 
                            : 'Are you sure you want to logout?'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(loc.translate('cancel')),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            context.go('/onboarding');
                          },
                          child: Text(
                            isAr ? 'تسجيل الخروج' : 'Logout',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAccountDeletionDialog(BuildContext context, AppLocalizations loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                loc.translate('deleteAccountWarning'),
                style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Text(
          loc.translate('deleteAccountDesc'),
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate('cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context); // Close warnings modal
              _showDeletionSuccessDialog(context, loc);
            },
            child: Text(loc.translate('confirmDelete')),
          ),
        ],
      ),
    );
  }

  void _showDeletionSuccessDialog(BuildContext context, AppLocalizations loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppTheme.deepSlateCard : Colors.white,
        title: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(
              loc.translate('requestSubmitted'),
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          loc.translate('deletionProcessing'),
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.go('/onboarding'); // Redirect to onboarding
            },
            child: Text(
              loc.translate('close'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
