import 'package:flutter/material.dart';
import 'package:swigo_app/consts/app_colors.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarkMode,
    required BuildContext context,
  }) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDarkMode
          ? AppColors.darkTheme
          : AppColors.lightColor,
      cardColor: isDarkMode
          ? const Color.fromARGB(255, 51, 51, 51)
          : AppColors.lightCard,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,

      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white38 : Colors.black87,
        ),
        backgroundColor: isDarkMode
            ? AppColors.darkTheme
            : AppColors.lightColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white38 : Colors.black87,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: isDarkMode ? Colors.white12 : Colors.black87,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
