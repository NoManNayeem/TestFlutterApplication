import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/payment_methods_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // Home Screen
    const OrderHistoryScreen(), // Order History Screen
    const PaymentMethodsScreen(), // Payments Screen
    const SettingsScreen(), // Settings Screen
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack( // Keeps the state of each page intact while switching
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: _currentIndex == 0 // Show FAB only on Home screen
            ? FloatingActionButton(
                onPressed: () {
                  // Add your action here (e.g., starting a new fuel order)
                },
                child: const Icon(Icons.local_gas_station),
                backgroundColor: Colors.deepPurple,
              )
            : null, // Hide FAB on other screens
      ),
    );
  }
}
