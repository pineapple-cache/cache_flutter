import 'dart:async';

import 'package:cache_flutter/screens/home/home_screen.dart';
import 'package:get/get.dart';

class SplashService {
  void isLogin() {
    Timer(const Duration(seconds: 2), () => Get.offAll(const HomeScreen()));
  }
}