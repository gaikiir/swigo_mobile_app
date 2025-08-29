import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'DARK_THEME';
  
  bool _isDarkTheme = false;
  bool _isSystemDark = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadTheme();
    _detectSystemTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkTheme = prefs.getBool(_themeKey) ?? false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }

  void _detectSystemTheme() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isSystemDark = brightness == Brightness.dark;
  }

  Future<void> setDarkTheme(bool value) async {
    if (_isDarkTheme == value) return;
    
    _isDarkTheme = value;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, value);
      
      // Update system UI overlay style
      _updateSystemUIOverlay();
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  void _updateSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarBrightness: _isDarkTheme ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: _isDarkTheme ? const Color(0xFF1E1E1E) : Colors.white,
        systemNavigationBarIconBrightness: _isDarkTheme ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
