// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PdfFileImpl _$$PdfFileImplFromJson(Map<String, dynamic> json) =>
    _$PdfFileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      size: (json['size'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      thumbnailPath: json['thumbnailPath'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      folderId: json['folderId'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PdfFileImplToJson(_$PdfFileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'size': instance.size,
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'thumbnailPath': instance.thumbnailPath,
      'pageCount': instance.pageCount,
      'folderId': instance.folderId,
      'isFavorite': instance.isFavorite,
      'metadata': instance.metadata,
    };
