import 'package:flutter/material.dart';
import 'components/setting_list.dart';
import 'components/version_tile.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Lainnya'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [SettingList(), SizedBox(height: 12), VersionTile()],
      ),
    );
  }
}
