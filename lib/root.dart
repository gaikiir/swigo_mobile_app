import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:swigo_app/screens/cart.dart';
import 'package:swigo_app/screens/category_display.dart';
import 'package:swigo_app/screens/home.dart';
import 'package:swigo_app/screens/inner_screen/products.dart';
import 'package:swigo_app/screens/profile.dart';

class RootScreen extends StatefulWidget {
  /// Define route for the page
  static const String routeName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  /// List of screens/pages for the bottom navigation
  late final List<Widget> _screens;

  /// Track the currently selected index
  int _currentIndex = 0;

  /// Page controller for navigation
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      CategoryScreen(),
      Products(),
      CartScreen(),
      ProfileScreen(),
    ];
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // IMPORTANT: Dispose the controller to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    // Only update if the index has changed
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onDestinationSelected: _onDestinationSelected,
        destinations: _navBarItems,
        // Optional: Add these for better UX
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}

/// Define navbar items with better organization
const List<NavigationDestination> _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home_rounded),
    label: 'Home',
    tooltip: 'Home Screen',
  ),

  NavigationDestination(
    icon: Icon(IconlyLight.category),
    selectedIcon: Icon(IconlyLight.ticketStar),
    label: 'Category',
    tooltip: 'Category',
  ),
  NavigationDestination(
    icon: Icon(Icons.shopping_bag_outlined),
    selectedIcon: Icon(Icons.shopping_bag_outlined),
    label: 'Products',
    tooltip: 'products',

  ),

  NavigationDestination(
    icon: Icon(Icons.shopping_cart),
    selectedIcon: Icon(Icons.shopping_cart),
    label: 'Cart',
    tooltip: 'cart',
  ),


  NavigationDestination(
    icon: Icon(Icons.person_outline),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Profile',
    tooltip: 'User Profile',
  ),
];
