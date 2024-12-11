import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuTulangController extends GetxController {
  // Inisialisasi GetStorage
  final GetStorage _box = GetStorage();

  // List item yang sudah ada dan yang baru ditambahkan
  var items = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadData(); // Memuat data yang sudah disimpan
  }

  // Fungsi untuk menambahkan item baru
  void addItem(String title, String price, String image) {
    items.add({'title': title, 'price': price, 'image': image});
    _saveData(); // Menyimpan data setelah item baru ditambahkan
  }

  // Menyimpan data ke GetStorage
  void _saveData() {
    _box.write('tulangItems', items.toList());
  }

  // Memuat data dari GetStorage
  void _loadData() {
    var storedItems = _box.read('tulangItems');
    if (storedItems != null && storedItems is List) {
      // Mengonversi List<dynamic> menjadi List<Map<String, String>>
      items.assignAll(
        (storedItems as List).map((item) => Map<String, String>.from(item)).toList(),
      );
    } else {
      // Menambahkan data default jika belum ada data yang disimpan
      items.assignAll([
        {'title': 'Tulang sum-sum', 'price': '\$40.00', 'image': 'sumsum.png'},
        {'title': 'Tulang Iga', 'price': '\$40.00', 'image': 'Tulang Iga.png'},
        {'title': 'Belungan', 'price': '\$40.00', 'image': 'belungan.png'},
      ]);
      _saveData(); // Simpan data default di storage
    }
  }
}
