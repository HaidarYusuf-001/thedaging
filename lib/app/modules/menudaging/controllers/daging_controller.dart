import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../home/controllers/cart_controller.dart';

class MenuDagingController extends GetxController {
  final GetStorage box = GetStorage();
  var items = <Map<String, String>>[].obs;
  final CartController cartController = Get.find<CartController>();
  final authController = Get.find<AuthController>();

  // Updated admin check using AuthController
  bool get isAdmin => authController.userEmail.value == "admin123@gmail.com";

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void addItem(String title, String price, String image) {
    items.add({'title': title, 'price': price, 'image': image});
    saveData();
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

  void saveData() {
    box.write('dagingItems', items.toList());
  }

  void loadData() {
    var storedItems = box.read('dagingItems');
    if (storedItems != null && storedItems is List) {
      items.assignAll(
        (storedItems as List).map((item) => Map<String, String>.from(item)).toList(),
      );
    } else {
      items.assignAll([
        {'title': 'Daging Potong', 'price': 'Rp 40.000', 'image': 'Daging*2-removebg-preview 1.png'},
        {'title': 'Daging Ekor', 'price': 'Rp 40.000', 'image': 'ekor-removebg-preview 1.png'},
        {'title': 'Daging Tetelan', 'price': 'Rp 40.000', 'image': 'tetlan-removebg-preview 1.png'},
        {'title': 'Daging Lidah', 'price': 'Rp 40.000', 'image': 'lidah-removebg-preview 1.png'},
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