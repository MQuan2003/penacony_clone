import 'package:flutter/material.dart';
import 'package:p_cf/database/database_helper.dart';
import 'package:p_cf/screens/page/account/profile.dart';
import 'package:p_cf/screens/page/gift/gift_home.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/menu/detail_food.dart';

import 'package:p_cf/screens/page/promotion/promotion_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> categoryKeys = {};
  List<String> categories = [];
  Map<String, List<Map<String, dynamic>>> foods = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final db = await DatabaseHelper().database;
      final categoryResults = await db.query('category');
      final foodResults = await db.query('food');

      categories = categoryResults.map((row) => row['name'] as String).toList();
      foods = {
        for (var category in categories)
          category: foodResults
              .where((food) =>
                  food['category_id'] ==
                  categoryResults.firstWhere(
                      (cat) => cat['name'] == category)['category_id'])
              .map((food) => {
                    'id': food['food_id'],
                    'name': food['name'],
                    'price': food['price'],
                    'image': food['image'],
                  })
              .toList(),
      };

      for (var category in categories) {
        categoryKeys[category] = GlobalKey();
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void scrollToCategory(String category) {
    final keyContext = categoryKeys[category]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 160.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var category in categories) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      key: categoryKeys[category],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              category,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: foods[category]?.length ?? 0,
                            itemBuilder: (context, index) {
                              var food = foods[category]![index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  leading: food['image'] != null
                                      ? Image.network(food['image'],
                                          width: 60, height: 60)
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: const Center(
                                              child: Icon(Icons.fastfood)),
                                        ),
                                  title: Text(food['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text('\$${food['price']}',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetailScreen(
                                          food: food,
                                          previousPageTitle: 'Chi tiết món ăn',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            scrollToCategory(categories[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child:
                                    const Center(child: Icon(Icons.fastfood)),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                categories[index],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PromotionScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GiftPage()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: 'Khuyến mãi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Quà tặng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
