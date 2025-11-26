import 'package:flutter/material.dart';
import '../../core/route/zakaria_route_manager.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(10, (index) => 'منتج ${index + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المنتجات'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            onTap: () {
              // تمرير معرف المنتج كمعامل في المسار
              ZakariaRouteManager().push(
                '/product/${index + 1}',
                arguments: {
                  'productName': products[index],
                  'price': (index + 1) * 10,
                },
              );
            },
          );
        },
      ),
    );
  }
}