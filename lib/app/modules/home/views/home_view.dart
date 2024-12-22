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
import '../controllers/cart_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello, the Daging's",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.red.shade900),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.red.shade900,
                          size: 30,
                        ),
                      ),
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
                    const Text(
                      "Rekomendasi daging untukmu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
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
                if (Get.find<AuthController>().userEmail.value != "admin123@gmail.com")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Keranjang Belanja",
                      style: TextStyle(
                        fontSize: 20,
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
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (Get.find<AuthController>().userEmail.value != "admin123@gmail.com")
                  SizedBox(
                    height: 120,
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
        selectedItemColor: Colors.red.shade900,
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
      floatingActionButton: Get.find<AuthController>().userEmail.value == "admin123@gmail.com"
          ? Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 700.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => MenuAdminPage());
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
        if (title == "Daging") {
          Get.to(() => MenuDagingPage());
        } else if (title == "Jeroan") {
          Get.to(() => MenuJeroanPage());
        } else if (title == "Tulang") {
          Get.to(() => MenuTulangPage());
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
      width: 150,
      constraints: const BoxConstraints(
        maxHeight: 180,
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
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
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
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jumlah: $quantity',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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