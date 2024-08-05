import 'package:flutter/material.dart';
import 'package:cache_flutter/screens/ask_food_info/viewmodel/fetch_food_info_controller.dart'; // Assuming this imports your fetchFoodData function and AskFoodResponse class

class AskFoodView extends StatefulWidget {
  const AskFoodView({super.key});

  @override
  State<AskFoodView> createState() => _AskFoodViewState();
}

class _AskFoodViewState extends State<AskFoodView> {
  late Future<List<AskFoodResponse>> futureFoodData;

  @override
  void initState() {
    super.initState();
    futureFoodData = fetchFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2e2e2e),
      appBar: AppBar(
        title: const Text('Ask Food Info'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<AskFoodResponse>>(
            future: futureFoodData,
            builder: (context, AsyncSnapshot<List<AskFoodResponse>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No data found'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    AskFoodResponse food = snapshot.data![index];
                    return ListTile(
                      title: Text(food.name,style: const TextStyle(color: Colors.white)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('넘버: ${food.id}',style: const TextStyle(color: Colors.white),),
                          Text('칼로리: ${food.kcal}',style: const TextStyle(color: Colors.white)),
                          Text('단백질: ${food.protein}',style: const TextStyle(color: Colors.white)),
                          Text('탄수화물: ${food.carbohydrate}',style: const TextStyle(color: Colors.white)),
                          Text('염분: ${food.salt}',style: const TextStyle(color: Colors.white)),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
