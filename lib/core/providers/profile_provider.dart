import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_provider.dart';

class ProfileKeys {
  static const String name = 'user_name';
  static const String email = 'user_email';
  static const String isAppleSignedIn = 'is_apple_signed_in';
  static const String appleUserId = 'apple_user_id';
}

class ProfileState {
  final String name;
  final String email;
  final bool isAppleSignedIn;
  final String? appleUserId;

  ProfileState({
    required this.name,
    required this.email,
    this.isAppleSignedIn = false,
    this.appleUserId,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    bool? isAppleSignedIn,
    String? appleUserId,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      isAppleSignedIn: isAppleSignedIn ?? this.isAppleSignedIn,
      appleUserId: appleUserId ?? this.appleUserId,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final SharedPreferences _prefs;

  ProfileNotifier(this._prefs)
      : super(ProfileState(
          name: _prefs.getString(ProfileKeys.name) ?? 'User Name',
          email: _prefs.getString(ProfileKeys.email) ?? 'user@example.com',
          isAppleSignedIn: _prefs.getBool(ProfileKeys.isAppleSignedIn) ?? false,
          appleUserId: _prefs.getString(ProfileKeys.appleUserId),
        ));

  Future<void> updateProfile({String? name, String? email}) async {
    if (name != null) {
      await _prefs.setString(ProfileKeys.name, name);
    }
    if (email != null) {
      await _prefs.setString(ProfileKeys.email, email);
    }
    state = state.copyWith(name: name, email: email);
  }

  Future<void> saveAppleCredential({required String name, required String email, required String userId}) async {
    await _prefs.setString(ProfileKeys.name, name);
    await _prefs.setString(ProfileKeys.email, email);
    await _prefs.setBool(ProfileKeys.isAppleSignedIn, true);
    await _prefs.setString(ProfileKeys.appleUserId, userId);
    state = state.copyWith(
      name: name,
      email: email,
      isAppleSignedIn: true,
      appleUserId: userId,
    );
  }

  Future<void> signOutApple() async {
    await _prefs.setBool(ProfileKeys.isAppleSignedIn, false);
    await _prefs.remove(ProfileKeys.appleUserId);
    state = state.copyWith(
      name: 'User Name',
      email: 'user@example.com',
      isAppleSignedIn: false,
      appleUserId: null,
    );
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProfileNotifier(prefs);
});
