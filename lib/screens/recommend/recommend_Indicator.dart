import 'dart:async';
import 'package:cache_flutter/providers/getTimeofDay.dart';
import 'package:cache_flutter/screens/ask_food_info/model/ask_food_model.dart';
import 'package:cache_flutter/screens/ask_food_info/viewmodel/ask_food_controller.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Recommend_Indicator extends StatelessWidget {
  
const Recommend_Indicator({super.key});
 
  @override
  Widget build(BuildContext context) {
    int GenerateRandomNumber = AskFoodModel().generateRandomNumber();
    waitTimer(GenerateRandomNumber);
    String timeOfDay = getTimeOfDay();
    return Scaffold(
      backgroundColor: const Color(0xffA772FD),
      body: SafeArea(
        child: Column(
          children: [
            cancel_button(),
            const SizedBox(height: 150),
            Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('오늘의 $timeOfDay을 추천중이에요\n잠시만 기다려주세요',
                style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            )),
          ],
        ),
      )
    );
  }
}

void waitTimer(generateRandomNumber) async {
  // 뷰모델 인스턴스 생성
  AskFoodRequest viewModel = AskFoodRequest();

  try {
    await Future.delayed(const Duration(seconds: 1));
    // 뷰모델에서 데이터를 가져오기
    AskFoodResponse foodResponse = await viewModel.getFoodInfo(generateRandomNumber);
    
    // 데이터를 받아온 후에 화면을 전환
    Get.offAll(TodayFoodInfo(foodResponse: foodResponse),transition: Transition.noTransition);
  } catch (e) {
    // 오류가 발생했을 때 처리
    print('Error occurred while fetching food info: $e');
    // 혹은 오류 처리를 위해 다른 작업을 수행할 수 있음
  }
}

