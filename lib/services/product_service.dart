import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier{

  final String _baseUrl='flutter-varios-1b386-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;

  ProductService(){
    loadProducts();
  }

  Future loadProducts()async{

    isLoading=true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'Products.json');
    final response = await http.get(url);
    final Map<String,dynamic> productsMap= json.decode(response.body);
    
    productsMap.forEach((key,value){
      final Product tempProduct = Product.fromMap(value);
      tempProduct.id=key;
      products.add(tempProduct);

    });
    isLoading=false;
    notifyListeners();
    //print(products[0].name);

  }
}