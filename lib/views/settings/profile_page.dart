import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wastego/core/providers/profile_provider.dart';
import 'package:wastego/widgets/custom_button.dart';

/// A page displaying and allowing editing of user profile information.
/// It fetches user data, supports avatar updates, and allows editing of name and phone number.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _isUpdatingAvatar = false;
  late final AnimationController _avatarButtonController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch profile data after the first frame is rendered.
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      profileProvider.fetchProfile();
    });
    _avatarButtonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _avatarButtonController.dispose();
    super.dispose();
  }

  /// Handles the avatar tap, triggering an animation and avatar update.
  Future<void> _onAvatarTap(ProfileProvider profile) async {
    await _avatarButtonController.reverse();
    await _avatarButtonController.forward();
    setState(() => _isUpdatingAvatar = true);
    await profile.updateAvatar();
    setState(() => _isUpdatingAvatar = false);
  }

  /// Shows a dialog for editing profile information (name, phone number).
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
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ubah $label',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: label,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF003D3D),
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
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                      child: const Text('Batal'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003D3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await onSave(controller.text.trim());
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            Text(
              'Profil',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),

      body:
          profile.isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF003D3D)),
              )
              : RefreshIndicator(
                color: const Color(0xFF003D3D),
                onRefresh: () async => profile.fetchProfile(),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF003D3D,
                                  ).withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 72,
                              backgroundColor: Colors.grey[100],
                              child: ClipOval(
                                child:
                                    profile.avatarUrl.isNotEmpty
                                        ? Image.network(
                                          profile.avatarUrl,
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.person,
                                                    size: 90,
                                                    color: Colors.grey,
                                                  ),
                                        )
                                        : const Icon(
                                          Icons.person,
                                          size: 90,
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ScaleTransition(
                              scale: _avatarButtonController,
                              child: Material(
                                color: const Color(0xFF003D3D),
                                shape: const CircleBorder(),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap:
                                      _isUpdatingAvatar
                                          ? null
                                          : () => _onAvatarTap(profile),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child:
                                        _isUpdatingAvatar
                                            ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.white,
                                              ),
                                            )
                                            : const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 26,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Card(
                      color: const Color(0xFFFAFFDF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 6,
                      child: Column(
                        children: [
                          _buildInfoTile(
                            icon: Icons.person,
                            iconColor: const Color(0xFF003D3D),
                            label: 'Nama',
                            subtitle: 'Hai, siapa namamu?',
                            value:
                                profile.username.isNotEmpty
                                    ? profile.username
                                    : '-',
                            onEdit:
                                () => _showEditDialog(
                                  context,
                                  'Nama',
                                  profile.username,
                                  profile.updateUsername,
                                  'Isi namamu di sini',
                                ),
                          ),
                          const Divider(color: Colors.grey, height: 0),
                          _buildInfoTile(
                            icon: Icons.phone,
                            iconColor: const Color(0xFF003D3D),
                            label: 'No. HP',
                            subtitle: 'Nomor HP untuk notifikasi penting',
                            value:
                                profile.phone.isNotEmpty ? profile.phone : '-',
                            onEdit:
                                () => _showEditDialog(
                                  context,
                                  'No. HP',
                                  profile.phone,
                                  profile.updatePhone,
                                  'Masukkan nomor telepon yang aktif',
                                ),
                          ),
                          const Divider(color: Colors.grey, height: 0),
                          _buildInfoTile(
                            icon: Icons.badge,
                            iconColor: const Color(0xFF003D3D),
                            label: 'ID Pengguna',
                            subtitle: 'ID unik kamu (tidak bisa diubah)',
                            value:
                                profile.userId.isNotEmpty
                                    ? profile.userId
                                    : '-',
                            onEdit: null, // User ID is not editable.
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      text: 'Keluar', // Logout button.
                      backgroundColor: const Color(0xFF003D3D),
                      textColor: const Color(0xFFB8FF00),
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (route) => false,
                          );
                        }
                      },
                      isLoading: false,
                    ),
                  ],
                ),
              ),
    );
  }

  /// Helper widget to build a consistent information tile for profile details.
  Widget _buildInfoTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required String value,
    VoidCallback? onEdit,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: iconColor.withOpacity(0.15),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        label,
        style: textTheme.titleMedium?.copyWith(
          color: Colors.grey[800],
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
      ),
      trailing:
          onEdit != null
              ? IconButton(
                icon: Icon(Icons.edit, color: iconColor),
                onPressed: onEdit,
                tooltip: 'Ubah $label',
              )
              : null,
      isThreeLine: true,
      dense: false,
    );
  }
}
