import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf_file.freezed.dart';
part 'pdf_file.g.dart';

@freezed
class PdfFile with _$PdfFile {
  const factory PdfFile({
    required String id,
    required String name,
    required String path,
    required int size,
    required DateTime createdAt,
    DateTime? modifiedAt,
    String? thumbnailPath,
    int? pageCount,
    String? folderId,
    bool? isFavorite,
    Map<String, dynamic>? metadata,
  }) = _PdfFile;

  factory PdfFile.fromJson(Map<String, dynamic> json) =>
      _$PdfFileFromJson(json);
}

