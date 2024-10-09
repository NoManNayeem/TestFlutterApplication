import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Fuel Delivery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications page
            },
          ),
        ],
        backgroundColor: Colors.blueGrey, // Modern color scheme
        elevation: 10,
      ),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Fuel Delivery',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', context, () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.history, 'Order History', context, () {
            // Navigate to order history
          }),
          _buildDrawerItem(Icons.payment, 'Payment Methods', context, () {
            // Navigate to payment methods
          }),
          _buildDrawerItem(Icons.settings, 'Settings', context, () {
            // Navigate to settings
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: onTap,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Quick Actions:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          _buildQuickActions(),
          const SizedBox(height: 20),
          const Text(
            'Promotions for You:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          _buildPromotions(),
          const SizedBox(height: 20),
          const Text(
            'Recommended Stations:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          _buildStationRecommendations(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return SizedBox(
      height: 120, // Fixed height for horizontal scroll
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          ActionCard(
            icon: Icons.local_gas_station,
            title: 'Order Fuel',
            description: 'Order fuel for delivery',
          ),
          SizedBox(width: 10),
          ActionCard(
            icon: Icons.history,
            title: 'Order History',
            description: 'View your orders',
          ),
          SizedBox(width: 10),
          ActionCard(
            icon: Icons.payment,
            title: 'Payment Methods',
            description: 'Manage your payments',
          ),
        ],
      ),
    );
  }

  Widget _buildPromotions() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blueAccent.withOpacity(0.2), // Placeholder for image
              child: const Icon(Icons.local_offer, size: 50, color: Colors.blueAccent),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                '50% off on your first fuel delivery! Use code FIRST50 at checkout.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationRecommendations() {
    return ListView.builder(
      itemCount: 5, // Dummy data count
      shrinkWrap: true, // Required when inside a SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: Colors.blueGrey),
            title: Text('Fuel Station #${index + 1}'),
            subtitle: Text('2.5 miles away'),
            trailing: IconButton(
              icon: const Icon(Icons.navigation, color: Colors.blueAccent),
              onPressed: () {
                // Handle navigation to the station
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle navigation based on tapped index
      },
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ActionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.blueGrey),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
