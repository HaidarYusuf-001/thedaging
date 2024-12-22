import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thedaging/app/modules/home/views/background.dart';
import 'package:thedaging/app/modules/profile/views/profile_view.dart';

import '../../favorit/views/favorit_view.dart';
import '../../history/views/history_view.dart';
import '../../menuadmin/views/menuadmin_view.dart';
import '../../menudaging/views/daging_view.dart';
import '../../menujeroan/views/jeroan_view.dart';
import '../../menutulang/views/tulang_view.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // Wrap the content in SingleChildScrollView for better scroll behavior
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Jarak dari atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                      "Hello, ${profileController.name.value}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ProfileView()),
                        );
                      },
                      child: Obx(() => Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.red.shade900),
                        ),
                        child: profileController.profileImagePath.value.isNotEmpty
                            ? ClipOval(
                          child: Image.file(
                            File(profileController.profileImagePath.value),
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(
                          Icons.person,
                          color: Colors.red.shade900,
                          size: 30,
                        ),
                      )),
                    ),
                  ],
                ),

                const Text(
                  "Mau pesan daging apa hari ini?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Temukan favorit Anda',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  "Kategori",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(
                        title: "Daging",
                        icon: Icons.restaurant_menu,
                        isSelected: true),

                    CategoryCard(title: "Jeroan", icon: Icons.restaurant_menu),
                    CategoryCard(title: "Tulang", icon: Icons.restaurant_menu),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Aligns content on both sides
                  children: [
                    const Text(
                      "Rekomendasi daging untukmu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons
                          .arrow_circle_right_outlined, // Use the appropriate arrow icon
                      color: Colors.black, // Set the color for the icon
                      size: 24, // Adjust the size of the icon
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // Limit the height of the ListView to avoid stretching
                SizedBox(
                  height: 200, // Increased height for more visible cards
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      RecommendationCard(
                        title: "Daging Potong",
                        rating: 4.5,
                        imagePath: 'assets/images/daging.png',
                      ),
                      RecommendationCard(
                        title: "Tulang Iga",
                        rating: 4.8,
                        imagePath: 'assets/images/iga.png',
                      ),
                      RecommendationCard(
                        title: "Lidah Sapi",
                        rating: 4.5,
                        imagePath: 'assets/images/lidah.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30), // Extra space at the bottom
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(() => MainPage()); // Navigasi ke BerandaPage
              break;
            case 1:
              Get.to(() => HistoryPage()); // Navigasi ke HistoryPage
              break;
            case 2:
              Get.to(() => FavoritPage()); // Navigasi ke FavoritPage
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorit',
          ),
        ],
      ),
      // Tombol "+", hanya ditampilkan jika user email adalah admin123@gmail.com
      floatingActionButton: Get.find<AuthController>().userEmail.value == "admin123@gmail.com"
          ? Align(
        alignment: Alignment.topCenter, // Posisi tombol di tengah atas
        child: Padding(
          padding: const EdgeInsets.only(top: 700.0), // Jarak dari atas
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => MenuAdminPage()); // Navigasi ke MenuDagingPage
            },
            backgroundColor: Colors.red.shade900,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi berdasarkan kategori
        if (title == "Daging") {
          Get.to(() => MenuDagingPage()); // Navigasi ke MenuDagingPage
        } else if (title == "Jeroan") {
          Get.to(() => MenuJeroanPage()); // Navigasi ke MenuJeroanPage
        } else if (title == "Tulang") {
          Get.to(() => MenuTulangPage()); // Navigasi ke MenuTulangPage
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.red.shade900),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.red.shade900),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RecommendationCard extends StatelessWidget {
  final String title;
  final double rating;
  final String imagePath;

  const RecommendationCard({
    Key? key,
    required this.title,
    required this.rating,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Keeping width larger for better visibility
      constraints: const BoxConstraints(
        maxHeight: 180, // Increase max height to accommodate larger image
      ),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center content horizontally
        children: [
          // Make the image larger and ensure it fits the card properly
          Image.asset(
            imagePath,
            height: 100, // Increased height for the image
            fit: BoxFit
                .cover, // Ensures the image fits properly within the space
          ),
          const SizedBox(height: 8), // Add some space between image and text
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1, // Limit to 1 line for title
            overflow: TextOverflow.ellipsis, // Truncate text if it's too long
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8), // Add some space between text and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the row
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 18),
              const SizedBox(width: 4),
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
