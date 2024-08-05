import 'package:cache_flutter/providers/getTimeofDay.dart';
import 'package:cache_flutter/screens/ask_food_info/view/ask_food_view.dart';
import 'package:cache_flutter/screens/ask_food_info_AI/view/ask_food_info_AI.dart';
import 'package:cache_flutter/screens/ask_food_info_AI/view/ask_food_info_AI.dart';
import 'package:cache_flutter/screens/recommend/recommend_Indicator.dart';
import 'package:cache_flutter/screens/select_food_type/view/select_food_type_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

// This file requires refactoring (Repeat Grammar Cleanup)
// 이 파일은 리팩토링이 필요한 파일입니다(반복 코드 구조 정리)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _homeScreenDrawer(),
      backgroundColor: const Color(0xff2e2e2e),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const MenuBar(),
              const SizedBox(height: 20),
              _WelcomeText(),
              const SizedBox(height: 20),
              _today_Food_Banner(),
              const SizedBox(height: 20),
              _Recommend_Button_Area(),
              const SizedBox(height: 20),
              FoodList(),
              const SizedBox(height: 20),
              learnFoodInfo(),      
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: 
      Image.asset('assets/images/burgerMenu.png'), 
      ),
      const Spacer()
    ]
  );
  }
}

Widget _WelcomeText() {
  String timeOfDay = getTimeOfDay();
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('안녕하세요\n좋은 $timeOfDay입니다',
      style:  GoogleFonts.roboto(fontSize: 20, fontWeight:FontWeight.bold, color: Colors.white)),
    ],
  );
}

Widget _today_Food_Banner() {
    return Stack(
      children: [
        _today_Food_Slider(),
      Positioned(
        bottom: 20,
        right: 10,
        child: GestureDetector(
          onTap: () {
            print('안녕');
          },
          child: const Text(
            '방금 본 음식 먹으러 가기 →',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ), 
      ],
    );
}

Widget _today_Food_Slider() {
  return CarouselSlider(
   items: [
    ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset('assets/images/food_chicken.jpg',width: ScreenUtil().setWidth(380),fit: BoxFit.fill),
    ),
    ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset('assets/images/food_hambuger.jpg',width: ScreenUtil().setWidth(380),fit: BoxFit.fill),
    ),
    ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset('assets/images/food_pizza.jpg',width: ScreenUtil().setWidth(380),fit: BoxFit.fill),
    ),
    ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset('assets/images/food_steak.jpg',width: ScreenUtil().setWidth(380),fit: BoxFit.fill),
    ),
    ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset('assets/images/food_sushi.jpg',width: ScreenUtil().setWidth(380),fit: BoxFit.fill),
    ),
   ],
   options: CarouselOptions(
    height: ScreenUtil().setHeight(134),
    enlargeCenterPage: true,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 10),
    autoPlayAnimationDuration: Duration(seconds: 5),
    viewportFraction: 1,
));
}

Widget _Recommend_Button_Area() {
  return SizedBox(
  width: double.infinity,
  child: Row(
    children: [
      _OneTouch_Recommend_Button(),
      Spacer(),
      _Detailed_Recommend_Button(),
    ],
  )
  );
}

Widget _OneTouch_Recommend_Button() {
  return InkWell(
    onTap: () {
      Get.to(() => const Recommend_Indicator(),transition: Transition.noTransition);
  },
  child: Container(
    height: ScreenUtil().setHeight(150),
    width: ScreenUtil().setWidth(150),
    // Support auto-layout later
    // 오토레이아웃 따로 지정해주기
    decoration: BoxDecoration(
    color: const Color(0xffA772FD), 
    borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/restaurant.png'),
          const SizedBox(height: 5),
          const Text(
            '원터치 추천받기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )
        ],
      ),
    ),
  )
  );
}

Widget _Detailed_Recommend_Button() {
  return InkWell(
    onTap: () {
      Get.to(() => SelectFoodTypeView());
    },
    child: Container(
    height: ScreenUtil().setHeight(153),
    width: ScreenUtil().setWidth(153),
    // Support auto-layout later
    // 오토레이아웃 따로 지정해주기
    decoration: BoxDecoration(
    color: const Color(0xffA772FD), 
    borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/search.png'),
          const SizedBox(height: 5),
          const Text(
            '정밀 추천받기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )
        ],
      ),
    ),
  )
  );
}

Widget FoodList() {
  return GestureDetector(
   onTap: () {
      Get.to(() => AskFoodView());
    },
    child: Container(
      height: ScreenUtil().setHeight(123),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff414040),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 63,
              height: 63,
              decoration: BoxDecoration(
                color: const Color(0xffA772FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/menu_book.png'),
                ],
              ),
            ),
            const Text('음식 리스트 보기',
            style: TextStyle(
              color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 13)),
            Image.asset('assets/images/arrow.png',width: 20,height: 20),
          ],
        ),
      ),
    ),
  );
}

Widget learnFoodInfo() {
  return GestureDetector(
    onTap: () {
      null;
    },
    child: Container(
      height: ScreenUtil().setHeight(123),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff414040),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 63,
              height: 63,
              decoration: BoxDecoration(
                color: const Color(0xffA772FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/receipt.png'),
              ],
            ),
            ),
            const Text('음식 정보 알아보기',
            style: TextStyle(
              color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 13)),
            Image.asset('assets/images/arrow.png',width: 20,height: 20),
          ],
        ),
      ),
    ),
  );
}

Widget _homeScreenDrawer() {
  return Drawer(
        backgroundColor: const Color(0xff2e2e2e),
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget> [
            const UserAccountsDrawerHeader(
              accountName: Text('cache'),
              accountEmail: Text('오늘은 어떤 음식을 추천해드릴까요?'),
              decoration: BoxDecoration(
                color: Color(0xffA772FD),
                borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
              )),
              ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text('메인화면',style: TextStyle(color: Colors.white),),
              onTap:() {
               null;
              },
              trailing: const Icon(Icons.arrow_right,color: Colors.white,),
            ),
            ListTile(
              leading: const Icon(
                Icons.watch_later,
                color: Colors.white,
              ),
              title: const Text('최근 기록',style: TextStyle(color: Colors.white),),
              onTap:() {
                print('안녕');
              },
              trailing: const Icon(Icons.arrow_right,color: Colors.white,),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text('설정',style: TextStyle(color: Colors.white),),
              onTap:() {
                print('안녕');
              },
              trailing: const Icon(Icons.arrow_right,color: Colors.white,),
            ),
            
          ],
        ),
      );
}
