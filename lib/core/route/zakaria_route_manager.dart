import 'package:flutter/material.dart';
import 'package:zakaria_route_manager/features/auth/login_screen.dart';
import 'package:zakaria_route_manager/features/auth/register_screen.dart';
import 'package:zakaria_route_manager/features/product/product_details_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/product/product_list_screen.dart';
import 'route_names.dart';

class ZakariaRouteManager {
  static final ZakariaRouteManager _instance = ZakariaRouteManager._internal();
  factory ZakariaRouteManager() => _instance;
  ZakariaRouteManager._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // الحصول على context
  BuildContext? get context => navigatorKey.currentContext;

  // التنقل إلى شاشة جديدة
  Future<T?> push<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  // التنقل مع استبدال الشاشة الحالية
  Future<Future> pushReplacement<T>(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  // التنقل وإزالة كل الشاشات السابقة
  Future<T?> pushAndRemoveUntil<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // التنقل مع إزالة شاشات معينة
  Future<T?> pushAndRemoveUntilRoute<T>(
    String routeName, {
    Object? arguments,
    required String untilRoute,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      ModalRoute.withName(untilRoute),
      arguments: arguments,
    );
  }

  // العودة للشاشة السابقة
  void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  // العودة لشاشة محددة
  void popUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  // استبدال الشاشة الحالية بشاشة جديدة مع إمكانية الرجوع للشاشة السابقة
  Future<T?> pushReplacementWithAnimation<T>(
    String routeName, {
    Object? arguments,
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getPage(routeName, arguments),
        transitionsBuilder: transitionBuilder ??
            (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
      ),
    );
  }

  // التنقل مع انتقال مخصص
  Future<T?> pushWithCustomTransition<T>(
    String routeName, {
    Object? arguments,
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    return navigatorKey.currentState!.push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getPage(routeName, arguments),
        transitionsBuilder: transitionBuilder ??
            (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
      ),
    );
  }

  // الحصول على Widget المناسب بناءً على اسم المسار
  Widget _getPage(String routeName, Object? arguments) {
    final routes = _getRoutes();
    final routeBuilder = routes[routeName];
    
    if (routeBuilder != null) {
      return routeBuilder(arguments);
    } else {
      // معالجة المسارات الديناميكية
      if (routeName.startsWith('/product/')) {
        final id = routeName.split('/').last;
        return routes[RouteNames.productDetails]!(id);
      }
      
      throw Exception('Route $routeName not found');
    }
  }

  // تعريف جميع المسارات
  Map<String, Widget Function(Object?)> _getRoutes() {
    return {
      RouteNames.home: (_) => const HomeScreen(),
      RouteNames.profile: (args) => ProfileScreen(userData: args is Map<String, dynamic> ? args : null),
      RouteNames.settings: (_) => const SettingsScreen(),
      RouteNames.productList: (_) => const ProductListScreen(),
      RouteNames.productDetails: (args) => ProductDetailsScreen(productId: args),
      RouteNames.login: (_) => const LoginScreen(),
      RouteNames.register: (_) => const RegisterScreen(),
    };
  }

  // توليد Route من RouteSettings
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routes = _getRoutes();
    final routeBuilder = routes[settings.name];

    if (routeBuilder != null) {
      return MaterialPageRoute(
        builder: (context) => routeBuilder(settings.arguments),
        settings: settings,
      );
    }

    // معالجة المسارات الديناميكية
    if (settings.name!.startsWith('/product/')) {
      final id = settings.name!.split('/').last;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: id),
        settings: settings,
      );
    }

    return null;
  }

  // التحقق مما إذا كان يمكن العودة
  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  // إغلاق جميع ال dialogs المفتوحة
  void popDialogs() {
    navigatorKey.currentState!.popUntil((route) => route is PageRoute);
  }
}