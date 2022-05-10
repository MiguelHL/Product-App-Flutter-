import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey = GlobalKey<FormState>(); 
  
  String email = '';
  String password = '';
  bool _isloading = false;

  bool get isLoading => _isloading;
  
  set isLoading(bool value){
    _isloading=value;
    notifyListeners();
  }

  bool isValidForm(){

    //print('${email}');
    //print(formkey.currentState?.validate());

    return formkey.currentState?.validate() ?? false;
  }

}