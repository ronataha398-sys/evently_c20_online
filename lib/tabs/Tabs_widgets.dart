import 'package:evently/app_contantes/app_catagory.dart';
import 'package:flutter/material.dart';

class TabsWidgets extends StatelessWidget {
  bool isSelected;
  AppCatagory catagory;

   TabsWidgets({required this.catagory,required this.isSelected});

  @override
  Widget build(BuildContext context) {

    var theme=Theme.of(context);
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
        decoration: BoxDecoration(
            color:isSelected? theme.primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(catagory.iconData),
            SizedBox(width: 8,),
            Text(catagory.name
            ),
          ],
        ),
      ),

    );

  }
}
