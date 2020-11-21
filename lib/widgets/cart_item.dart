import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  CartItem({this.id, this.price, this.title, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
