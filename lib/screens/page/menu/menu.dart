import 'package:flutter/material.dart';
import 'package:p_cf/db_test.dart/food.dart';
import 'package:p_cf/screens/page/gift/gift_home.dart';
import 'package:p_cf/screens/page/menu/detail_food.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/account/profile.dart';
import 'package:p_cf/screens/page/promotion/promotion_screen.dart';
import 'package:p_cf/screens/search/search.dart';
import 'package:p_cf/widgets/filter_dialog.dart'; // Nhập khẩu FilterDialog

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final List<String> categories = [
    'Burgers',
    'Pizza',
    'Drinks',
    'Desserts',
    'Snacks',
    'Salads',
    'Ice Cream',
    'Pasta'
  ];

  final Map<String, List<Map<String, String>>> products = {
    'Burgers': [
      {'name': 'Cheeseburger', 'price': '\$5.99'},
      {'name': 'Bacon Burger', 'price': '\$6.99'},
    ],
    'Pizza': [
      {'name': 'Pepperoni Pizza', 'price': '\$8.99'},
      {'name': 'Margarita Pizza', 'price': '\$7.99'},
    ],
    'Drinks': [
      {'name': 'Coke', 'price': '\$1.99'},
      {'name': 'Pepsi', 'price': '\$1.99'},
    ],
    'Desserts': [
      {'name': 'Chocolate Cake', 'price': '\$3.99'},
      {'name': 'Ice Cream', 'price': '\$2.99'},
    ],
  };

  String selectedCategory = 'Burgers';

  final ScrollController _scrollController = ScrollController();

  final Map<String, GlobalKey> categoryKeys = {};

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      categoryKeys[category] = GlobalKey();
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
    return Scaffold(
      body: Stack(
        children: [
          // Nội dung cuộn phía dưới
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(
                top: 160.0), // Đẩy nội dung xuống dưới cả khối cố định
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
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
                            itemCount: products[category]?.length ?? 0,
                            itemBuilder: (context, index) {
                              var product = products[category]![index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: const Center(
                                        child: Icon(Icons.fastfood)),
                                  ),
                                  title: Text(product['name']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(product['price']!,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetailScreen(
                                            food: foods[
                                                index]), // Truyền món ăn vào
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
          // Phần đầu cố định
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề Menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchScreen()),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () async {
                              final result =
                                  await showDialog<Map<String, dynamic>>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const FilterDialog();
                                },
                              );

                              if (result != null) {
                                setState(() {
                                  // Áp dụng logic sắp xếp và lọc
                                  String sortOption = result['sortOption'];
                                  List<String> selectedCategories =
                                      result['categories'];

                                  // Sắp xếp sản phẩm
                                  if (sortOption == 'A - Z') {
                                    products.forEach((key, value) {
                                      value.sort((a, b) =>
                                          a['name']!.compareTo(b['name']!));
                                    });
                                  } else if (sortOption == 'Z - A') {
                                    products.forEach((key, value) {
                                      value.sort((a, b) =>
                                          b['name']!.compareTo(a['name']!));
                                    });
                                  } else if (sortOption == 'Thấp - Cao') {
                                    products.forEach((key, value) {
                                      value.sort((a, b) =>
                                          double.parse(a['price']!.substring(1))
                                              .compareTo(double.parse(
                                                  b['price']!.substring(1))));
                                    });
                                  } else if (sortOption == 'Cao - Thấp') {
                                    products.forEach((key, value) {
                                      value.sort((a, b) =>
                                          double.parse(b['price']!.substring(1))
                                              .compareTo(double.parse(
                                                  a['price']!.substring(1))));
                                    });
                                  }

                                  // Lọc sản phẩm
                                  if (selectedCategories.isNotEmpty &&
                                      !selectedCategories.contains('All')) {
                                    products.removeWhere((key, value) =>
                                        !selectedCategories.contains(key));
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Danh sách danh mục
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
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
      // Thanh điều hướng
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
