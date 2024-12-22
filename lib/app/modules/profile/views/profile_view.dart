import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';
import 'background.dart';

class ProfileView extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _controller.storage.erase();
              Get.offAllNamed('/login');
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
              children: [
                // Profile Image Section
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _controller.profileImagePath.value.isNotEmpty
                            ? FileImage(File(_controller.profileImagePath.value))
                            : const AssetImage('assets/default_avatar.png') as ImageProvider,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Hai, ${_controller.name.value} 👋',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),

                // Profile Menu Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.person,
                        title: 'Informasi Profil',
                        subtitle: 'Nama, Email, Alamat, No. Telepon',
                        onTap: () => Get.toNamed('/editprofile'),
                      ),
                      _buildMenuItem(
                        icon: Icons.shopping_bag,
                        title: 'Pesanan Saya',
                        subtitle: 'Lihat riwayat pesanan',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.favorite,
                        title: 'Wishlist',
                        subtitle: 'Produk yang Anda simpan',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.location_on,
                        title: 'Alamat Tersimpan',
                        subtitle: 'Atur alamat pengiriman',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.payment,
                        title: 'Pembayaran',
                        subtitle: 'Metode pembayaran tersimpan',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.settings,
                        title: 'Setting',
                        subtitle: 'Gatau pokonya buat setting',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.red.shade900),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}