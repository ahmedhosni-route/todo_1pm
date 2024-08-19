import 'package:flutter/material.dart';
import 'package:todo_1pm/core/service/firebase_functions.dart';

class AuthProvider extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecure = true;

  changeSecure(){
    isSecure = !isSecure;
    notifyListeners();
  }

  void createAccount(){
    FirebaseFunctions.createAccount(emailController.text, passwordController.text);
  }  void login(){
    FirebaseFunctions.loginAccount(emailController.text, passwordController.text);
  }
}