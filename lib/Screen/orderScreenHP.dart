import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_yuk/Screen/PaymentMethodScreen.dart';
import 'package:service_yuk/Screen/SparepartScreen.dart';

class OrderHandphoneScreen extends StatefulWidget {
  const OrderHandphoneScreen({super.key});

  @override
  State<OrderHandphoneScreen> createState() => _OrderHandphoneScreenState();
}

class _OrderHandphoneScreenState extends State<OrderHandphoneScreen> {
  final TextEditingController _merkController = TextEditingController();
  final TextEditingController _kerusakanController = TextEditingController();
  List<String> _selectedDamages = [];
  SparePart? _selectedSparePart;

  Future<void> _onOrderButtonPressed() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Proceed with order submission logic using user.uid
      } else {
        // Handle the case where the user is not signed in
      }
      final orderData = {
        'merk': _merkController.text,
        'kerusakan': _kerusakanController.text,
        'selectedSparePart':
            _selectedSparePart?.toJson(), // Assuming a toJson method
      };

      // Ensure you have initialized Firebase in your project
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid) // Get the user's UID
          .collection('order_information')
          .add(orderData);

      // Handle successful submission (e.g., show a success message)
    } catch (error) {
      // Handle errors gracefully (e.g., display an error message)
      print('Error submitting order: $error');
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
    );
  }

  final List<Map<String, dynamic>> _damageTypes = [
    {
      'type': 'cracked_screen',
      'icon': Icons.phone_android,
      'label': 'Layar Pecah',
      'color': Colors.grey.withOpacity(0.4)
    },
    {
      'type': 'water_damage',
      'icon': Icons.water_damage,
      'label': 'Terkena Air',
      'color': Colors.blue.withOpacity(0.4)
    },
    {
      'type': 'total_malfunction',
      'icon': Icons.phonelink_erase,
      'label': 'Mati Total',
      'color': Colors.black.withOpacity(0.4)
    },
    {
      'type': 'battery_issues',
      'icon': Icons.battery_alert,
      'label': 'Masalah Baterai',
      'color': Colors.yellow.withOpacity(0.4)
    },
    {
      'type': 'sound_issues',
      'icon': Icons.volume_up,
      'label': 'Masalah Suara',
      'color': Colors.green.withOpacity(0.4)
    },
    // Add more damage types as needed
  ];

  void _updateDamageDetails() {
    _kerusakanController.text = _selectedDamages
        .map((type) => _damageTypes
            .firstWhere((element) => element['type'] == type)['label'])
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Handphone'),
      ),
      body: _detailKerusakan(),
    );
  }

  Padding _detailKerusakan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jenis Kerusakan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              itemCount: _damageTypes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                mainAxisSpacing: 10, // Spacing between rows
                crossAxisSpacing: 10, // Spacing between columns
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> damageType = _damageTypes[index];
                bool isSelected = _selectedDamages.contains(damageType['type']);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedDamages.remove(damageType['type']);
                      } else {
                        _selectedDamages.add(damageType['type']);
                      }
                      _updateDamageDetails();
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? damageType['color'].withOpacity(1.0)
                              : damageType['color'],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          damageType['icon'],
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        damageType['label'],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            TextField(
              controller: _merkController,
              decoration: InputDecoration(
                  labelText: 'Merk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kerusakanController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Detail Kerusakan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final selectedSparePart = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SparePartsScreen()),
                );
                // Use selectedSparePart to update the state
                if (selectedSparePart != null) {
                  // Update your state with the selected spare part
                  setState(() {
                    _selectedSparePart = selectedSparePart as SparePart;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text("Select Spare Part"),
              ),
            ),
            const SizedBox(height: 16),
            _selectedSparePart == null
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Part: ${_selectedSparePart!.name}, \$${_selectedSparePart!.price}",
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedSparePart = null; // Clear the selection
                          });
                        },
                        child: const Text('Clear Selection'),
                      ),
                    ],
                  ),
            // ... rest of your widgets ...
            ElevatedButton(
              onPressed: _onOrderButtonPressed,
              child: const Text('Submit Order'),
            )
          ],
        ),
      ),
    );
  }
}
