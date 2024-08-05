import 'package:cache_flutter/screens/recommend/recommend_indicator.dart';
import 'package:cache_flutter/screens/select_food_type/view/components/reusable_FoodBanner.dart';
import 'package:cache_flutter/screens/select_food_type/viewModel/selectFoodTypeController.dart';
import 'package:cache_flutter/screens/today_food_info/today_food_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectFoodTypeView extends StatelessWidget {
  const SelectFoodTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectFoodTypeController controller = Get.put(SelectFoodTypeController());

    return Scaffold(
      backgroundColor: const Color(0xff2e2e2e),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const SelectFoodTypeText(),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(500),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ReusableFoodBanner(
                          foodTypeText: '한식',
                          assetName: 'assets/images/food_bibimbap.jpg',
                          onSelect: () {
                            controller.toggleFoodType('한식');
                          }),
                      SizedBox(height: 20),
                      ReusableFoodBanner(
                          foodTypeText: '반찬',
                          assetName: 'assets/images/food_sidedish.jpg',
                          onSelect: () {
                            controller.toggleFoodType('반찬');
                          }),
                      SizedBox(height: 20),
                      ReusableFoodBanner(
                          foodTypeText: '양식',
                          assetName: 'assets/images/food_steak.jpg',
                          onSelect: () {
                            controller.toggleFoodType('양식');
                          }),
                      SizedBox(height: 20),
                      ReusableFoodBanner(
                          foodTypeText: '일식',
                          assetName: 'assets/images/food_sushi.jpg',
                          onSelect: () {
                            controller.toggleFoodType('일식');
                          }),
                      SizedBox(height: 20),
                      ReusableFoodBanner(
                          foodTypeText: '중식',
                          assetName: 'assets/images/food_champon.jpg',
                          onSelect: () {
                            controller.toggleFoodType('중식');
                          }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, ScreenUtil().setHeight(50)),
                  backgroundColor: const Color(0xffA772FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  controller.fetchFoodInfo(0);
                 
                },
                child: const Text('다음', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectFoodTypeText extends StatelessWidget {
  const SelectFoodTypeText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(70),
      child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('먹고싶은 음식 종류를', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
        Text('선택해주세요', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
        ),
    );
  }
}