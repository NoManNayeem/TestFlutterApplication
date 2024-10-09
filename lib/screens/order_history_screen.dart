import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: _buildOrderHistoryList(),
    );
  }

  Widget _buildOrderHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5, // Placeholder for 5 orders
      itemBuilder: (BuildContext context, int index) {
        return _buildOrderCard(context, index);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Icon(
                  Icons.local_gas_station,
                  color: Colors.blue,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'Order #${index + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Delivered',
                  style: TextStyle(
                    color: Colors.greenAccent.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Fuel delivered to your location',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.date_range, size: 20, color: Colors.blueAccent),
                SizedBox(width: 5),
                Text('12 March 2024'),
                SizedBox(width: 20),
                Icon(Icons.attach_money, size: 20, color: Colors.blueAccent),
                SizedBox(width: 5),
                Text('\$50.00'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _navigateToOrderDetails(context, index + 1);
                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToOrderDetails(BuildContext context, int orderId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => OrderDetailsScreen(orderId: orderId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide transition from the right
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderId Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fuel Delivered',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text('Date: 12 March 2024'),
            const SizedBox(height: 10),
            const Text('Total Amount: \$50.00'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Back to Order History'),
            ),
          ],
        ),
      ),
    );
  }
}
