import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../home/controllers/cart_controller.dart';

class MenuTulangController extends GetxController {
  final GetStorage box = GetStorage();
  var items = <Map<String, String>>[].obs;
  final CartController cartController = Get.find<CartController>();
  final authController = Get.find<AuthController>();

  // Updated admin check using AuthController
  bool get isAdmin => authController.userEmail.value == "admin123@gmail.com";

  // Add descriptions for each item
  final Map<String, String> itemDescriptions = {
    'Daging Potong': 'Daging sapi premium yang dipotong dengan presisi untuk berbagai keperluan memasak.',
    'Daging Ekor': 'Bagian ekor sapi yang kaya rasa, cocok untuk sup dan semur.',
    'Daging Tetelan': 'Potongan daging dengan lemak yang ideal untuk masakan berkuah.',
    'Daging Lidah': 'Bagian lidah sapi yang lembut, sempurna untuk hidangan spesial.',
  };

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void addItem(String title, String price, String image) {
    items.add({'title': title, 'price': price, 'image': image});
    saveData();
  }

  void saveData() {
    box.write('tulangItems', items.toList());
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

  void addToCart(String title, String price, String image) {
    cartController.addToCart(title, price, 'assets/images/$image', 1);
    Get.snackbar(
      'Added to Cart',
      '$title has been added to your cart',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  void loadData() {
    var storedItems = box.read('tulangItems');
    if (storedItems != null && storedItems is List) {
      items.assignAll(
        (storedItems as List).map((item) => Map<String, String>.from(item)).toList(),
      );
    } else {
      items.assignAll([
        {'title': 'Tulang sum-sum', 'price': '\$40.00', 'image': 'sumsum.png'},
        {'title': 'Tulang Iga', 'price': '\$40.00', 'image': 'Tulang Iga.png'},
        {'title': 'Belungan', 'price': '\$40.00', 'image': 'belungan.png'},
      ]);
      saveData();
    }
  }



  String getItemDescription(String title) {
    return itemDescriptions[title] ?? 'Description not available';
  }
}