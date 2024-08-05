import 'package:cache_flutter/screens/ask_food_info/viewmodel/ask_food_controller.dart';
import 'package:cache_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TodayFoodDetailInfo extends StatelessWidget {
  final AskFoodResponse foodResponse;
  const TodayFoodDetailInfo({Key? key, required this.foodResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.get('GeminiApiKey');
    late final GenerativeModel _model;
    late final ChatSession _chat;

    String promptFoodTips = '${foodResponse.name}를 맛있게 즐기는 팁을 3줄로 요약해줘';
    String promptFoodHistory = '${foodResponse.name}의 역사를 3줄로 요약해줘';
    String promptFoodNutritionInformation = '${foodResponse.name}의 칼로리, 지방, 나트륨, 단백질 정보를 3줄로 요약해서 보여줘';

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    _chat = _model.startChat();


    String removeAsterisks(String input) {
      return input.replaceAll('*', '');
    }

    Future<String?> _fetchResponse(String message) async {
      final response = await _chat.sendMessage(Content.text(message));
      if (response.text != null) {
        String cleanText = removeAsterisks(response.text!);
        return cleanText;
      }
      return null;
    }

    return Scaffold(
      backgroundColor: const Color(0xff2E2E2E),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      foodResponse.name,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.offAll(const HomeScreen());
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildInfoContainer(
                  '영양정보',
                  () => _fetchResponse(promptFoodNutritionInformation),
                ),
                _buildInfoContainer(
                  '역사',
                  () => _fetchResponse(promptFoodHistory),
                ),
                _buildInfoContainer(
                  '음식 Tip',
                  () => _fetchResponse(promptFoodTips),
                ),
                const SizedBox(height: 30),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '음식 정보 알아보기에 제공되는 정보는',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'AI 가공 데이터로,정확하지 않을수도 있습니다',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String title, Future<String?> Function() futureResponse) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xff494949),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<String?>(
        future: futureResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 209, 209, 209),
                      ),
                    ),
                    Text(snapshot.data ?? 'No data', style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data', style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
}
