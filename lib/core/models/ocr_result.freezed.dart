// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OcrResult _$OcrResultFromJson(Map<String, dynamic> json) {
  return _OcrResult.fromJson(json);
}

/// @nodoc
mixin _$OcrResult {
  String get id => throw _privateConstructorUsedError;
  String get pdfFileId => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  String get extractedText => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isOnDevice => throw _privateConstructorUsedError;
  String? get confidence => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this OcrResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OcrResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OcrResultCopyWith<OcrResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrResultCopyWith<$Res> {
  factory $OcrResultCopyWith(OcrResult value, $Res Function(OcrResult) then) =
      _$OcrResultCopyWithImpl<$Res, OcrResult>;
  @useResult
  $Res call(
      {String id,
      String pdfFileId,
      int pageNumber,
      String extractedText,
      DateTime createdAt,
      bool isOnDevice,
      String? confidence,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$OcrResultCopyWithImpl<$Res, $Val extends OcrResult>
    implements $OcrResultCopyWith<$Res> {
  _$OcrResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OcrResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pdfFileId = null,
    Object? pageNumber = null,
    Object? extractedText = null,
    Object? createdAt = null,
    Object? isOnDevice = null,
    Object? confidence = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pdfFileId: null == pdfFileId
          ? _value.pdfFileId
          : pdfFileId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      extractedText: null == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOnDevice: null == isOnDevice
          ? _value.isOnDevice
          : isOnDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OcrResultImplCopyWith<$Res>
    implements $OcrResultCopyWith<$Res> {
  factory _$$OcrResultImplCopyWith(
          _$OcrResultImpl value, $Res Function(_$OcrResultImpl) then) =
      __$$OcrResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pdfFileId,
      int pageNumber,
      String extractedText,
      DateTime createdAt,
      bool isOnDevice,
      String? confidence,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$OcrResultImplCopyWithImpl<$Res>
    extends _$OcrResultCopyWithImpl<$Res, _$OcrResultImpl>
    implements _$$OcrResultImplCopyWith<$Res> {
  __$$OcrResultImplCopyWithImpl(
      _$OcrResultImpl _value, $Res Function(_$OcrResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of OcrResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pdfFileId = null,
    Object? pageNumber = null,
    Object? extractedText = null,
    Object? createdAt = null,
    Object? isOnDevice = null,
    Object? confidence = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$OcrResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pdfFileId: null == pdfFileId
          ? _value.pdfFileId
          : pdfFileId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      extractedText: null == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOnDevice: null == isOnDevice
          ? _value.isOnDevice
          : isOnDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OcrResultImpl implements _OcrResult {
  const _$OcrResultImpl(
      {required this.id,
      required this.pdfFileId,
      required this.pageNumber,
      required this.extractedText,
      required this.createdAt,
      required this.isOnDevice,
      this.confidence,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$OcrResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OcrResultImplFromJson(json);

  @override
  final String id;
  @override
  final String pdfFileId;
  @override
  final int pageNumber;
  @override
  final String extractedText;
  @override
  final DateTime createdAt;
  @override
  final bool isOnDevice;
  @override
  final String? confidence;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OcrResult(id: $id, pdfFileId: $pdfFileId, pageNumber: $pageNumber, extractedText: $extractedText, createdAt: $createdAt, isOnDevice: $isOnDevice, confidence: $confidence, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OcrResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pdfFileId, pdfFileId) ||
                other.pdfFileId == pdfFileId) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.extractedText, extractedText) ||
                other.extractedText == extractedText) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isOnDevice, isOnDevice) ||
                other.isOnDevice == isOnDevice) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pdfFileId,
      pageNumber,
      extractedText,
      createdAt,
      isOnDevice,
      confidence,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of OcrResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      __$$OcrResultImplCopyWithImpl<_$OcrResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OcrResultImplToJson(
      this,
    );
  }
}

abstract class _OcrResult implements OcrResult {
  const factory _OcrResult(
      {required final String id,
      required final String pdfFileId,
      required final int pageNumber,
      required final String extractedText,
      required final DateTime createdAt,
      required final bool isOnDevice,
      final String? confidence,
      final Map<String, dynamic>? metadata}) = _$OcrResultImpl;

  factory _OcrResult.fromJson(Map<String, dynamic> json) =
      _$OcrResultImpl.fromJson;

  @override
  String get id;
  @override
  String get pdfFileId;
  @override
  int get pageNumber;
  @override
  String get extractedText;
  @override
  DateTime get createdAt;
  @override
  bool get isOnDevice;
  @override
  String? get confidence;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of OcrResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
