import 'package:flutter/material.dart';
import 'core/route/zakaria_route_manager.dart';
import 'core/route/route_names.dart';
import 'features/home/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/product/product_list_screen.dart';
import 'features/product/product_details_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';

class MyApp extends StatelessWidget {
  final ZakariaRouteManager routeManager = ZakariaRouteManager();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zakaria Route Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      navigatorKey: routeManager.navigatorKey,
      initialRoute: RouteNames.home,
      onGenerateRoute: routeManager.generateRoute,
      routes: {
        RouteNames.home: (context) => const HomeScreen(),
        RouteNames.profile: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return ProfileScreen(userData: args);
        },
        RouteNames.settings: (context) => const SettingsScreen(),
        RouteNames.productList: (context) => const ProductListScreen(),
        RouteNames.productDetails: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return ProductDetailsScreen(productId: args);
        },
        RouteNames.login: (context) => const LoginScreen(),
        RouteNames.register: (context) => const RegisterScreen(),
      },
    );
  }
}