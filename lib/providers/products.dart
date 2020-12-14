import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> allItems = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products({this.authToken, this.userId, this.allItems});

  List<Product> get items {
    return [...allItems];
  }

  List<Product> get showFavoriteProducts {
    return allItems.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return allItems.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url =
        'https://shop-app-backend-8acaf.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final List<Product> loadedProducts = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      url =
          'https://shop-app-backend-8acaf.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach(
        (productId, productData) {
          loadedProducts.add(
            Product(
              id: productId,
              title: productData['title'],
              price: productData['price'],
              description: productData['description'],
              imageUrl: productData['imageUrl'],
              isFavorite: favoriteData == null
                  ? false
                  : favoriteData[productId] ?? false,
            ),
          );
        },
      );
      allItems = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-app-backend-8acaf.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          },
        ),
      );

      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      allItems.add(newProduct);

      final responseData = json.decode(response.body);

      if (responseData['error'] == 'Permission denied') {
        throw HttpException(message: responseData['error']);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

//   void updateProduct(String id, Product newProduct) {
//     final productIndex = _items.indexWhere((product) => product.id == id);
//     if (productIndex >= 0) {
//       _items[productIndex] = newProduct;
//       notifyListeners();
//     } else {
//       print('...');
//     }
//   }
//
//   void deleteProduct(String id) {
//     _items.removeWhere((product) => product.id == id);
//     notifyListeners();
//   }
// }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = allItems.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final url =
          'https://shop-app-backend-8acaf.firebaseio.com/products/$id.json?auth=$authToken';

      await http.patch(
        url,
        body: json.encode(
          ({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }),
        ),
      );

      allItems[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-app-backend-8acaf.firebaseio.com/products/$id.json?auth=$authToken';
    try {
      final response = await http.delete(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        allItems.removeWhere((product) => product.id == id);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
