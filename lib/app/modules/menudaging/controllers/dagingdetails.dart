import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'daging_controller.dart';

class DagingDetailsController extends GetxController {
  final isPromoValid = false.obs;
  final promoCode = ''.obs;
  final discount = 0.05; // 5% discount
  final MenuDagingController menuDagingController = Get.find<MenuDagingController>();

  // Method to calculate discounted price and update MenuDagingController
  String getDiscountedPrice(String originalPrice, int index) {
    if (!isPromoValid.value) return originalPrice;

    double price = double.parse(originalPrice.replaceAll('\$', ''));
    double discountedPrice = price * (1 - discount);
    String newPrice = '\$${discountedPrice.toStringAsFixed(2)}';

    // Update the price in MenuDagingController as well
    menuDagingController.updateItemPrice(index, newPrice);

    return newPrice;
  }

  // Method to validate promo code
  void validatePromoCode(String code) {
    if (code.toUpperCase() == 'LEBARAN5') {
      isPromoValid.value = true;
      promoCode.value = code;
      Get.snackbar(
        'Success',
        'Promo code applied! 5% discount',
        backgroundColor: Color(0xFF074D09),
        colorText: Colors.white,
      );
    } else {
      isPromoValid.value = false;
      promoCode.value = '';
      Get.snackbar(
        'Error',
        'Invalid promo code',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}