import '../models/ai_result.dart';
import '../models/pdf_file.dart';
import '../providers/subscription_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  // Generate Summary
  Future<AiResult?> generateSummary(PdfFile pdfFile, WidgetRef ref) async {
    try {
      final subscription = ref.read(subscriptionNotifierProvider);

      if (!subscription.canUseFeature('summaries')) {
        throw Exception('Summaries not available in your plan');
      }

      final remaining = ref
          .read(subscriptionNotifierProvider.notifier)
          .getRemainingLimit('summaries');
      if (remaining != null && remaining <= 0) {
        throw Exception('Summary limit reached. Upgrade to continue.');
      }

      // TODO: Call backend API
      await Future.delayed(const Duration(seconds: 3));

      // Update usage
      ref
          .read(subscriptionNotifierProvider.notifier)
          .updateUsage(
            'summaries',
            (subscription.usageLimits?['summaries'] ?? 0) + 1,
          );

      return AiResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pdfFileId: pdfFile.id,
        type: AiResultType.summary,
        content:
            'This is a generated summary placeholder. The actual summary will be provided by the AI backend API.',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Extract Tables
  Future<AiResult?> extractTables(PdfFile pdfFile, WidgetRef ref) async {
    try {
      final subscription = ref.read(subscriptionNotifierProvider);

      if (!subscription.canUseFeature('extract_tables')) {
        throw Exception('Extract Tables available in Pro+ plans only');
      }

      // TODO: Call backend API
      await Future.delayed(const Duration(seconds: 4));

      return AiResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pdfFileId: pdfFile.id,
        type: AiResultType.extractTables,
        content: 'Table data extracted...',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Extract Names
  Future<AiResult?> extractNames(PdfFile pdfFile, WidgetRef ref) async {
    // TODO: Implement
    await Future.delayed(const Duration(seconds: 2));
    return AiResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pdfFileId: pdfFile.id,
      type: AiResultType.extractNames,
      content: 'Extracted names: John Doe, Jane Smith, ...',
      createdAt: DateTime.now(),
    );
  }

  // Extract Numbers
  Future<AiResult?> extractNumbers(PdfFile pdfFile, WidgetRef ref) async {
    // TODO: Implement
    await Future.delayed(const Duration(seconds: 2));
    return AiResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pdfFileId: pdfFile.id,
      type: AiResultType.extractNumbers,
      content: 'Extracted numbers: 123, 456, 789, ...',
      createdAt: DateTime.now(),
    );
  }

  // Extract Dates
  Future<AiResult?> extractDates(PdfFile pdfFile, WidgetRef ref) async {
    // TODO: Implement
    await Future.delayed(const Duration(seconds: 2));
    return AiResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pdfFileId: pdfFile.id,
      type: AiResultType.extractDates,
      content: 'Extracted dates: 2024-01-01, 2024-12-31, ...',
      createdAt: DateTime.now(),
    );
  }

  // Clean Copy
  Future<AiResult?> cleanCopy(PdfFile pdfFile, WidgetRef ref) async {
    try {
      final subscription = ref.read(subscriptionNotifierProvider);

      if (!subscription.canUseFeature('clean_copy')) {
        throw Exception('Clean Copy available in Pro+ plans only');
      }

      // TODO: Call backend API
      await Future.delayed(const Duration(seconds: 5));

      return AiResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        pdfFileId: pdfFile.id,
        type: AiResultType.cleanCopy,
        content: 'Cleaned PDF generated...',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Rephrase
  Future<AiResult?> rephrase(
    PdfFile pdfFile,
    String text,
    WidgetRef ref,
  ) async {
    // TODO: Implement
    await Future.delayed(const Duration(seconds: 2));
    return AiResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pdfFileId: pdfFile.id,
      type: AiResultType.rephrase,
      content: 'Rephrased text: ...',
      createdAt: DateTime.now(),
    );
  }
}
