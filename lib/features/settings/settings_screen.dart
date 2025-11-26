import 'package:flutter/material.dart';
import '../../core/route/zakaria_route_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('الإشعارات'),
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            title: const Text('الخصوصية'),
            onTap: () {
              // يمكن إضافة شاشة الخصوصية هنا
            },
          ),
          ListTile(
            title: const Text('حول التطبيق'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('حول التطبيق'),
                  content: const Text('Zakaria Route Manager v1.0.0'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ZakariaRouteManager().pop();
                      },
                      child: const Text('موافق'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}