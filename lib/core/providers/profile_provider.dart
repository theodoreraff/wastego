import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastego/core/services/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _phone = '';
  String _userId = ''; // Internal DB ID
  String _wgoId = ''; // User-facing WGO-ID
  String _avatarUrl = '';
  bool _isLoading = false;

  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get userId => _userId; // Internal DB ID
  String get wgoId => _wgoId; // User-facing WGO-ID
  String get avatarUrl => _avatarUrl;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    loadProfileFromStorage(); // Load initially from storage
  }

  Future<void> loadProfileFromStorage() async {
    // ApiService.init() is called in main.dart
    // Ensure ApiService itself has loaded its static prefs values first.
    // This typically happens if ApiService.init() was awaited.

    final token = ApiService.token; // Check token status first
    if (token == null) {
      // Not logged in, ensure profile data is cleared
      clearProfileData(); // This will also notify listeners
      debugPrint('ProfileProvider: No token found, profile cleared.');
      return;
    }

    // Token exists, try loading from SharedPreferences
    final storedData = ApiService.loadUserData();
    _username = storedData['username'] ?? '';
    _userId = storedData['userId'] ?? '';
    _wgoId = storedData['wgoId'] ?? '';
    _avatarUrl = storedData['avatarUrl'] ?? '';
    // Email and phone are typically fetched from /profile, not stored with basic auth data.
    debugPrint(
      'ProfileProvider: Loaded from storage - Username: $_username, WGO ID: $_wgoId',
    );

    // If essential data like username is still missing despite having a token,
    // it implies SharedPreferences might be empty or incomplete for this user.
    // Attempt to fetch from API.
    if (_username.isEmpty || _wgoId.isEmpty) {
      debugPrint(
        'ProfileProvider: Essential data missing from storage, attempting API fetch.',
      );
      try {
        await fetchProfile(); // fetchProfile will notifyListeners
      } on SessionExpiredException {
        // Handled by fetchProfile rethrow, and UI should catch it.
        // Ensure local state is clean.
        clearProfileData();
      } catch (e) {
        // Other errors during fetch, data from storage (even if partial) is already set.
        // UI will show what was loaded, or empty if storage was empty.
        notifyListeners(); // Notify with potentially partial data from storage.
      }
    } else {
      // Data loaded successfully from storage and seems complete enough.
      notifyListeners();
    }
  }

  // Ambil data profil dari server
  Future<void> fetchProfile() async {
    if (ApiService.token == null) {
      debugPrint(
        'ProfileProvider: No token, cannot fetch profile. Clearing data.',
      );
      clearProfileData(); // Ensure state is clean and notify
      // Optionally, rethrow a specific exception if callers need to react to "attempted fetch without token"
      return; // Or throw an exception
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getUserProfile();
      debugPrint('Profile API response: $response');

      // API response is the source of truth.
      // Extract the profile data map.
      final dynamic profileField = response['profile'];
      Map<String, dynamic>? profileData;

      if (profileField is Map<String, dynamic>) {
        profileData = profileField;
      } else if (profileField is Map) {
        // Handle cases where it might be Map<dynamic, dynamic>
        profileData = Map<String, dynamic>.from(profileField);
      }

      if (profileData != null) {
        _username = profileData['username']?.toString() ?? '';
        _email = profileData['email']?.toString() ?? '';
        _phone = profileData['phone']?.toString() ?? '';
        // 'uid' from the profile response corresponds to our 'userId'
        _userId = profileData['uid']?.toString() ?? _userId;
        _wgoId = profileData['wgoId']?.toString() ?? '';
        // 'avatar' from the profile response corresponds to our 'avatarUrl'
        _avatarUrl = profileData['avatar']?.toString() ?? '';
      } else {
        // If 'profile' key is missing or not a map, set fields to empty or retain old _userId.
        // This maintains the behavior of using empty strings as fallbacks.
        _username = '';
        _email = '';
        _phone = '';
        // _userId keeps its existing value if profileData is null.
        _wgoId = '';
        _avatarUrl = '';
        debugPrint(
          'ProfileProvider: "profile" key missing, null, or not a map in API response. Response: $response',
        );
      }

      // Save the potentially updated profile to SharedPreferences
      await ApiService.saveUserData(
        userId: _userId,
        wgoId: _wgoId,
        username: _username,
        avatarUrl: _avatarUrl,
      );
      debugPrint(
        'ProfileProvider: Profile fetched and saved - Username: $_username, WGO ID: $_wgoId',
      );
    } on SessionExpiredException catch (e) {
      debugPrint(
        'ProfileProvider: Session expired during fetchProfile. Clearing data.',
      );
      await ApiService.clearAuthData(); // Ensure SharedPreferences is cleared
      clearProfileData(); // Clear local provider state
      rethrow; // Rethrow for UI to handle (e.g., redirect to login)
    } catch (e) {
      debugPrint(
        'ProfileProvider: Failed to fetch profile from API: $e. Existing data (if any) will be used.',
      );
      // Don't clear data here, as SharedPreferences data might still be valid or preferred.
      // The UI will show whatever was loaded by loadProfileFromStorage or previous fetches.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUsername(String newName) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.updateUsername(newName);
      // After successfully updating the username via API,
      // fetch the entire profile again to ensure all data is fresh
      // from the single source of truth (the /profile endpoint).
      // This also handles saving to SharedPreferences within fetchProfile.
      await fetchProfile();
      // If fetchProfile fails, it will throw, and the UI should handle it.
      // The _username will be updated by fetchProfile.
    } on SessionExpiredException catch (e) {
      debugPrint(
        'ProfileProvider: Session expired during updateUsername. Clearing data.',
      );
      await ApiService.clearAuthData();
      clearProfileData();
      rethrow;
    } catch (e) {
      debugPrint('Gagal update username: $e');
      // Potentially revert _username to old value if API call failed but SharedPreferences was not updated by API
      // For now, rethrow and let UI handle showing error. The value in SharedPreferences is key.
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePhone(String newPhone) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.updatePhone(newPhone);
      _phone = newPhone;
      // Phone is not part of ApiService.saveUserData standard fields.
      // It's usually part of the full profile. If backend updates it,
      // calling fetchProfile() afterwards would get and save it.
      // For now, we only update it locally in the provider.
      // If persistence of phone via saveUserData is desired, extend ApiService.saveUserData
    } on SessionExpiredException catch (e) {
      debugPrint(
        'ProfileProvider: Session expired during updatePhone. Clearing data.',
      );
      await ApiService.clearAuthData();
      clearProfileData();
      rethrow;
    } catch (e) {
      debugPrint('Gagal update nomor: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAvatar(File imageFile) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.updateAvatar(imageFile);
      String? newAvatarUrl;
      if (response.containsKey('avatarUrl')) {
        newAvatarUrl = response['avatarUrl'] as String?;
      } else if (response.containsKey('user') && response['user'] is Map) {
        final userData = response['user'] as Map;
        newAvatarUrl = userData['avatarUrl'] as String?;
      } else if (response.containsKey('profile') &&
          response['profile'] is Map<String, dynamic>) {
        // More specific type
        // Check profile too
        final profileData = response['profile'] as Map<String, dynamic>;
        newAvatarUrl = profileData['avatar'] as String?; // Use 'avatar' key
      } else if (response.containsKey('profile') &&
          response['profile'] is Map) {
        // Fallback for Map
        // Check profile too
        final profileData = Map<String, dynamic>.from(
          response['profile'] as Map,
        );
        newAvatarUrl = profileData['avatar'] as String?; // Use 'avatar' key
      }

      if (newAvatarUrl != null && newAvatarUrl.isNotEmpty) {
        _avatarUrl = newAvatarUrl;
        await ApiService.saveUserData(
          userId: _userId,
          wgoId: _wgoId,
          username: _username,
          avatarUrl: _avatarUrl,
        );
      } else {
        await fetchProfile();
      }
    } on SessionExpiredException catch (e) {
      debugPrint(
        'ProfileProvider: Session expired during updateAvatar. Clearing data.',
      );
      await ApiService.clearAuthData();
      clearProfileData();
      rethrow;
    } catch (e) {
      debugPrint('Gagal update avatar: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearProfileData() {
    _username = '';
    _email = '';
    _phone = '';
    _userId = '';
    _wgoId = ''; // Clear wgoId
    _avatarUrl = '';
    _isLoading = false;
    notifyListeners();
  }
}
