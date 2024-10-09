import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../services/auth_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for the spinner
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // The spinner will repeat indefinitely
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Simulating a check from a service (use AuthService or local storage for actual implementation)
    bool isFirstLaunch = await AuthService().isFirstLaunch();
    bool isLoggedIn = await AuthService().isLoggedIn();

    // Navigate based on user status
    if (isFirstLaunch) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated Spinner using Icon and RotationTransition
            AnimatedBuilder(
              animation: _animationController,
              child: const Icon(
                Icons.local_gas_station, // Use any icon you prefer
                size: 80.0,
                color: Colors.blue, // Customize color as needed
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * 3.141592653589793238,
                  child: child,
                );
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Loading...',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
