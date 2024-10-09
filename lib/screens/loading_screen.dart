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

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Simulating a check from a service (use AuthService or local storage for actual implementation)
    bool isFirstLaunch = await AuthService().isFirstLaunch();
    bool isLoggedIn = await AuthService().isLoggedIn();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
