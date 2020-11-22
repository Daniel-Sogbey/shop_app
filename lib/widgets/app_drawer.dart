import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget _buildOrderNavigationLinks(
    BuildContext context,
    IconData iconType,
    String titleText,
    Function routeToGo,
  ) {
    return ListTile(
      leading: Icon(
        iconType,
      ),
      title: Text(titleText),
      onTap: routeToGo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Your Orders Friend'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            _buildOrderNavigationLinks(
              context,
              Icons.shop,
              'Shop',
              () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            _buildOrderNavigationLinks(
              context,
              Icons.payment,
              'Orders',
              () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
