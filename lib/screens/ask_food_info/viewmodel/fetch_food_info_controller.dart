import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';

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

Future<List<AskFoodResponse>> fetchFoodData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(fetchDataInIsolate, receivePort.sendPort);

  final completer = Completer<List<AskFoodResponse>>();
  receivePort.listen((data) {
    if (data is List<AskFoodResponse>) {
      completer.complete(data);
    } else if (data is Exception) {
      completer.completeError(data);
    }
  });

  return completer.future;
}

Future<void> fetchDataInIsolate(SendPort sendPort) async {
  Dio dio = Dio();
  List<AskFoodResponse> foodData = [];

  // Iterate over ids from 1 to 277 and make individual requests
  for (int id = 1; id <= 277; id++) {
    try {
      final response = await dio.post(
        'http://10.80.162.160:8080/cache', // Replace with your actual API endpoint
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(<String, dynamic>{
          "id": id,
        }),
      );

      if (response.statusCode == 200) {
        AskFoodResponse foodResponse = AskFoodResponse.fromJson(response.data);
        foodData.add(foodResponse);
      } else {
        sendPort.send(Exception('Failed to load food data for id $id'));
        return;
      }
    } catch (e) {
      sendPort.send(Exception('Failed to load food data for id $id: $e'));
      return;
    }
  }

  sendPort.send(foodData);
}
