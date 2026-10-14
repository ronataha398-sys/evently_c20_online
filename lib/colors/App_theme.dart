import 'package:evently/colors/AppColor.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.lightPrimaryColor,
    dividerColor: AppColors.lightDividerColor,
    primaryColorLight: AppColors.lightPrimaryColor,

    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimaryColor,
      outline: Color(0XFFF0F0F0),
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: AppColors.lightPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xff686868),
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xffF0F0F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xffF0F0F0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xffF0F0F0),
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff002D8F),
      ),
    ),

    textTheme: TextTheme(
      //welcome
        headlineSmall: TextStyle(
            color:Color(0xff686868),
            fontWeight: FontWeight.w400,
            fontSize: 14
        ) ,
      //john
      displaySmall:TextStyle(
          color:Color(0xff1C1C1C),
          fontWeight: FontWeight.w500,
          fontSize: 20
      ) ,
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightGrayColor,
      ),
      titleLarge: TextStyle(
        color: AppColors.lightPrimaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.lightPrimaryColor,
      ),
      labelLarge: TextStyle(
        color: AppColors.lightPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    primaryColor: AppColors.darkPrimaryColor,
    dividerColor: AppColors.darkDividerColor,
    primaryColorDark: AppColors.darkPrimaryColor,

    cardColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: AppColors.darkPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xffD6D6D6),
      ),
      fillColor: Color(0xff001440),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xff002D8F),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xff002D8F),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Color(0xff002D8F),
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff002D8F),
      ),
    ),

    textTheme: TextTheme(
      //welcome
      bodyMedium: TextStyle(
          color:Color(0xffD6D6D6),
          fontWeight: FontWeight.w400,
          fontSize: 14
      ) ,
      //john
      displaySmall:TextStyle(
        color:Color(0xffFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: 20
      ) ,
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrayColor,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkPrimaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.darkPrimaryColor,
      ),
      labelLarge: TextStyle(
        color: AppColors.darkPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 14
    )),
    
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      outline: Color(0xff002D8F),
    ),
  );
}