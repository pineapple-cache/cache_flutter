import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AskFoodforAI extends StatefulWidget {
  const AskFoodforAI({super.key});

  @override
  State<AskFoodforAI> createState() => _AskFoodforAIState();
}

class _AskFoodforAIState extends State<AskFoodforAI> {
  final TextEditingController _controller = TextEditingController();
  final apiKey = dotenv.get('GeminiApiKey');
  late final GenerativeModel _model;
  late final ChatSession _chat;

String prompt = '';

@override
  void initState() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _askTextField(),
              _askTextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _askTextField() {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'AI에게 질문해보세요!',
        border: InputBorder.none, 
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, 
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _askTextButton() {
    return OutlinedButton(
      onPressed: () async {
        prompt = _controller.text;
        await _responseText(prompt);
      },
      child: const Text('전송'),
    );
  }

  Future<void> _responseText(String message) async {
     final response = await _chat.sendMessage(
        Content.text(message),
      );
      debugPrint(response.text);
  }
}