import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../core/providers/file_manager_provider.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/services/file_service.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../viewer/presentation/screens/pdf_viewer_screen.dart';
import '../../../subscription/presentation/screens/subscription_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../../core/services/pdf_creation_service.dart';
import '../../../creation/presentation/screens/create_pdf_screen.dart';

// ─── Production Ad Unit ID (Banner) ───────────────────────────────────────────
// Replace with test ID during development:
// 'ca-app-pub-3940256099942544/6300978111'
const String _bannerAdUnitId = 'ca-app-pub-2410231577080071/6102909922';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedTab = 'recent';
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _isBannerAdReady = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final files = ref.watch(fileManagerProvider);
    final subscription = ref.watch(subscriptionNotifierProvider);
    final fileManager = ref.read(fileManagerProvider.notifier);
    final loc = AppLocalizations.of(context)!;

    final recentFiles = fileManager.getRecentFiles();
    final favoriteFiles = fileManager.getFavoriteFiles();

    final displayedFiles = _selectedTab == 'recent'
        ? recentFiles
        : _selectedTab == 'favorites'
            ? favoriteFiles
            : files;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final showBanner = subscription.hasAds && _isBannerAdReady && _bannerAd != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(loc.translate('appName')),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              fontSize: 28,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w900,
            ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 28),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ── AdMob Banner: shown at bottom for free-plan users only ───────────────
      bottomNavigationBar: showBanner
          ? Container(
              height: _bannerAd!.size.height.toDouble(),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.deepSlateCard : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppTheme.borderDark : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd!),
            )
          : null,

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
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Subscription Banner (Free only with golden neon shimmer)
              if (subscription.hasAds)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppTheme.secondaryGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.pink.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.translate('upgradePro'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                loc.translate('unlockUnlimited'),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        GradientButton(
                          text: loc.translate('upgrade'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SubscriptionScreen(),
                              ),
                            );
                          },
                          gradient: AppTheme.accentGradient,
                        ),
                      ],
                    ),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: 2500.ms,
                      color: Colors.white.withValues(alpha: 0.2),
                      angle: 45,
                    )
                    .animate()
                    .fade(duration: 500.ms)
                    .slideY(begin: -0.15, curve: Curves.easeOutBack),

              // Tabs (with elastic scaling interactions)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _buildTab(
                        loc.translate('recent'), 'recent', recentFiles.length),
                    const SizedBox(width: 12),
                    _buildTab(loc.translate('favorites'), 'favorites',
                        favoriteFiles.length),
                    const SizedBox(width: 12),
                    _buildTab(loc.translate('allFiles'), 'all', files.length),
                  ],
                ),
              )
                  .animate()
                  .fade()
                  .slideX(begin: 0.1, curve: Curves.easeOut, delay: 100.ms),

              // File List (with staggered animation)
              Expanded(
                child: displayedFiles.isEmpty
                    ? _buildEmptyState(loc)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: displayedFiles.length,
                        itemBuilder: (context, index) {
                          final file = displayedFiles[index];
                          return _buildFileCard(file)
                              .animate()
                              .fade(delay: (index * 60).ms, duration: 400.ms)
                              .slideY(begin: 0.12, curve: Curves.easeOutQuad);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showImportOptions(context, ref),
        backgroundColor: AppTheme.blueTurquoise,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        label: Text(
          loc.translate('importPdf'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ).animate().scale(delay: 500.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildEmptyState(AppLocalizations loc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.deepSlateCard
                  : AppTheme.lightSurface,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.borderDark
                    : Colors.transparent,
              ),
            ),
            child: Icon(Icons.description_rounded,
                size: 64, color: Colors.grey[400]),
          ).animate().scale(duration: 500.ms, curve: Curves.easeOut),
          const SizedBox(height: 24),
          Text(
            loc.translate('noFiles'),
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ).animate().fade(delay: 200.ms),
          const SizedBox(height: 8),
          Text(
            loc.translate('tapImport'),
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ).animate().fade(delay: 300.ms),
        ],
      ),
    );
  }

  Widget _buildTab(String label, String value, int count) {
    final isSelected = _selectedTab == value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _selectedTab = value),
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? AppTheme.primaryGradient : null,
            color: isSelected
                ? null
                : isDark
                    ? AppTheme.deepSlateCard
                    : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.blueTurquoise.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
            border: isSelected
                ? null
                : Border.all(
                    color: isDark ? AppTheme.borderDark : Colors.grey[200]!,
                  ),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : isDark
                          ? AppTheme.borderDark
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.grey[400]
                            : Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileCard(PdfFile file) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.deepSlateCard : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : Colors.grey[200]!,
          width: isDark ? 1.2 : 1,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(pdfFile: file),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.blueTurquoise.withValues(alpha: 0.1),
                        AppTheme.turquoise.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: AppTheme.blueTurquoise,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF2D3142),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(context, file.createdAt),
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.data_usage_rounded,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            '${(file.size / 1024 / 1024).toStringAsFixed(2)} MB',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    file.isFavorite == true
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: file.isFavorite == true
                        ? AppTheme.pink
                        : Colors.grey[400],
                  ),
                  onPressed: () {
                    ref.read(fileManagerProvider.notifier).updateFile(
                          file.copyWith(
                              isFavorite: !(file.isFavorite ?? false)),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final loc = AppLocalizations.of(context)!;

    if (difference.inDays == 0) {
      return loc.translate('today');
    } else if (difference.inDays == 1) {
      return loc.translate('yesterday');
    } else if (difference.inDays < 7) {
      return loc.translate('daysAgo',
          arguments: {'count': difference.inDays.toString()});
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showImportOptions(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.deepSlateCard : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(
            color: isDark ? AppTheme.borderDark : Colors.transparent,
            width: isDark ? 1.2 : 0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.borderDark : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              loc.translate('importPdf'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            _buildImportOption(
              sheetContext,
              icon: Icons.folder_open_rounded,
              title: loc.translate('fromFiles'),
              subtitle: loc.translate('browseDevice'),
              color: AppTheme.blueTurquoise,
              onTap: () async {
                Navigator.pop(sheetContext);
                await _importFromFiles(ref);
              },
            )
                .animate()
                .slideY(begin: 0.2, curve: Curves.easeOut, delay: 100.ms)
                .fade(),
            const SizedBox(height: 16),
            _buildImportOption(
              sheetContext,
              icon: Icons.camera_alt_rounded,
              title: loc.translate('scanDoc'),
              subtitle: loc.translate('captureCamera'),
              color: AppTheme.purple,
              onTap: () async {
                Navigator.pop(sheetContext);
                final service = PdfCreationService();
                final pdfFile = await service.scanDocumentToPdf(context);
                if (pdfFile != null) {
                  ref.read(fileManagerProvider.notifier).addFile(pdfFile);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.translate('importedSuccessfully', arguments: {'name': pdfFile.name})),
                      backgroundColor: AppTheme.blueTurquoise,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                }
              },
            )
                .animate()
                .slideY(begin: 0.2, curve: Curves.easeOut, delay: 200.ms)
                .fade(),
            const SizedBox(height: 16),
            _buildImportOption(
              sheetContext,
              icon: Icons.edit_document,
              title: loc.translate('createNew'),
              subtitle: loc.translate('startScratch'),
              color: AppTheme.aqua,
              onTap: () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePdfScreen()),
                );
              },
            )
                .animate()
                .slideY(begin: 0.2, curve: Curves.easeOut, delay: 300.ms)
                .fade(),
          ],
        ),
      ),
    );
  }

  Widget _buildImportOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? AppTheme.borderDark : Colors.grey[200]!,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black87,
                        )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _importFromFiles(WidgetRef ref) async {
    final fileService = FileService();
    final loc = AppLocalizations.of(context)!;
    final pdfFile = await fileService.pickPdfFile();

    if (pdfFile != null) {
      ref.read(fileManagerProvider.notifier).addFile(pdfFile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc.translate('importedSuccessfully',
                  arguments: {'name': pdfFile.name}),
            ),
            backgroundColor: AppTheme.blueTurquoise,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }
}
