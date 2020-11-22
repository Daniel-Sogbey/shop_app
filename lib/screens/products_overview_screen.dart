import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: GridView.builder(
        gridDelegate: null,
        itemBuilder: null,
      ),
    );
  }
}
