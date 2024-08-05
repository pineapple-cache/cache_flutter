import 'package:cache_flutter/providers/getTimeofDay.dart';
import 'package:cache_flutter/screens/ask_food_info/viewmodel/ask_food_controller.dart';
import 'package:cache_flutter/screens/recommend/recommend_Indicator.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_detail_info.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectFoodTypeInfoView extends StatefulWidget {
  const SelectFoodTypeInfoView({super.key});

  @override
  State<SelectFoodTypeInfoView> createState() => _SelectFoodTypeInfoViewState();
}

class _SelectFoodTypeInfoViewState extends State<SelectFoodTypeInfoView> {

final arguments = Get.arguments[0];
final foodName = Get.arguments['foodName'];

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
              text: '$foodName',
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

  Widget wantShowFoodDetailButton() {
    return ElevatedButton(
      onPressed: () async {
         AskFoodResponse foodResponse = await foodName;
        Get.offAll(TodayFoodDetailInfo(foodResponse: foodResponse));
      }, 
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        backgroundColor: Color(0xffA772FD),
      ),
      child: Text('음식정보 보러가기', style: TextStyle(color: Colors.black))
    );
  }
}
