import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_result.freezed.dart';
part 'ocr_result.g.dart';

@freezed
class OcrResult with _$OcrResult {
  const factory OcrResult({
    required String id,
    required String pdfFileId,
    required int pageNumber,
    required String extractedText,
    required DateTime createdAt,
    required bool isOnDevice,
    String? confidence,
    Map<String, dynamic>? metadata,
  }) = _OcrResult;

  factory OcrResult.fromJson(Map<String, dynamic> json) =>
      _$OcrResultFromJson(json);
}

