import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:p_cf/database/repository/promotion_repository.dart';
import 'package:p_cf/screens/page/account/profile.dart';
import 'package:p_cf/screens/page/gift/gift_home.dart';
import 'package:p_cf/screens/page/menu/menu.dart';
import 'package:p_cf/screens/page/promotion/detail_promotion_screen.dart';
import 'package:p_cf/screens/page/promotion/promotion_screen.dart';
import 'package:p_cf/screens/search/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PromotionRepository promotionRepository = PromotionRepository();
  List<Promotion> promotions = [];

  @override
  void initState() {
    super.initState();
    _loadPromotions();
  }

  Future<void> _loadPromotions() async {
    final loadedPromotions = await promotionRepository.getPromotions();
    setState(() {
      promotions = loadedPromotions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 75.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child: Icon(Icons.person, size: 30, color: Colors.white),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Chào mừng bạn trở lại',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'N L D M Q',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()),
                            );
                          },
                          child: const Icon(Icons.search,
                              size: 28, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                // Carousel hiển thị khuyến mãi
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Các khuyến mãi hấp dẫn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0),
                promotions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : CarouselSlider(
                        items: promotions.map((promotion) {
                          return GestureDetector(
                            onTap: () {
                              // Điều hướng đến trang chi tiết
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPromotionScreen(
                                    title: promotion.title,
                                    description: promotion.description,
                                    expiration: promotion.endDate,
                                    image: promotion.image,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: AssetImage(promotion.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    promotion.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
              ],
            ),
          ),
          // Phần tiêu đề cố định
          Container(
            height: 90.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF009688), Color(0xFF004D40)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Penacony Coffee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
