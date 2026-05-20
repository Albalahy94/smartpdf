import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_result.freezed.dart';
part 'ai_result.g.dart';

@freezed
class AiResult with _$AiResult {
  const factory AiResult({
    required String id,
    required String pdfFileId,
    required AiResultType type,
    required String content,
    required DateTime createdAt,
    Map<String, dynamic>? metadata,
  }) = _AiResult;

  factory AiResult.fromJson(Map<String, dynamic> json) =>
      _$AiResultFromJson(json);
}

enum AiResultType {
  summary,
  extractTables,
  extractNames,
  extractNumbers,
  extractDates,
  cleanCopy,
  rephrase,
}

