import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'background.dart'; // Import Background widget
class EditProfileView extends StatelessWidget {
  final ProfileController _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Image Picker
                Obx(() => Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _controller.profileImagePath.value.isNotEmpty
                            ? FileImage(File(_controller.profileImagePath.value))
                            : const AssetImage('assets/default_avatar.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.green.shade900,
                          radius: 20,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: _controller.pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: 24),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Nama',
                          value: _controller.name.value,
                          onChanged: (value) => _controller.name.value = value,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Email',
                          value: _controller.email.value,
                          onChanged: (value) => _controller.email.value = value,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Alamat',
                          value: _controller.address.value,
                          onChanged: (value) => _controller.address.value = value,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'No. Telepon',
                          value: _controller.phone.value,
                          onChanged: (value) => _controller.phone.value = value,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            await _controller.saveProfile();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green.shade900, width: 2),
        ),
      ),
    );
  }
}
