import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final box = GetStorage();
  var cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCartData();
  }

  void addToCart(String title, String price, String imagePath, int quantity) {
    // Check if item already exists in cart
    final existingItemIndex = cartItems.indexWhere((item) => item['title'] == title);

    if (existingItemIndex >= 0) {
      // Update quantity if item exists
      cartItems[existingItemIndex]['quantity'] += quantity;
    } else {
      // Add new item if it doesn't exist
      cartItems.add({
        'title': title,
        'price': price,
        'imagePath': imagePath,
        'quantity': quantity,
      });
    }
    saveCartData();
  }

  void removeFromCart(String title) {
    cartItems.removeWhere((item) => item['title'] == title);
    saveCartData();
  }

  void updateQuantity(String title, int quantity) {
    final index = cartItems.indexWhere((item) => item['title'] == title);
    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index]['quantity'] = quantity;
      }
      saveCartData();
    }
  }

  void saveCartData() {
    box.write('cartItems', cartItems.toList());
  }

  void loadCartData() {
    final storedItems = box.read('cartItems');
    if (storedItems != null) {
      cartItems.assignAll(List<Map<String, dynamic>>.from(storedItems));
    }
  }
}