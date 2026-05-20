import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/services/pdf_creation_service.dart';
import '../../../../core/providers/file_manager_provider.dart';

class CreatePdfScreen extends ConsumerStatefulWidget {
  const CreatePdfScreen({super.key});

  @override
  ConsumerState<CreatePdfScreen> createState() => _CreatePdfScreenState();
}

class _CreatePdfScreenState extends ConsumerState<CreatePdfScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _generatePdf() async {
    if (_contentController.text.trim().isEmpty) return;

    setState(() => _isSaving = true);
    final service = PdfCreationService();
    final pdfFile = await service.createTextPdf(
      _titleController.text.trim(),
      _contentController.text.trim(),
    );

    if (mounted) {
      setState(() => _isSaving = false);
      final loc = AppLocalizations.of(context)!;
      if (pdfFile != null) {
        ref.read(fileManagerProvider.notifier).addFile(pdfFile);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.translate('importedSuccessfully', arguments: {'name': pdfFile.name})),
            backgroundColor: AppTheme.blueTurquoise,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.translate('error_loading_pdf')),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(loc.translate('createNew')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppTheme.obsidianBlack, AppTheme.obsidianBlack]
                : [AppTheme.lightSurface, Colors.white],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title Field
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.deepSlateCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? AppTheme.borderDark : Colors.grey[200]!),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: loc.translate('title'),
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ).animate().fade().slideY(begin: 0.1),
                const SizedBox(height: 20),
                
                // Content Field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.deepSlateCard : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? AppTheme.borderDark : Colors.grey[200]!),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: loc.translate('content'),
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.1),
                ),
                const SizedBox(height: 24),

                // Save Button
                _isSaving
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.blueTurquoise))
                    : GradientButton(
                        text: loc.translate('savePdf'),
                        onPressed: _generatePdf,
                        gradient: AppTheme.primaryGradient,
                      ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
