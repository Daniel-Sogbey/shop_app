import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (ctx, index) => Column(
            children: [
              UserProductItem(
                title: productsData.items[index].title,
                imageUrl: productsData.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
