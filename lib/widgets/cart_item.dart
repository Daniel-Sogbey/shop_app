import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  CartItem({this.id, this.productId, this.price, this.title, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (_, cart, child) {
        return Dismissible(
          key: ValueKey(id),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cart.removeItem(productId);
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FittedBox(
                      child: Text('\$$price'),
                    ),
                  ),
                ),
                title: Text(title),
                subtitle: Text('Total: \$${(quantity * price)}'),
                trailing: Text('$quantity x'),
              ),
            ),
          ),
        );
      },
    );
  }
}
