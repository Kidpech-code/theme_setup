import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String id;
  const ProductScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $id'),
        automaticallyImplyLeading:
            true, // ensures back button is shown if possible
      ),
      body: Center(child: Text('Product details for ID: $id')),
    );
  }
}
