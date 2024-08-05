import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splashService.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService splashScreen = SplashService();

   @override
  void initState() {
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2E2E2E),
      body: Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('cache',
            style: GoogleFonts.pacifico(fontSize: 55, color: const Color(0xffA772FD)),
            ),
            const SizedBox(height: 20),
            Text('세상의 모든 음식을 만나다',
            style: GoogleFonts.pacifico(fontSize: 15, color: const Color(0xff9A74AC)),
            )
          ],
        ),
      ),
    )
    );
  }
}