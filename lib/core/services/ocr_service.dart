import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import '../models/ocr_result.dart';
import '../models/pdf_file.dart';
import '../providers/subscription_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OcrService {
  static final OcrService _instance = OcrService._internal();
  factory OcrService() => _instance;
  OcrService._internal();

  // On-device OCR using Tesseract
  Future<OcrResult?> performOnDeviceOcr(PdfFile pdfFile, int pageNumber) async {
    try {
      // TODO: Extract image from PDF page first
      // For now, this is a placeholder
      final imagePath = pdfFile.path; // Should be page image path

      final extractedText = await FlutterTesseractOcr.extractText(
        imagePath,
        language: 'eng+ara', // English + Arabic
        args: {'preserve_interword_spaces': '1'},
      );

      return OcrResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pdfFileId: pdfFile.id,
        pageNumber: pageNumber,
        extractedText: extractedText,
        createdAt: DateTime.now(),
        isOnDevice: true,
        confidence: '0.85', // Placeholder
      );
    } catch (e) {
      return null;
    }
  }

  // Server OCR - should call backend API
  Future<OcrResult?> performServerOcr(
    PdfFile pdfFile,
    int pageNumber,
    WidgetRef ref,
  ) async {
    try {
      final subscription = ref.read(subscriptionNotifierProvider);

      // Check limits
      if (!subscription.canUseFeature('ocr_server')) {
        throw Exception('OCR server feature not available in your plan');
      }

      final remaining = ref
          .read(subscriptionNotifierProvider.notifier)
          .getRemainingLimit('ocr_server');
      if (remaining != null && remaining <= 0) {
        throw Exception('OCR server limit reached. Upgrade to continue.');
      }

      // TODO: Call backend API
      // This is a placeholder
      await Future.delayed(const Duration(seconds: 3)); // Simulate API call

      // Update usage
      ref
          .read(subscriptionNotifierProvider.notifier)
          .updateUsage(
            'ocr_server',
            (subscription.usageLimits?['ocr_server'] ?? 0) + 1,
          );

      return OcrResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pdfFileId: pdfFile.id,
        pageNumber: pageNumber,
        extractedText: 'Extracted text from server OCR...', // Placeholder
        createdAt: DateTime.now(),
        isOnDevice: false,
        confidence: '0.95',
      );
    } catch (e) {
      rethrow;
    }
  }
}
