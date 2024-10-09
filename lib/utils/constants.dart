import 'package:flutter/material.dart';

// App Theme Colors
class AppColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.orange;
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.black54;
  static const Color buttonText = Colors.white;
}

// Text Styles
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    color: AppColors.buttonText,
  );
}

// App Theme Data
ThemeData appThemeData() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.buttonText,
      ),
      elevation: 4,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.heading, // Replaced headline6 with titleLarge
      bodyMedium: AppTextStyles.body,    // Correct TextTheme usage for body text
      labelLarge: AppTextStyles.button,  // Using labelLarge for buttons
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary, // Corrected name for button background color
        textStyle: AppTextStyles.button,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    dividerColor: AppColors.textSecondary.withOpacity(0.5),
  );
}

// Other Constants
const String appName = 'XPress Fuel';
const Duration splashScreenDuration = Duration(seconds: 2);
