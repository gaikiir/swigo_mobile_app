import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swigo_app/consts/theme_data.dart';
import 'package:swigo_app/firebase_options.dart';
import 'package:swigo_app/provider/product_manager_provider.dart';
import 'package:swigo_app/provider/theme_provider.dart';
import 'package:swigo_app/root.dart';
import 'package:swigo_app/screens/admin/admin_dashboard.dart';
import 'package:swigo_app/screens/auth/login_screen.dart';
import 'package:swigo_app/screens/auth/register.dart';
import 'package:swigo_app/screens/cart.dart';
import 'package:swigo_app/screens/category_display.dart';
import 'package:swigo_app/screens/home.dart';
import 'package:swigo_app/screens/inner_screen/product_details.dart';
import 'package:swigo_app/screens/inner_screen/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Swigo App',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(isDarkMode: false, context: context),
            darkTheme: Styles.themeData(isDarkMode: true, context: context),
            themeMode: themeProvider.isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? LoginScreen.routeName
                : RootScreen.routeName,
            routes: {
              Products.routeName: (context) => const Products(),
              RootScreen.routeName: (context) => const RootScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              RegisterScreen.routeName: (context) => const RegisterScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              AdminDashboard.routeName: (context) => const AdminDashboard(),
              CategoryScreen.routeName: (context) => const CategoryScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailsScreen.routeName) {
                return MaterialPageRoute(
                  builder: (context) => const ProductDetailsScreen(),
                  settings: settings,
                );
              }
              return null;
            },

          );
        },
      ),
    );
  }
}
