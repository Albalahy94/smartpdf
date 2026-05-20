import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_provider.dart';

class ProfileKeys {
  static const String name = 'user_name';
  static const String email = 'user_email';
}

class ProfileState {
  final String name;
  final String email;

  ProfileState({
    required this.name,
    required this.email,
  });

  ProfileState copyWith({
    String? name,
    String? email,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final SharedPreferences _prefs;

  ProfileNotifier(this._prefs)
      : super(ProfileState(
          name: _prefs.getString(ProfileKeys.name) ?? 'User Name',
          email: _prefs.getString(ProfileKeys.email) ?? 'user@example.com',
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
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProfileNotifier(prefs);
});
