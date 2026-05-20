// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiResult _$AiResultFromJson(Map<String, dynamic> json) {
  return _AiResult.fromJson(json);
}

/// @nodoc
mixin _$AiResult {
  String get id => throw _privateConstructorUsedError;
  String get pdfFileId => throw _privateConstructorUsedError;
  AiResultType get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this AiResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiResultCopyWith<AiResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiResultCopyWith<$Res> {
  factory $AiResultCopyWith(AiResult value, $Res Function(AiResult) then) =
      _$AiResultCopyWithImpl<$Res, AiResult>;
  @useResult
  $Res call(
      {String id,
      String pdfFileId,
      AiResultType type,
      String content,
      DateTime createdAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AiResultCopyWithImpl<$Res, $Val extends AiResult>
    implements $AiResultCopyWith<$Res> {
  _$AiResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pdfFileId = null,
    Object? type = null,
    Object? content = null,
    Object? createdAt = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AiResultType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiResultImplCopyWith<$Res>
    implements $AiResultCopyWith<$Res> {
  factory _$$AiResultImplCopyWith(
          _$AiResultImpl value, $Res Function(_$AiResultImpl) then) =
      __$$AiResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pdfFileId,
      AiResultType type,
      String content,
      DateTime createdAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AiResultImplCopyWithImpl<$Res>
    extends _$AiResultCopyWithImpl<$Res, _$AiResultImpl>
    implements _$$AiResultImplCopyWith<$Res> {
  __$$AiResultImplCopyWithImpl(
      _$AiResultImpl _value, $Res Function(_$AiResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pdfFileId = null,
    Object? type = null,
    Object? content = null,
    Object? createdAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_$AiResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pdfFileId: null == pdfFileId
          ? _value.pdfFileId
          : pdfFileId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AiResultType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiResultImpl implements _AiResult {
  const _$AiResultImpl(
      {required this.id,
      required this.pdfFileId,
      required this.type,
      required this.content,
      required this.createdAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$AiResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiResultImplFromJson(json);

  @override
  final String id;
  @override
  final String pdfFileId;
  @override
  final AiResultType type;
  @override
  final String content;
  @override
  final DateTime createdAt;
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
    return 'AiResult(id: $id, pdfFileId: $pdfFileId, type: $type, content: $content, createdAt: $createdAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pdfFileId, pdfFileId) ||
                other.pdfFileId == pdfFileId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, pdfFileId, type, content,
      createdAt, const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of AiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiResultImplCopyWith<_$AiResultImpl> get copyWith =>
      __$$AiResultImplCopyWithImpl<_$AiResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiResultImplToJson(
      this,
    );
  }
}

abstract class _AiResult implements AiResult {
  const factory _AiResult(
      {required final String id,
      required final String pdfFileId,
      required final AiResultType type,
      required final String content,
      required final DateTime createdAt,
      final Map<String, dynamic>? metadata}) = _$AiResultImpl;

  factory _AiResult.fromJson(Map<String, dynamic> json) =
      _$AiResultImpl.fromJson;

  @override
  String get id;
  @override
  String get pdfFileId;
  @override
  AiResultType get type;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of AiResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiResultImplCopyWith<_$AiResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
