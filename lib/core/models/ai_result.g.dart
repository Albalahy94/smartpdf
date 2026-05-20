// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiResultImpl _$$AiResultImplFromJson(Map<String, dynamic> json) =>
    _$AiResultImpl(
      id: json['id'] as String,
      pdfFileId: json['pdfFileId'] as String,
      type: $enumDecode(_$AiResultTypeEnumMap, json['type']),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AiResultImplToJson(_$AiResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pdfFileId': instance.pdfFileId,
      'type': _$AiResultTypeEnumMap[instance.type]!,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$AiResultTypeEnumMap = {
  AiResultType.summary: 'summary',
  AiResultType.extractTables: 'extractTables',
  AiResultType.extractNames: 'extractNames',
  AiResultType.extractNumbers: 'extractNumbers',
  AiResultType.extractDates: 'extractDates',
  AiResultType.cleanCopy: 'cleanCopy',
  AiResultType.rephrase: 'rephrase',
};
