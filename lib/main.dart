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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Light theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Consistent app bar color
          elevation: 0, // Flat app bar for a modern look
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), // Updated from headline1
          bodyLarge: TextStyle(fontSize: 16.0), // Updated from bodyText1
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
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: AuthService().isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasError) {
            // Display an error screen if there's an issue
            return const Center(child: Text('Error occurred, please restart the app.'));
          } else if (snapshot.data == true) {
            return const OnboardingScreen(); // First-time user
          } else {
            return FutureBuilder<bool>(
              future: AuthService().isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else if (snapshot.hasError) {
                  // Handle error case here too
                  return const Center(child: Text('Error occurred, please restart the app.'));
                } else if (snapshot.data == true) {
                  return const HomeScreen(); // User logged in
                } else {
                  return const LoginScreen(); // User not logged in
                }
              },
            );
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
      // Adding smooth transitions between pages
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
                builder: (context) => const LoginScreen(),
                settings: settings,
                fullscreenDialog: true);
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
                settings: settings,
                fullscreenDialog: true);
          case '/home':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          default:
            return null;
        }
      },
    );
  }
}
