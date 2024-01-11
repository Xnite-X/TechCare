import 'package:flutter/material.dart';

class JenisKerusakan extends StatelessWidget {
  const JenisKerusakan({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar produk dengan nama dan nama ikon kerusakan
    final List<Map<String, String>> products = [
      {
        'name': 'Handphone 1',
        'issue': 'Cracked Screen',
      },
      {
        'name': 'Handphone 2',
        'issue': 'Total Blackout',
      },
      // Tambahkan produk lain dengan nama dan nama ikon kerusakan
    ];

    // Map untuk memetakan nama kerusakan ke ikon
    final Map<String, IconData> issueIcons = {
      'Cracked Screen': Icons.screen_lock_portrait,
      'Total Blackout': Icons.power_off,
      // Tambahkan ikon lain sesuai kebutuhan
    };

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Jumlah kolom
        crossAxisSpacing: 8.0, // Jarak antar kolom
        mainAxisSpacing: 8.0, // Jarak antar baris
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final productName = product['name'] ?? '';
        final productIssue = product['issue'] ?? '';

        // Ambil ikon yang sesuai dengan nama kerusakan
        final issueIcon = issueIcons[productIssue] ?? Icons.error;

        return GestureDetector(
          onTap: () {
            // Tambahkan logika ketika produk ditekan
          },
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  issueIcon, // Tampilkan ikon kerusakan
                  size: 50.0, // Sesuaikan ukuran ikon sesuai kebutuhan
                  color: Colors.blue, // Sesuaikan warna ikon sesuai kebutuhan
                ),
                const SizedBox(height: 8.0),
                Text(
                  productName,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
