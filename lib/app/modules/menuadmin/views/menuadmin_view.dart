import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../menudaging/controllers/daging_controller.dart';
import '../../menudaging/views/daging_view.dart';
import '../../menujeroan/controllers/jeroan_controller.dart';
import '../../menujeroan/views/jeroan_view.dart';
import '../../menutulang/controllers/tulang_controller.dart';
import '../../menutulang/views/tulang_view.dart';
import '../controllers/menuadmin_controller.dart';

class MenuAdminPage extends StatelessWidget {
  final MenuAdminController controller = Get.put(MenuAdminController());

  final List<String> menuOptions = ["Daging", "Jeroan", "Tulang"];

  @override
  Widget build(BuildContext context) {
    Get.put(MenuDagingController());
    Get.put(MenuJeroanController());
    Get.put(MenuTulangController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Admin",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.green.shade800,  // Menggunakan hijau gelap
      ),
      body: Container(
        // Menambahkan Container yang mencakup seluruh layar
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade900, Colors.green.shade600], // Gradasi hijau
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tambah Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Work Sans',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: controller.namaController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Nama Menu",
                      labelStyle: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Work Sans',
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: controller.hargaController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Harga",
                      labelStyle: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Work Sans',
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    return DropdownButton<String>(
                      value: controller.selectedMenu.value,
                      isExpanded: true,
                      dropdownColor: Colors.green.shade500,  // Hijau lebih terang
                      style: TextStyle(color: Colors.white),
                      items: menuOptions.map((String menu) {
                        return DropdownMenuItem<String>(
                          value: menu,
                          child: Text(
                            menu,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        controller.selectedMenu.value = newValue!;
                      },
                    );
                  }),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String nama = controller.namaController.text;
                      int harga =
                          int.tryParse(controller.hargaController.text) ?? 0;

                      // Mengirim data ke controller yang sesuai
                      if (controller.selectedMenu.value == "Daging") {
                        Get.find<MenuDagingController>().addItem(
                            nama, // title
                            '\$$harga', // price
                            'default.png' // image
                        );
                        Get.to(() => MenuDagingPage());
                      } else if (controller.selectedMenu.value == "Jeroan") {
                        Get.find<MenuJeroanController>().addItem(
                            nama, // title
                            '\$$harga', // price
                            'default.png' // image
                        );
                        Get.to(() => MenuJeroanPage());
                      } else if (controller.selectedMenu.value == "Tulang") {
                        Get.find<MenuTulangController>().addItem(
                            nama, // title
                            '\$$harga', // price
                            'default.png' // image
                        );
                        Get.to(() => MenuTulangPage());
                      }
                    },
                    child: Text(
                      "Kirim Data",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.green.shade300,  // Menggunakan hijau muda untuk tombol
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
