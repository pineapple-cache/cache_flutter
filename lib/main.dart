import 'dart:io';

import 'package:cache_flutter/screens/home/home_screen.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_detail_info.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_info.dart';
import 'package:cache_flutter/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await dotenv.load(fileName: ".env"); 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
