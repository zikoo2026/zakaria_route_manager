import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final dynamic productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المنتج $productId'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تفاصيل المنتج $productId',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            if (productId is Map) ...[
              Text('اسم المنتج: ${productId['productName']}'),
              Text('السعر: \$${productId['price']}'),
            ],
          ],
        ),
      ),
    );
  }
}