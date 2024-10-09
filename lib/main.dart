import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XPress Fuel',
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      home: _buildInitialScreen(), // Dynamically build initial screen
      routes: _buildRoutes(), // Define static routes
      onGenerateRoute: _buildPageTransitions, // Custom page transitions
    );
  }

  // Build app theme with enhanced typography and design
  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0, // Flat app bar for a modern look
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), // Use modern typography
        bodyLarge: TextStyle(fontSize: 16.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Determine initial screen based on first launch and login status
  Widget _buildInitialScreen() {
    return FutureBuilder<bool>(
      future: AuthService().isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred, please restart the app.'));
        } else if (snapshot.data == true) {
          return const OnboardingScreen(); // First-time user
        } else {
          return _buildLoggedInChecker(); // Check login status
        }
      },
    );
  }

  // Check if user is logged in and decide the next screen
  Widget _buildLoggedInChecker() {
    return FutureBuilder<bool>(
      future: AuthService().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred, please restart the app.'));
        } else if (snapshot.data == true) {
          return const HomeScreen(); // User is logged in
        } else {
          return const LoginScreen(); // User is not logged in
        }
      },
    );
  }

  // Define static routes for common navigation
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/home': (context) => const HomeScreen(),
    };
  }

  // Build custom page transitions for a smooth user experience
  Route<dynamic>? _buildPageTransitions(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case '/register':
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case '/home':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      default:
        return null;
    }
  }
}
