import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxString userEmail = ''.obs; // Tambahkan variable untuk menyimpan email pengguna

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setUserEmail); // Perbarui userEmail saat status pengguna berubah
    super.onInit();
  }

  void _setUserEmail(User? user) {
    if (user != null) {
      userEmail.value = user.email ?? ''; // Simpan email pengguna
    } else {
      userEmail.value = ''; // Kosongkan jika pengguna logout
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home'); // Navigasi ke home setelah login
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home'); // Navigasi ke home setelah registrasi
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login'); // Navigasi ke login setelah logout
  }
}
