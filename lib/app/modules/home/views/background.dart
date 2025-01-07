import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Gradien Latar Belakang Hijau, pastikan mengisi seluruh layar
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade700, Colors.green.shade300],
                stops: [0.3, 1],
              ),
            ),
          ),
        ),

        // Lapisan Ornamen Masjid
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/masjid.png', // Tambahkan gambar masjid di folder assets
            fit: BoxFit.contain, // Menggunakan properti yang mempertahankan proporsi asli gambar
            height: screenHeight * 0.7, // Menggunakan proporsi tinggi layar yang wajar
            alignment: Alignment.bottomCenter,
          ),
        ),

        // Konten Utama
        child,
      ],
    );
  }
}
