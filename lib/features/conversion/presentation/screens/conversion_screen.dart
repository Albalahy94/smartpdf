import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/providers/subscription_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_card.dart';

class ConversionScreen extends ConsumerStatefulWidget {
  final PdfFile? pdfFile;

  const ConversionScreen({super.key, this.pdfFile});

  @override
  ConsumerState<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends ConsumerState<ConversionScreen> {
  String? _selectedConversion;
  bool _isProcessing = false;

  final List<ConversionOption> _conversions = [
    ConversionOption(
      title: 'PDF → Word',
      description: 'Convert PDF to editable Word document',
      icon: Icons.description,
      gradient: AppTheme.primaryGradient,
      feature: 'pdf_to_word',
    ),
    ConversionOption(
      title: 'Word → PDF',
      description: 'Convert Word document to PDF',
      icon: Icons.picture_as_pdf,
      gradient: AppTheme.secondaryGradient,
      feature: 'word_to_pdf',
    ),
    ConversionOption(
      title: 'PDF → Images',
      description: 'Extract pages as images',
      icon: Icons.image,
      gradient: AppTheme.accentGradient,
      feature: 'pdf_to_images',
    ),
    ConversionOption(
      title: 'Images → PDF',
      description: 'Combine images into PDF',
      icon: Icons.collections,
      gradient: AppTheme.primaryGradient,
      feature: 'images_to_pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Conversion Tools')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Convert Your Documents',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Transform files between different formats',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Conversion Options
            ..._conversions.map((conversion) {
              final isAvailable = subscription.canUseFeature(
                conversion.feature,
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GradientCard(
                  gradient: conversion.gradient,
                  onTap: isAvailable && !_isProcessing
                      ? () {
                          setState(() {
                            _selectedConversion = conversion.feature;
                          });
                          _handleConversion(conversion, subscription);
                        }
                      : null,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          conversion.icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversion.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              conversion.description,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isAvailable)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Pro+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),

            // Usage Info
            if (subscription.plan == SubscriptionPlan.free &&
                widget.pdfFile != null)
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
                        'Free plan: ${subscription.plan == SubscriptionPlan.free ? "2" : "Unlimited"} PDF → Word conversions',
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (_isProcessing) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 16),
              Text(
                'Processing $_selectedConversion...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _handleConversion(
    ConversionOption conversion,
    subscription,
  ) async {
    setState(() {
      _isProcessing = true;
    });

    // TODO: Implement actual conversion
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${conversion.title} completed!'),
          backgroundColor: AppTheme.blueTurquoise,
          action: SnackBarAction(
            label: 'Open',
            textColor: Colors.white,
            onPressed: () {
              // TODO: Open converted file
            },
          ),
        ),
      );
    }
  }
}

class ConversionOption {
  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;
  final String feature;

  ConversionOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.feature,
  });
}
