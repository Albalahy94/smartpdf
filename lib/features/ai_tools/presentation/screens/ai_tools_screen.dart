import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/services/ai_service.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/localization/app_localizations.dart';

class AiToolsScreen extends ConsumerStatefulWidget {
  final PdfFile pdfFile;

  const AiToolsScreen({super.key, required this.pdfFile});

  @override
  ConsumerState<AiToolsScreen> createState() => _AiToolsScreenState();
}

class _AiToolsScreenState extends ConsumerState<AiToolsScreen> {
  String? _result;
  bool _isLoading = false;
  String? _error;
  String? _selectedTool;

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionNotifierProvider);
    final aiService = AiService();
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('aiTools'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.translate('aiPowered'),
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              loc.translate('extractInsights'),
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600], 
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // AI Tools Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildToolCard(
                  loc.translate('summary'),
                  loc.translate('generateSummary'),
                  Icons.summarize,
                  AppTheme.primaryGradient,
                  () => _handleTool('summary', aiService, ref),
                  available: true,
                  index: 0,
                ),
                _buildToolCard(
                  loc.translate('extractTables'),
                  loc.translate('extractTableData'),
                  Icons.table_chart,
                  AppTheme.secondaryGradient,
                  () => _handleTool('extract_tables', aiService, ref),
                  available: subscription.canUseFeature('extract_tables'),
                  index: 1,
                ),
                _buildToolCard(
                  loc.translate('extractNames'),
                  loc.translate('findAllNames'),
                  Icons.person,
                  AppTheme.accentGradient,
                  () => _handleTool('extract_names', aiService, ref),
                  available: true,
                  index: 2,
                ),
                _buildToolCard(
                  loc.translate('extractNumbers'),
                  loc.translate('findAllNumbers'),
                  Icons.numbers,
                  AppTheme.primaryGradient,
                  () => _handleTool('extract_numbers', aiService, ref),
                  available: true,
                  index: 3,
                ),
                _buildToolCard(
                  loc.translate('extractDates'),
                  loc.translate('findAllDates'),
                  Icons.calendar_today,
                  AppTheme.secondaryGradient,
                  () => _handleTool('extract_dates', aiService, ref),
                  available: true,
                  index: 4,
                ),
                _buildToolCard(
                  loc.translate('cleanCopy'),
                  loc.translate('removeWatermarks'),
                  Icons.cleaning_services,
                  AppTheme.accentGradient,
                  () => _handleTool('clean_copy', aiService, ref),
                  available: subscription.canUseFeature('clean_copy'),
                  index: 5,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Usage Info with Obsidian safe styling
            if (subscription.plan == SubscriptionPlan.free)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.orange[900]!.withOpacity(0.15) : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.orange[700]!.withOpacity(0.3) : Colors.orange[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: isDark ? Colors.orange[300] : Colors.orange[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        loc.translate('freePlanLimit', arguments: {
                          'count': (ref.read(subscriptionNotifierProvider.notifier).getRemainingLimit('summaries') ?? 0).toString()
                        }),
                        style: TextStyle(
                          color: isDark ? Colors.orange[200] : Colors.orange[900],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fade().slideY(begin: 0.1),

            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator(color: AppTheme.blueTurquoise)),
              const SizedBox(height: 16),
              Text(
                loc.translate('processingTool', arguments: {
                  'tool': loc.translate(_selectedTool ?? 'summary'),
                }),
                textAlign: TextAlign.center,
                style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
            ],

            if (_error != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.red[900]!.withOpacity(0.15) : Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.red[700]!.withOpacity(0.3) : Colors.red[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: isDark ? Colors.red[300] : Colors.red[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: isDark ? Colors.red[200] : Colors.red[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().shake(),
            ],

            if (_result != null) ...[
              const SizedBox(height: 24),
              GradientCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.translate('result'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.copy, color: Colors.white),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(loc.translate('copiedToClipboard')),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Colors.white),
                              onPressed: () {
                                // TODO: Share result
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 8),
                    SelectableText(
                      _result!,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ).animate().fade().slideY(begin: 0.15, curve: Curves.easeOutBack),
              const SizedBox(height: 16),
              GradientButton(
                text: loc.translate('exportResult'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.translate('comingSoon')),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                gradient: AppTheme.secondaryGradient,
              ).animate().fade(delay: 150.ms),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    String title,
    String subtitle,
    IconData icon,
    Gradient gradient,
    VoidCallback onTap, {
    required bool available,
    required int index,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: available ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: available ? gradient : null,
          color: available
              ? null
              : isDark
                  ? Colors.white.withOpacity(0.04)
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: available
                ? Colors.transparent
                : isDark
                    ? AppTheme.borderDark
                    : Colors.transparent,
            width: isDark ? 1.2 : 0,
          ),
          boxShadow: available
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: available
                  ? Colors.white
                  : isDark
                      ? Colors.white.withOpacity(0.3)
                      : Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: available
                    ? Colors.white
                    : isDark
                        ? Colors.white.withOpacity(0.5)
                        : Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: available
                      ? Colors.white70
                      : isDark
                          ? Colors.white.withOpacity(0.3)
                          : Colors.grey[500],
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!available) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  loc.translate('proPlus'),
                  style: TextStyle(
                    color: isDark ? Colors.white.withOpacity(0.6) : Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fade(delay: (index * 60).ms).slideY(begin: 0.1, curve: Curves.easeOutBack);
  }

  Future<void> _handleTool(
    String tool,
    AiService aiService,
    WidgetRef ref,
  ) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
      _selectedTool = tool;
    });

    try {
      switch (tool) {
        case 'summary':
          final result = await aiService.generateSummary(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
        case 'extract_tables':
          final result = await aiService.extractTables(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
        case 'extract_names':
          final result = await aiService.extractNames(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
        case 'extract_numbers':
          final result = await aiService.extractNumbers(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
        case 'extract_dates':
          final result = await aiService.extractDates(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
        case 'clean_copy':
          final result = await aiService.cleanCopy(widget.pdfFile, ref);
          if (result != null && mounted) {
            setState(() {
              _result = result.content;
              _isLoading = false;
            });
          }
          break;
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }
}
