import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

 GlobalKey<FormState> formkey = GlobalKey<FormState>();
 Product product;

 ProductFormProvider(this.product);

 bool isValidForm(){

   // ignore: avoid_print
   print(product.name);
   // ignore: avoid_print
   print(product.price);
   // ignore: avoid_print
   print(product.available);

   return formkey.currentState?.validate()?? false;
   
 }

 updateAvailability (bool value){
   //print(value);
   product.available = value;
   notifyListeners();
 }


}