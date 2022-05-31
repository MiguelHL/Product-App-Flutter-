import 'package:flutter/material.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:products_app/services/product_service.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
  
  final productService = Provider.of<ProductService>(context);
  final listProducts = productService.products;

  if(productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title:const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (BuildContext context, int index)=>  GestureDetector(
          onTap: (){
            productService.selectedProduct = productService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: listProducts[index],),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}