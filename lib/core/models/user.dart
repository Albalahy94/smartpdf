import 'package:freezed_annotation/freezed_annotation.dart';
import 'subscription.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    required Subscription subscription,
    required DateTime createdAt,
    Map<String, dynamic>? preferences,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

