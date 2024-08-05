import 'package:cache_flutter/screens/ask_food_info/model/ask_food_model.dart';
import 'package:cache_flutter/screens/ask_food_info/viewmodel/ask_food_controller.dart';
import 'package:cache_flutter/screens/select_food_type/view/select_food_type_info_view.dart';
import 'package:get/get.dart';

class SelectFoodTypeController extends GetxController {
  RxList<String> selectedFoodTypes = <String>[].obs;
  final AskFoodModel askFoodModel = AskFoodModel();

  void toggleFoodType(String foodType) {
    if (selectedFoodTypes.contains(foodType)) {
      selectedFoodTypes.remove(foodType);
    } else {
      selectedFoodTypes.add(foodType);
    }
    updateSelectedNumbers();
  }

  void updateSelectedNumbers() {
    Map<String, List<int>> ranges = {
      '한식': List.generate(162, (index) => index + 1),
      '반찬': List.generate(71, (index) => index + 163),
      '양식': List.generate(11, (index) => index + 234),
      '일식': List.generate(13, (index) => index + 245),
      '중식': List.generate(20, (index) => index + 258),
    };

    askFoodModel.selectedNumbers.clear();

    for (String foodType in selectedFoodTypes) {
      askFoodModel.selectedNumbers.addAll(ranges[foodType] ?? []);
    }
  }

  Future<void> fetchFoodInfo(int existingFoodId) async {
    AskFoodRequest askFoodRequest = AskFoodRequest();
    try {
      int foodId = askFoodModel.generateRandomNumber();
      foodId = foodId == 0 ? existingFoodId : foodId; // 선택된 숫자가 없으면 기존 foodId 사용
      AskFoodResponse response = await askFoodRequest.getFoodInfo(foodId);
      print('Received food info: ${response.name}, ${foodId}');
      navigateToNextScreen(response.name);
    } catch (e) {
      print('Error fetching food info: $e');
    }
  }

  void navigateToNextScreen(String foodName) {
    Get.to(() => const SelectFoodTypeInfoView(), arguments: {'foodName': foodName});
  }
}
