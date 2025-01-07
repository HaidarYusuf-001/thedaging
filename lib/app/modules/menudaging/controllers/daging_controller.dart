import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../home/controllers/cart_controller.dart';

class MenuDagingController extends GetxController {
  final GetStorage box = GetStorage();
  var items = <Map<String, String>>[].obs;  // Corrected to Map<String, String>
  final CartController cartController = Get.find<CartController>();
  final authController = Get.find<AuthController>();

  bool get isAdmin => authController.userEmail.value == "admin123@gmail.com";

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
    box.write('dagingItems', items.toList());
  }

  void deleteItem(int index) {
    if (isAdmin) {
      items.removeAt(index);
      saveData();
      Get.snackbar('Item Deleted', 'Item has been removed from the menu', snackPosition: SnackPosition.TOP);
    }
  }

  void addToCart(String title, String price, String image) {
    cartController.addToCart(title, price, 'assets/images/$image', 1);
    Get.snackbar('Added to Cart', '$title has been added to your cart', snackPosition: SnackPosition.TOP);
  }

  void loadData() {
    var storedItems = box.read('dagingItems');
    if (storedItems != null && storedItems is List) {
      items.assignAll((storedItems as List).map((item) => Map<String, String>.from(item)).toList());
    } else {
      items.assignAll([
        {'title': 'Daging Potong', 'price': '\$40.00', 'image': 'Daging_2-removebg-preview 1.png'},
        {'title': 'Daging Ekor', 'price': '\$40.00', 'image': 'ekor-removebg-preview 1.png'},
        {'title': 'Daging Tetelan', 'price': '\$40.00', 'image': 'tetlan-removebg-preview 1.png'},
        {'title': 'Daging Lidah', 'price': '\$40.00', 'image': 'lidah-removebg-preview 1.png'},
      ]);
      saveData();
    }
  }

  void updateItemPrice(int index, String newPrice) {
    items[index]['price'] = newPrice;
    saveData();
  }

  String getItemDescription(String title) {
    return itemDescriptions[title] ?? 'Description not available';
  }
}
