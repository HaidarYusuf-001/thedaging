import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child; // Widget yang akan menjadi anak dari latar belakang

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Mengatur lebar menjadi tak terbatas
        height: double.infinity, // Mengatur tinggi menjadi tak terbatas
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade900,
              Colors.red.shade900,
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.2, 0.9, 0.5], // Membuat peralihan gradasi lebih dramatis
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // Menambahkan efek border radius untuk kesan halus
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/your_image.png'), // Menambahkan gambar di latar belakang
                fit: BoxFit.cover,
                opacity: 0.1, // Mengatur transparansi gambar agar tidak terlalu dominan
              ),
            ),
            child: child, // Menambahkan child yang disertakan, yaitu konten utama dari halaman
          ),
        ),
      ),
    );
  }
}
