import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuDagingController extends GetxController {
  final GetStorage box = GetStorage();
  var items = <Map<String, String>>[].obs;

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
        {'title': 'Daging Potong', 'price': '\$40.00', 'image': 'Daging*2-removebg-preview 1.png'},
        {'title': 'Daging Ekor', 'price': '\$40.00', 'image': 'ekor-removebg-preview 1.png'},
        {'title': 'Daging Tetelan', 'price': '\$40.00', 'image': 'tetlan-removebg-preview 1.png'},
        {'title': 'Daging Lidah', 'price': '\$40.00', 'image': 'lidah-removebg-preview 1.png'},
      ]);
      saveData();
    }
  }

  String getItemDescription(String title) {
    return itemDescriptions[title] ?? 'Description not available';
  }
}