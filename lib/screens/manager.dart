import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class Manager extends ChangeNotifier{
  bool isLoading=false;
  late User user;

  Future<void>createAccount({
    required String email,
    required String password,
    required String name,
  required BuildContext context})
  async{
    isLoading=true;
    notifyListeners();
    try{
      user= (await Auth.createAccount(
          email:email,
          password: password,
          name: name
      ))!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome $name"),
backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));

    } isLoading=false;
    notifyListeners();

  } Future<void>LoginAccount({
    required String email,
    required String password,
    required BuildContext context})
  async{
    isLoading=true;
    notifyListeners();
    try{
      user= (await Auth.LoginAccount(
          email:email,
          password: password,
      ))!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));

    } isLoading=false;
    notifyListeners();

  }

