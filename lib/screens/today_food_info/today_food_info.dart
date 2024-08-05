import 'package:cache_flutter/providers/getTimeofDay.dart';
import 'package:cache_flutter/screens/ask_food_info/viewmodel/ask_food_controller.dart';
import 'package:cache_flutter/screens/home/home_screen.dart';
import 'package:cache_flutter/screens/recommend/recommend_Indicator.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_detail_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayFoodInfo extends StatelessWidget {

  final AskFoodResponse foodResponse;

  const TodayFoodInfo({super.key, required this.foodResponse});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E2E2E),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cancel_button(),
                const SizedBox(height: 30),
                recommend_food_text(),
                const SizedBox(height: 50),
                // _recommand_food_image(),
                const Spacer(),
                onceRecommend_button(),
                wantShowFoodDetailButton(),
              ],
            ),
          
        ),
      ),
    );
  }

  Widget recommend_food_text() {
    String timeOfDay = getTimeOfDay();

    return Column(
      children: [
         Text('오늘의 $timeOfDay',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          )
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '${foodResponse.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffA772FD)
              )
            ),
            const TextSpan(
              text: ' 어떠신가요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            ),
          ]),
        ),
      ],
    );
  }

  Widget onceRecommend_button() {
    return ElevatedButton(
      onPressed: () {
        Get.to(Recommend_Indicator(),transition: Transition.noTransition);
      }, 
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        backgroundColor: Color(0xffA772FD),
      ),
      child: Text('한번 더 추천해주세요', style: TextStyle(color: Colors.black))
    );
  }

  Widget wantShowFoodDetailButton() {
    return ElevatedButton(
      onPressed: () {
        Get.offAll(TodayFoodDetailInfo(foodResponse: foodResponse,));
      }, 
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        backgroundColor: Color(0xffA772FD),
      ),
      child: Text('음식정보 보러가기', style: TextStyle(color: Colors.black))
    );
  }
}

Widget cancel_button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Get.to(HomeScreen());
          }, 
          icon: Icon(Icons.cancel,color: Colors.white,)
        )
      ],
    );
  }
