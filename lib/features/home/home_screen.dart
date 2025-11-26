import 'package:flutter/material.dart';
import '../../core/route/zakaria_route_manager.dart';
import '../../core/route/route_names.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                ZakariaRouteManager().push(
                  RouteNames.profile,
                  arguments: {
                    'name': 'زكريا',
                    'email': 'zakaria@example.com',
                    'age': 25,
                  },
                );
              },
              child: const Text('الملف الشخصي (تمرير بيانات)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ZakariaRouteManager().pushReplacement(RouteNames.settings);
              },
              child: const Text('الإعدادات (استبدال)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ZakariaRouteManager().push(RouteNames.productList);
              },
              child: const Text('قائمة المنتجات'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ZakariaRouteManager().pushWithCustomTransition(
                  RouteNames.login,
                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                );
              },
              child: const Text('تسجيل الدخول (انتقال مخصص)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ZakariaRouteManager().pushAndRemoveUntil(RouteNames.home);
              },
              child: const Text('إعادة التعيين وإزالة الكل'),
            ),
          ],
        ),
      ),
    );
  }
}