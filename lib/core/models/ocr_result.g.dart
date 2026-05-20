// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OcrResultImpl _$$OcrResultImplFromJson(Map<String, dynamic> json) =>
    _$OcrResultImpl(
      id: json['id'] as String,
      pdfFileId: json['pdfFileId'] as String,
      pageNumber: (json['pageNumber'] as num).toInt(),
      extractedText: json['extractedText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isOnDevice: json['isOnDevice'] as bool,
      confidence: json['confidence'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OcrResultImplToJson(_$OcrResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pdfFileId': instance.pdfFileId,
      'pageNumber': instance.pageNumber,
      'extractedText': instance.extractedText,
      'createdAt': instance.createdAt.toIso8601String(),
      'isOnDevice': instance.isOnDevice,
      'confidence': instance.confidence,
      'metadata': instance.metadata,
    };
