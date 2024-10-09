import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),
      body: _buildPaymentMethodsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to add a new payment method
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        _buildPaymentCard(
          'Visa **** 1234',
          'Expires 12/25',
          Icons.credit_card,
          Colors.blue,
        ),
        _buildPaymentCard(
          'MasterCard **** 5678',
          'Expires 11/24',
          Icons.credit_card,
          Colors.orange,
        ),
        _buildPaymentCard(
          'PayPal',
          'user@example.com',
          Icons.account_balance_wallet,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildPaymentCard(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Logic to delete the payment method
          },
        ),
      ),
    );
  }
}
