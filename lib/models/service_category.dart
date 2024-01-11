import 'package:flutter/material.dart';
import 'package:service_yuk/Screen/orderScreenHP.dart';

class ServiceCategory {
  String name;
  Color boxColor;
  Icon icon;
  VoidCallback? onTap;

  ServiceCategory(
      {required this.name,
      required this.boxColor,
      required this.icon,
      this.onTap});

  static List<ServiceCategory> getServiceCategory(BuildContext context) {
    List<ServiceCategory> serviceCategory = [];

    serviceCategory.add(ServiceCategory(
      name: 'Handphone',
      boxColor: const Color(0xff92A3FD),
      icon: const Icon(Icons.smartphone),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OrderHandphoneScreen(),
          ),
        );
        // Tambahkan logika untuk menangani ketika kategori "Handphone" diklik di sini
      },
    ));

    serviceCategory.add(ServiceCategory(
        name: 'Laptop',
        boxColor: const Color(0xffC58BF2),
        icon: const Icon(Icons.laptop_mac),
        onTap: () {}));

    serviceCategory.add(ServiceCategory(
        name: 'Komputer',
        boxColor: const Color(0xff92A3FD),
        icon: const Icon(Icons.computer),
        onTap: () {}));

    return serviceCategory;
  }
}
