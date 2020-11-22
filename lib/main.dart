import 'package:flutter/material.dart';

import './screens/products_overview_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsOverviewScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
