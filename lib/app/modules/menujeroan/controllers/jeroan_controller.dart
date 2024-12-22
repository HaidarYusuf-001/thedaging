import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../home/controllers/cart_controller.dart';

class MenuJeroanController extends GetxController {
  final box = GetStorage();
  var items = <Map<String, String>>[].obs;
  final CartController cartController = Get.find<CartController>();
  final authController = Get.find<AuthController>();

  // Updated admin check using AuthController
  bool get isAdmin => authController.userEmail.value == "admin123@gmail.com";

  @override
  void onInit() {
    super.onInit();
    loadData(); // Memuat data yang sudah disimpan
  }

  // Fungsi untuk menambahkan item baru
  void addItem(String title, String price, String image) {
    items.add({'title': title, 'price': price, 'image': image});
    saveData(); // Menyimpan data setelah item baru ditambahkan
  }

  void deleteItem(int index) {
    if (isAdmin) {
      items.removeAt(index);
      saveData();
      Get.snackbar(
        'Item Deleted',
        'Item has been removed from the menu',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    }
  }

  // Menyimpan data ke GetStorage
  void saveData() {
    box.write('jeroanItems', items.toList());
  }

  // Memuat data dari GetStorage
  void loadData() {
    var storedItems = box.read('jeroanItems');
    if (storedItems != null && storedItems is List) {
      items.assignAll(
        (storedItems as List).map((item) => Map<String, String>.from(item)).toList(),
      );
    } else {
      items.assignAll([
        {'title': 'Hati', 'price': 'Rp 40.000', 'image': 'Hati.png'},
        {'title': 'Usus', 'price': 'Rp 40.000', 'image': 'Usus.png'},
        {'title': 'Babat', 'price': 'Rp 40.000', 'image': 'Babat.png'},
        {'title': 'Cingur', 'price': 'Rp 40.000', 'image': 'Cingur.png'},
      ]);
      saveData();
    }
  }
  void addToCart(String title, String price, String image) {
    cartController.addToCart(title, price, 'assets/images/$image', 1);
    Get.snackbar(
      'Added to Cart',
      '$title has been added to your cart',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }
}
