import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/services/ocr_service.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../translation/presentation/screens/translation_screen.dart';

class OcrScreen extends ConsumerStatefulWidget {
  final PdfFile pdfFile;
  final int? pageNumber;

  const OcrScreen({super.key, required this.pdfFile, this.pageNumber});

  @override
  ConsumerState<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends ConsumerState<OcrScreen> {
  String? _extractedText;
  bool _isLoading = false;
  bool _isOnDevice = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionNotifierProvider);
    final ocrService = OcrService();

    return Scaffold(
      appBar: AppBar(title: const Text('OCR - Text Recognition')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // OCR Type Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OCR Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOcrTypeCard(
                            'On-Device',
                            'Fast, works offline',
                            Icons.phone_android,
                            true,
                            Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOcrTypeCard(
                            'Server',
                            'More accurate',
                            Icons.cloud,
                            false,
                            subscription.plan != SubscriptionPlan.free
                                ? AppTheme.blueTurquoise
                                : Colors.grey,
                            disabled:
                                subscription.plan == SubscriptionPlan.free,
                          ),
                        ),
                      ],
                    ),
                    if (subscription.plan == SubscriptionPlan.free) ...[
                      const SizedBox(height: 12),
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
                                'Server OCR: ${ref.read(subscriptionNotifierProvider.notifier).getRemainingLimit('ocr_server') ?? 0} files remaining this month',
                                style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Button
            GradientButton(
              text: _isLoading ? 'Processing...' : 'Extract Text',
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                        _error = null;
                        _extractedText = null;
                      });

                      try {
                        final result = _isOnDevice
                            ? await ocrService.performOnDeviceOcr(
                                widget.pdfFile,
                                widget.pageNumber ?? 1,
                              )
                            : await ocrService.performServerOcr(
                                widget.pdfFile,
                                widget.pageNumber ?? 1,
                                ref,
                              );

                        if (result != null && mounted) {
                          setState(() {
                            _extractedText = result.extractedText;
                            _isLoading = false;
                          });
                        } else {
                          throw Exception('Failed to extract text');
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            _error = e.toString();
                            _isLoading = false;
                          });
                        }
                      }
                    },
              gradient: _isOnDevice
                  ? AppTheme.accentGradient
                  : AppTheme.primaryGradient,
            ),

            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 16),
              const Text(
                'Processing... This may take a few seconds',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],

            if (_error != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (_extractedText != null) ...[
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
                          const Text(
                            'Extracted Text',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {
                                  // TODO: Copy to clipboard
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
                                  // TODO: Share text
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      SelectableText(
                        _extractedText!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GradientButton(
                text: 'Translate Text',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TranslationScreen(selectedText: _extractedText),
                    ),
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

  Widget _buildOcrTypeCard(
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
    Color color, {
    bool disabled = false,
  }) {
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              setState(() {
                _isOnDevice = isSelected;
              });
            },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: disabled ? Colors.grey : color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: disabled ? Colors.grey : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabled ? Colors.grey : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              Icon(Icons.check_circle, color: color, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
