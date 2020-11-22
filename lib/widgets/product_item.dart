import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(
      {@required this.id, @required this.title, @required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
            color: Theme.of(context).accentColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black87,
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
