import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thedaging/app/modules/menujeroan/controllers/jeroandetails.dart';

class JeroanDetails extends StatelessWidget {
  final Map<String, String> itemData;
  final String description;
  final JeroanDetailsController controller = Get.put(JeroanDetailsController());
  final TextEditingController promoController = TextEditingController();

  JeroanDetails({
    required this.itemData,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.green.shade900),
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: 60,
              left: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            // Title
            Positioned(
              top: 105,
              left: MediaQuery.of(context).size.width * 0.33,
              child: Text(
                'Detail Produk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Main Content Container
            Positioned(
              top: 188,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/${itemData['image']}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Product Title
                    Text(
                      itemData['title'] ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Price Section
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.isPromoValid.value)
                          Text(
                            itemData['price'] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        Text(
                          controller.isPromoValid.value
                              ? controller.getDiscountedPrice(itemData['price'] ?? '')
                              : itemData['price'] ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: 20),

                    // Promo Code Input
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: promoController,
                              decoration: InputDecoration(
                                hintText: 'Enter promo code',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.validatePromoCode(promoController.text);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF074D09),
                                foregroundColor: Colors.white
                            ),
                            child: Text('Apply'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 150),

                    // Add to Cart Button

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}