import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();
  final ImagePicker imagePicker = ImagePicker();

  var name = 'Nama Pengguna'.obs;
  var email = 'email@example.com'.obs;
  var address = 'Jalan Contoh No.123'.obs;
  var phone = '00000000'.obs;
  var profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    name.value = storage.read('name') ?? 'Nama Pengguna';
    email.value = storage.read('email') ?? 'email@example.com';
    address.value = storage.read('address') ?? 'Jalan Contoh No.123';
    phone.value = storage.read('phone') ?? '00000000';
    profileImagePath.value = storage.read('profileImage') ?? '';
  }

  Future<void> saveProfile() async {
    await storage.write('name', name.value);
    await storage.write('email', email.value);
    await storage.write('address', address.value);
    await storage.write('phone', phone.value);
    if (profileImagePath.value.isNotEmpty) {
      await storage.write('profileImage', profileImagePath.value);
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
      await saveProfile();
    }
  }
}