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
        title: Text("Menu Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.namaController,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              return DropdownButton<String>(
                value: controller.selectedMenu.value,
                items: menuOptions.map((String menu) {
                  return DropdownMenuItem<String>(
                    value: menu,
                    child: Text(menu),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.selectedMenu.value = newValue!;
                },
              );
            }),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String nama = controller.namaController.text;
                int harga = int.tryParse(controller.hargaController.text) ?? 0;

                // Mengirim data ke controller yang sesuai
                if (controller.selectedMenu.value == "Daging") {
                // Memastikan controller sudah dipasang dan menambah item
                Get.find<MenuDagingController>().addItem(
                nama, // title
                '\$$harga', // price
                'default.png' // image
                );
                Get.to(() => MenuDagingPage());
                }
                else if (controller.selectedMenu.value == "Jeroan") {
                  // Memastikan controller sudah dipasang dan menambah item
                  Get.find<MenuJeroanController>().addItem(
                      nama, // title
                      '\$$harga', // price
                      'default.png' // image
                  );
                  Get.to(() => MenuJeroanPage());
                }
                else if (controller.selectedMenu.value == "Tulang") {
                  // Memastikan controller sudah dipasang dan menambah item
                  Get.find<MenuTulangController>().addItem(
                      nama, // title
                      '\$$harga', // price
                      'default.png' // image
                  );
                  Get.to(() => MenuTulangPage());
                }
              },
              child: Text("Kirim Data"),
            ),
          ],
        ),
      ),
    );
  }
}
