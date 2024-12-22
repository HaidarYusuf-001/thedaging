import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tulang_controller.dart';

class MenuTulangPage extends StatelessWidget {
  final MenuTulangController controller = Get.put(MenuTulangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.red.shade900),
        child: Stack(
          children: [
            Positioned(
              top: 60, // Atur posisi vertikal (contohnya 40 untuk jarak dari atas)
              left: 16, // Atur posisi horizontal (contohnya 16 untuk jarak dari kiri)
              child: GestureDetector(
                onTap: () {
                  Get.back(); // Kembali ke halaman sebelumnya
                },
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 24, // Sesuaikan ukuran lebar gambar
                  height: 24, // Sesuaikan ukuran tinggi gambar
                ),
              ),
            ),
            Positioned(
              top: 105,
              left: MediaQuery.of(context).size.width * 0.33,
              child: Text(
                'Menu Tulang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              top: 188,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: ShapeDecoration(
                  color: Color(0xFFEFAEAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 185,
              left: 6,
              right: 6,
              child: Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: _buildItemContainer(
                        item['title']!,
                        item['price']!,
                        'assets/images/${item['image']}', index
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemContainer(String title, String price, String imagePath, int index) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3D074D09),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 94,
              height: 81,
              decoration: ShapeDecoration(
                color: Color(0xFFE0E0E0),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // Tombol Delete
              if (controller.isAdmin)
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text('Delete Item'),
                        content: Text('Are you sure you want to delete this item?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteItem(index);
                              Get.back();
                            },
                            child: Text('Delete'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              // Tombol Favorit
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/images/ci_heart-01.png',
                  width: 24,
                  height: 24,
                ),
              ),
              // Tombol Add
              GestureDetector(
                onTap: () {
                  controller.addToCart(title, price, imagePath.split('/').last);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                  decoration: ShapeDecoration(
                    color: Color(0xFF074D09),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
