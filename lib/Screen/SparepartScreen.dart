import 'package:flutter/material.dart';

class SparePart {
  final String name;
  final String category;
  final String deviceType; // e.g., handphone, laptop, etc.
  final String brand;
  final double price;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'deviceType': deviceType,
      'brand': brand,
      'price': price,
    };
  }

  SparePart(
      {required this.name,
      required this.category,
      required this.deviceType,
      required this.brand,
      required this.price});
}

class SparePartsScreen extends StatefulWidget {
  const SparePartsScreen({super.key});

  @override
  _SparePartsScreenState createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  List<SparePart> spareParts = [
    SparePart(
        name: "Screen A",
        category: "Screen",
        deviceType: "Handphone",
        brand: "Brand A",
        price: 50.0),
    // Add more spare parts here
  ];

  List<SparePart> displayedSpareParts = [];

  @override
  void initState() {
    super.initState();
    displayedSpareParts = spareParts;
  }

  void _searchSparePart(String query) {
    final results = spareParts.where((part) {
      final partName = part.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return partName.contains(searchLower);
    }).toList();

    setState(() {
      displayedSpareParts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Spare Part')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchSparePart,
              decoration: const InputDecoration(
                labelText: 'Search Spare Parts',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedSpareParts.length,
              itemBuilder: (context, index) {
                final part = displayedSpareParts[index];
                return ListTile(
                  title: Text(part.name),
                  subtitle: Text('${part.brand} - \$${part.price}'),
                  onTap: () {
                    Navigator.pop(context, part);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
