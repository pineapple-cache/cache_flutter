import 'package:cache_flutter/screens/select_food_type/viewModel/selectFoodTypeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReusableFoodBanner extends StatelessWidget {
  final String foodTypeText;
  final String assetName;
  final VoidCallback onSelect;

  const ReusableFoodBanner({
    Key? key,
    required this.foodTypeText,
    required this.assetName,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectFoodTypeController controller = Get.find(); // GetX controller instance

    return GestureDetector(
      onTap: onSelect,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                assetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(() => Positioned(
                right: 10,
                bottom: 10,
                child: controller.selectedFoodTypes.contains(foodTypeText)
                    ? Image.asset(
                        'assets/images/checkbox.png',
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setHeight(40),
                      )
                    : Container(),
              )),
          Positioned(
            left: 10,
            bottom: 10,
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  foodTypeText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}