import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cache_flutter/screens/ask_food_info/model/ask_food_model.dart';

class AskFoodRequest {
  final Dio _dio = Dio();
  final AskFoodModel _model = AskFoodModel();

  Future<AskFoodResponse> getFoodInfo(generateRandomNumber) async {
    try {
      var response = await _dio.post(
        'http://10.80.162.160:8080/cache', // 서버 URL로 대체
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: json.encode({
          "id": generateRandomNumber,
        }),
      );

      if (response.statusCode == 200) {
        return AskFoodResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to send random number $generateRandomNumber. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class AskFoodResponse {
  final int id;
  final String name;
  final String kcal;
  final String protein;
  final String carbohydrate;
  final String salt;
  final String tag;

  AskFoodResponse({
    required this.id,
    required this.name,
    required this.kcal,
    required this.protein,
    required this.carbohydrate,
    required this.salt,
    required this.tag,
  });

  factory AskFoodResponse.fromJson(Map<String, dynamic> json) {
    return AskFoodResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      kcal: json['kcal'] ?? '',
      protein: json['protein'] ?? '',
      carbohydrate: json['carbohydrate'] ?? '',
      salt: json['salt'] ?? '',
      tag: json['tag'] ?? '',
    );
  }
}