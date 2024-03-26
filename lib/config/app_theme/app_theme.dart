import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

class AppTheme{

  static ThemeData appThemeData = ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.yellowColor,
        unselectedItemColor: AppColors.lightGreyColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ));
}