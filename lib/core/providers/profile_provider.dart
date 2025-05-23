import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastego/core/services/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  String username = '';
  String phone = '';
  String userId = '';
  String avatarUrl = '';
  bool isLoading = false;

  // Ambil data profil dari server
  Future<void> fetchProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiService.getUserProfile();
      debugPrint('Profile API response: $response');

      username = response['username'] ?? '';
      phone = response['phone'] ?? '';
      userId = response['id']?.toString() ?? '';
      avatarUrl = response['avatarUrl'] ?? '';
    } catch (e) {
      debugPrint('Gagal mengambil profil: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUsername(String newName) async {
    try {
      await ApiService.updateUsername(newName);
      username = newName;
      notifyListeners();
    } catch (e) {
      debugPrint('Gagal update username: $e');
      rethrow;
    }
  }

  Future<void> updatePhone(String newPhone) async {
    try {
      await ApiService.updatePhone(newPhone);
      phone = newPhone;
      notifyListeners();
    } catch (e) {
      debugPrint('Gagal update nomor: $e');
      rethrow;
    }
  }

  Future<void> updateAvatar() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      await ApiService.updateAvatar(File(image.path));
      await fetchProfile();  // Refresh profile data setelah update avatar
    } catch (e) {
      debugPrint('Gagal update avatar: $e');
    }
  }
}
