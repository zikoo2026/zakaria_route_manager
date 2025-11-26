import 'package:flutter/material.dart';
import '../../core/route/zakaria_route_manager.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfileScreen({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // إرجاع بيانات للشاشة السابقة
            ZakariaRouteManager().pop({'message': 'تم تحديث الملف الشخصي'});
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userData != null) ...[
              Text('الاسم: ${userData!['name']}'),
              Text('البريد الإلكتروني: ${userData!['email']}'),
              Text('العمر: ${userData!['age']}'),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // العودة للشاشة الرئيسية مباشرة
                ZakariaRouteManager().popUntil('/');
              },
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}