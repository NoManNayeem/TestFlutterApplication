import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/payment_methods_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState(); // Make the state class public
}

class BottomNavBarState extends State<BottomNavBar> { // Remove the underscore to make the state class public
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const OrderHistoryScreen(),
    const PaymentMethodsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // Example of handling a button press
                print('Floating Action Button Pressed!');
              },
              child: const Icon(Icons.local_gas_station),
              backgroundColor: Colors.deepPurple,
              elevation: 5,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
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
      ),
    );
  }
}
