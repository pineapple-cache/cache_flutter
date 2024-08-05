import 'dart:math';

import 'dart:math';

class AskFoodModel {
  List<int> selectedNumbers = [];

  int generateRandomNumber() {
    if (selectedNumbers.isEmpty) {
      return Random().nextInt(277); // 선택된 숫자가 없으면 기존의 로직 사용
    } else {
      return selectedNumbers[Random().nextInt(selectedNumbers.length)];
    }
  }
}
