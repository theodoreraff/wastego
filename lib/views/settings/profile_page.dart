import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/providers/auth_provider.dart'; // Added
import 'package:wastego/core/providers/profile_provider.dart';
import 'package:wastego/core/services/api_service.dart'; // Added for SessionExpiredException
import 'package:wastego/routes/app_routes.dart'; // Added
import 'package:wastego/core/utils/constant.dart'; // For brand colors
import 'package:wastego/widgets/custom_button.dart'; // Re-use existing button if suitable

// Define brand colors (ensure these are defined in constant.dart or define here)
const Color brandGreen = Color(0xFFADEE00); // Primary Green
const Color brandDarkTeal = Color(0xFF003539); // Primary Dark Teal

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isEditingUsername = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      // Fetch profile and handle potential session expiry during initial load
      _fetchInitialProfile(profileProvider);
    });
  }

  Future<void> _fetchInitialProfile(ProfileProvider profileProvider) async {
    try {
      await profileProvider.fetchProfile();
      if (mounted) {
        _usernameController.text = profileProvider.username;
      }
    } on SessionExpiredException catch (e) {
      if (mounted) {
        _handleSessionExpired(e.message);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat profil: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _handleSessionExpired(String message) {
    if (!mounted) return;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    authProvider.logout(profileProvider).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.orange),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      }
    });
  }

  Future<void> _pickAndUploadAvatar(ProfileProvider provider) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null && mounted) {
      // Show loading SnackBar immediately
      final loadingSnackbar = SnackBar(
        content: Text('Mengunggah avatar...'),
        duration: Duration(minutes: 1),
      ); // Long duration
      ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar);

      try {
        await provider.updateAvatar(File(image.path));
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Avatar berhasil diperbarui!'),
              backgroundColor: brandGreen,
            ),
          );
        }
      } on SessionExpiredException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading
          _handleSessionExpired(e.message);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengunggah avatar. Silakan coba lagi.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _updateUsername(ProfileProvider provider) async {
    if (_usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username tidak boleh kosong.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_usernameController.text.trim() == provider.username) {
      setState(() => _isEditingUsername = false);
      return;
    }

    final loadingSnackbar = SnackBar(
      content: Text('Memperbarui username...'),
      duration: Duration(minutes: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(loadingSnackbar);

    try {
      await provider.updateUsername(_usernameController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username berhasil diperbarui!'),
            backgroundColor: brandGreen,
          ),
        );
        setState(() => _isEditingUsername = false);
      }
    } on SessionExpiredException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _handleSessionExpired(e.message);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui username. Silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    // Update controller if username changes from provider (e.g. after fetch)
    if (!_isEditingUsername &&
        _usernameController.text != profileProvider.username) {
      _usernameController.text = profileProvider.username;
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for modern feel
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: brandDarkTeal),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profil Saya',
          style: textTheme.titleLarge?.copyWith(
            color: brandDarkTeal,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:
          profileProvider.isLoading &&
                  profileProvider
                      .username
                      .isEmpty // Show loader only on initial full load
              ? const Center(
                child: CircularProgressIndicator(color: brandDarkTeal),
              )
              : RefreshIndicator(
                color: brandDarkTeal,
                onRefresh: () async {
                  // await profileProvider.fetchProfile();
                  // if (mounted) {
                  //   _usernameController.text = profileProvider.username;
                  // }
                  // Use the new _fetchInitialProfile to handle session expiry on refresh
                  final profileProv = Provider.of<ProfileProvider>(
                    context,
                    listen: false,
                  );
                  await _fetchInitialProfile(profileProv);
                },
                child: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    _buildAvatarSection(context, profileProvider, textTheme),
                    const SizedBox(height: 30),
                    _buildUsernameSection(context, profileProvider, textTheme),
                    const SizedBox(height: 20),
                    _buildInfoCard(context, profileProvider, textTheme),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'Keluar',
                      backgroundColor: brandDarkTeal,
                      textColor: brandGreen,
                      onPressed: () async {
                        final authProvider = Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        );
                        final profileProv = Provider.of<ProfileProvider>(
                          context,
                          listen: false,
                        );
                        // Show a confirmation dialog before logging out
                        final confirmLogout = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Konfirmasi Keluar'),
                              content: const Text(
                                'Apakah Anda yakin ingin keluar?',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(
                                      dialogContext,
                                    ).pop(false); // User chose not to logout
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Keluar',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.of(
                                      dialogContext,
                                    ).pop(true); // User confirmed logout
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmLogout == true && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Anda telah keluar.')),
                          );
                          await authProvider.logout(profileProv);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.login,
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildAvatarSection(
    BuildContext context,
    ProfileProvider provider,
    TextTheme textTheme,
  ) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _pickAndUploadAvatar(provider),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: brandGreen, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[200],
                    child:
                        provider.isLoading &&
                                provider
                                    .avatarUrl
                                    .isEmpty // Specific loading for avatar during initial fetch perhaps
                            ? const CircularProgressIndicator(
                              color: brandDarkTeal,
                            )
                            : provider.avatarUrl.isEmpty
                            ? const Icon(
                              // Explicit fallback for empty URL
                              Icons.person,
                              size: 70,
                              color: Colors.grey,
                            )
                            : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: provider.avatarUrl,
                                placeholder:
                                    (context, url) =>
                                        const CircularProgressIndicator(
                                          color: brandDarkTeal,
                                        ),
                                errorWidget:
                                    (context, url, error) => const Icon(
                                      Icons.person,
                                      size: 70,
                                      color: Colors.grey,
                                    ),
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: brandGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: brandDarkTeal, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildUsernameSection(
    BuildContext context,
    ProfileProvider provider,
    TextTheme textTheme,
  ) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child:
                  _isEditingUsername
                      ? TextFormField(
                        controller: _usernameController,
                        autofocus: true,
                        style: textTheme.headlineSmall?.copyWith(
                          color: brandDarkTeal,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Username Anda',
                          border: InputBorder.none,
                          isDense: true,
                          hintStyle: textTheme.headlineSmall?.copyWith(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onFieldSubmitted: (_) => _updateUsername(provider),
                      )
                      : Text(
                        provider.username.isNotEmpty
                            ? provider.username
                            : 'Nama Pengguna',
                        style: textTheme.headlineSmall?.copyWith(
                          color: brandDarkTeal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
            IconButton(
              icon: Icon(
                _isEditingUsername
                    ? Icons.check_circle_outline
                    : Icons.edit_outlined,
                color: brandGreen,
                size: 28,
              ),
              onPressed: () {
                if (_isEditingUsername) {
                  _updateUsername(provider);
                } else {
                  setState(() {
                    _isEditingUsername = true;
                    // Ensure controller has the latest username when starting edit
                    _usernameController.text = provider.username;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    ProfileProvider provider,
    TextTheme textTheme,
  ) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _buildInfoTile(
            context,
            icon: CupertinoIcons.phone_fill,
            label: 'No. HP',
            value: provider.phone.isNotEmpty ? provider.phone : '-',
            onTap:
                () => _showEditDialog(
                  context,
                  'No. HP',
                  provider.phone,
                  provider
                      .updatePhone, // Assuming this method exists and handles UI update
                  'Masukkan nomor telepon yang aktif.',
                ),
          ),
          _buildDivider(),
          _buildInfoTile(
            context,
            icon: CupertinoIcons.creditcard_fill,
            label: 'ID Pengguna',
            // Display wgoId if available, otherwise fallback to userId, then to "-"
            value:
                provider.wgoId.isNotEmpty
                    ? provider.wgoId
                    : (provider.userId.isNotEmpty ? provider.userId : '-'),
          ),
          // Add more tiles as needed, e.g., for email if not shown under avatar
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Icon(icon, color: brandDarkTeal, size: 26),
      title: Text(
        label,
        style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
      ),
      subtitle: Text(
        value,
        style: textTheme.titleLarge?.copyWith(
          color: brandDarkTeal,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing:
          onTap != null
              ? Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18)
              : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.grey[200], height: 1),
    );
  }

  // Re-introduce a simplified edit dialog or integrate editing differently
  void _showEditDialog(
    BuildContext context,
    String label,
    String initialValue,
    Future<void> Function(String) onSave,
    String subtitle,
  ) {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ubah $label',
                    style: textTheme.headlineSmall?.copyWith(
                      color: brandDarkTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: const TextStyle(color: brandDarkTeal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: brandGreen,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '$label tidak boleh kosong';
                      }
                      if (label == 'No. HP' &&
                          !RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                        return 'Masukkan nomor telepon yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: brandDarkTeal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            // Show loading indicator on button or dialog
                            // For simplicity, direct call here
                            try {
                              await onSave(controller.text.trim());
                              if (mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '$label berhasil diperbarui!',
                                    ),
                                    backgroundColor: brandGreen,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Gagal memperbarui $label: ${e.toString()}',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Add a method to ProfileProvider to clear data on logout
// Example extension to ProfileProvider (should be in the provider file)
/*
extension ProfileProviderExtension on ProfileProvider {
  void clearProfileData() {
    username = '';
    phone = '';
    userId = '';
    avatarUrl = '';
    email = ''; // if you add email
    notifyListeners();
  }
}
*/
