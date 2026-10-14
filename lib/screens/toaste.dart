import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toaste {
 static void show({required String title,required BuildContext context,ToastType type= ToastType.success})
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:type.color,
      elevation: 0,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

        ),
    content: Text(title),

    ),);
  }
}
enum ToastType{
  error(color: Colors.red),
  success(color: Colors.green);
  final Color color ;
  const ToastType({required this.color});
}