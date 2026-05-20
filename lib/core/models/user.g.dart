// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      subscription:
          Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      preferences: json['preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'subscription': instance.subscription,
      'createdAt': instance.createdAt.toIso8601String(),
      'preferences': instance.preferences,
    };
