import 'package:flutter/material.dart';
import '../Widget/payment_option_tile.dart'; // Ensure this path is correct

class PaymentMethodScreen extends StatelessWidget {
  void _showSnackBar(BuildContext context, String paymentMethod) {
    final snackBar = SnackBar(
      content: Text('Payment Success with $paymentMethod'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method'),
      ),
      body: ListView(
        children: <Widget>[
          PaymentOptionTile(
            title: 'Debit/Credit Card',
            icon: Icons.credit_card,
            onTap: () => _showSnackBar(context, 'Debit/Credit Card'),
          ),
          PaymentOptionTile(
            title: 'BCA',
            icon: Icons.account_balance,
            onTap: () => _showSnackBar(context, 'BCA'),
          ),
          PaymentOptionTile(
            title: 'Mandiri',
            icon: Icons.account_balance,
            onTap: () => _showSnackBar(context, 'Mandiri'),
          ),
          // ... Add more payment options in a similar manner
        ],
      ),
    );
  }
}
