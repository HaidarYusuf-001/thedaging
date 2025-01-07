import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
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
import '../controllers/cart_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final CartController cartController = Get.find<CartController>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    // Tampilkan Snackbar saat halaman dimuat, tetapi hanya sekali
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Ambil SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      bool hasShownSnackbar = prefs.getBool('hasShownSnackbar') ?? false;

      if (!hasShownSnackbar) {
        // Tampilkan Snackbar jika belum ditampilkan
        Get.snackbar(
          "Event Lebaran Idul Adha",
          "Nikmati diskon 5% dengan kode LEBARAN5",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
          duration: const Duration(seconds: 5),
          icon: const Icon(Icons.local_offer, color: Colors.green),
        );

        // Simpan status bahwa Snackbar sudah ditampilkan
        await prefs.setBool('hasShownSnackbar', true);
      }
    });

    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 60 : 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                      "Hello, ${profileController.name.value}",
                      style: TextStyle(
                        fontSize: isTablet ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView()),
                          );
                        },
                        child: Obx(() => Container(
                          width: isTablet ? 60 : 44,
                          height: isTablet ? 60 : 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.green.shade900),
                          ),
                          child: profileController
                              .profileImagePath.value.isNotEmpty
                              ? ClipOval(
                            child: Image.file(
                              File(profileController
                                  .profileImagePath.value),
                              width: isTablet ? 60 : 44,
                              height: isTablet ? 60 : 44,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Icon(
                            Icons.person,
                            color: Colors.green.shade900,
                            size: isTablet ? 40 : 30,
                          ),
                        ))),
                  ],
                ),
                Text(
                  "Mau pesan daging apa hari ini?",
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
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
                const SizedBox(height: 16),
                Card(
                  color: Colors.green.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.campaign, color: Colors.orange.shade900, size: 40),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Promo Lebaran Idul Adha 🎉",
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Nikmati diskon 5% untuk semua pembelian dengan kode promo LEBARAN5. Berlaku hingga 15 Januari!",
                                style: TextStyle(
                                  fontSize: isTablet ? 16 : 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Kategori",
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 22,
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
                      isSelected: true,
                    ),
                    CategoryCard(
                      title: "Jeroan",
                      icon: Icons.restaurant_menu,
                    ),
                    CategoryCard(
                      title: "Tulang",
                      icon: Icons.restaurant_menu,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rekomendasi daging untukmu",
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.black,
                      size: isTablet ? 30 : 24,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: isTablet ? 250 : 200,
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
                const SizedBox(height: 24),
                if (Get.find<AuthController>().userEmail.value == "admin123@gmail.com")
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => MenuAdminPage());
                      },
                      backgroundColor: Colors.green.shade900,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                const SizedBox(height: 24),
                if (Get.find<AuthController>().userEmail.value != "admin123@gmail.com")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Keranjang Belanja",
                        style: TextStyle(
                          fontSize: isTablet ? 26 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to cart page
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (Get.find<AuthController>().userEmail.value != "admin123@gmail.com")
                  SizedBox(
                    height: isTablet ? 150 : 250,
                    child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return CartItemCard(
                          title: item['title'],
                          price: item['price'],
                          quantity: item['quantity'],
                          imagePath: item['imagePath'],
                        );
                      },
                    )),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(() => MainPage());
              break;
            case 1:
              Get.to(() => HistoryPage());
              break;
            case 2:
              Get.to(() => FavoritPage());
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
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return GestureDetector(
      onTap: () {
        if (title == "Daging") {
          Get.to(() => MenuDagingPage());
        } else if (title == "Jeroan") {
          Get.to(() => MenuJeroanPage());
        } else if (title == "Tulang") {
          Get.to(() => MenuTulangPage());
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 40 : 30, vertical: isTablet ? 12 : 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green.shade900),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected ? Colors.white : Colors.green.shade900,
                size: isTablet ? 28 : 24),
            SizedBox(height: isTablet ? 10 : 6),
            Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 16 : 14,
                color: isSelected ? Colors.white : Colors.green.shade900,
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
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      width: isTablet ? 200 : 150,
      constraints: BoxConstraints(
        maxHeight: isTablet ? 220 : 180,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: isTablet ? 120 : 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 18 : 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 18),
              const SizedBox(width: 4),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
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

class CartItemCard extends StatelessWidget {
  final String title;
  final String price;
  final int quantity;
  final String imagePath;

  const CartItemCard({
    Key? key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    // Calculate dynamic sizes based on screen width
    double imageSize = isTablet ? screenWidth * 0.25 : screenWidth * 0.3;
    double textSize = isTablet ? 18.0 : 16.0;
    double padding = isTablet ? 16.0 : 12.0;

    return Container(
      width: isTablet ? 180 : 140,
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.all(padding),
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
      child: ListView(
        children: [
          // Adjust image size dynamically based on screen size
          Image.asset(
            imagePath,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp $price",
                  style: TextStyle(
                    fontSize: textSize - 2,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Jumlah: $quantity",
                  style: TextStyle(
                    fontSize: textSize - 2,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
