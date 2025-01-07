import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JeroanDetailsController extends GetxController {
  final isPromoValid = false.obs;
  final promoCode = ''.obs;
  final discount = 0.05; // 5% discount

  // Method to validate promo code
  void validatePromoCode(String code) {
    if (code.toUpperCase() == 'DAGING5') {
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

  // Calculate discounted price
  String getDiscountedPrice(String originalPrice) {
    if (!isPromoValid.value) return originalPrice;

    double price = double.parse(originalPrice.replaceAll('\$', ''));
    double discountedPrice = price * (1 - discount);
    return '\$${discountedPrice.toStringAsFixed(2)}';
  }
}