import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier{

  final String _baseUrl='flutter-varios-1b386-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

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

  Future saveOrCreateProduct (Product product) async{
    isSaving=true;
    notifyListeners();

    if(product.id == null){
      
      await createProduct(product);

    }else{
      
      final String idProduct=await updateProduct(product);
      for (var element in products) {
        if(element.id == idProduct){
          element.name=product.name;
          element.price= product.price;
          element.available = product.available;
        }
      }   

    }


    isSaving=false;
    notifyListeners();
  }

  Future<String> updateProduct (Product product) async{
    
    final url = Uri.https(_baseUrl,'Products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());
    final decodeData = response.body;
    print(decodeData);

    return product.id.toString();

  }

    Future<String> createProduct (Product product) async{
    
    final url = Uri.https(_baseUrl,'Products.json');
    final response = await http.post(url, body: product.toJson());
    final decodeData = json.decode(response.body);
    product.id = decodeData['name'];
    products.add(product);
    //print(decodeData);
    //products.add(product);
    return product.id!;

  }

  void updateSelectedProductImage(String path){

    selectedProduct.picture=path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();


  }

}