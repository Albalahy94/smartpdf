import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';

class TranslationScreen extends ConsumerStatefulWidget {
  final PdfFile? pdfFile;
  final String? selectedText;

  const TranslationScreen({super.key, this.pdfFile, this.selectedText});

  @override
  ConsumerState<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends ConsumerState<TranslationScreen> {
  String _sourceLanguage = 'Auto-detect';
  String _targetLanguage = 'English';
  String? _translatedText;
  bool _isLoading = false;
  bool _translateFullDocument = false;

  final List<String> _languages = [
    'Auto-detect',
    'English',
    'Arabic',
    'French',
    'Spanish',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Translation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Language Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Languages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLanguageDropdown(
                            'From',
                            _sourceLanguage,
                            (value) {
                              setState(() {
                                _sourceLanguage = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.arrow_forward),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildLanguageDropdown('To', _targetLanguage, (
                            value,
                          ) {
                            setState(() {
                              _targetLanguage = value!;
                            });
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Translation Mode
            if (widget.pdfFile != null)
              Card(
                child: SwitchListTile(
                  title: const Text('Translate Full Document'),
                  subtitle: const Text('Translate entire PDF file'),
                  value: _translateFullDocument,
                  onChanged: (value) {
                    setState(() {
                      _translateFullDocument = value;
                    });
                  },
                ),
              ),

            const SizedBox(height: 16),

            // Source Text
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Source Text',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      constraints: const BoxConstraints(minHeight: 150),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        widget.selectedText ??
                            (widget.pdfFile != null
                                ? 'Full document will be translated...'
                                : 'Enter text to translate'),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Usage Info
            if (subscription.plan == SubscriptionPlan.free)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Free plan: ${ref.read(subscriptionNotifierProvider.notifier).getRemainingLimit('translation') ?? 0} translations remaining',
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Translate Button
            GradientButton(
              text: _isLoading ? 'Translating...' : 'Translate',
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                        _translatedText = null;
                      });

                      // TODO: Call translation API
                      await Future.delayed(const Duration(seconds: 2));

                      if (mounted) {
                        setState(() {
                          _translatedText =
                              'This is a translated text placeholder. The actual translation will be provided by the backend API.';
                          _isLoading = false;
                        });

                        // Update usage
                        ref
                            .read(subscriptionNotifierProvider.notifier)
                            .updateUsage(
                              'translation',
                              (subscription.usageLimits?['translation'] ?? 0) +
                                  1,
                            );
                      }
                    },
              gradient: AppTheme.primaryGradient,
            ),

            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],

            if (_translatedText != null) ...[
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Translated Text ($_targetLanguage)',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Text copied to clipboard'),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // TODO: Share translated text
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      SelectableText(
                        _translatedText!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GradientButton(
                text: 'Export as PDF',
                onPressed: () {
                  // TODO: Export translated PDF
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export feature coming soon')),
                  );
                },
                gradient: AppTheme.secondaryGradient,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppTheme.blueTurquoise),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: _languages.map((lang) {
            return DropdownMenuItem(value: lang, child: Text(lang));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
