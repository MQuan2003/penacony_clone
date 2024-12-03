import 'package:flutter/material.dart';
import 'package:p_cf/db_test.dart/promotion_data.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/account/profile.dart';
import 'package:p_cf/screens/page/gift/gift_home.dart';
import 'package:p_cf/screens/page/menu/menu.dart';
import 'package:p_cf/screens/page/promotion/detail_promotion_screen.dart';
 // Import FilterDialog nếu cần

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  PromotionScreenState createState() => PromotionScreenState();
}

class PromotionScreenState extends State<PromotionScreen> {
  // Danh sách các chương trình khuyến mãi
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Các khuyến mãi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Thanh tìm kiếm
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: "Search promotions",
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16.0),

            // Danh sách các chương trình khuyến mãi
            Expanded(
              child: ListView.builder(
                itemCount: promotions.length,
                itemBuilder: (context, index) {
                  final promotion = promotions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),
                      title: Text(
                        promotion['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ngày hết hạn: ${promotion['expiration']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Điều hướng đến màn hình chi tiết
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPromotionScreen(
                              title: promotion['title']!,
                              description: promotion['description']!,
                              expiration: promotion['expiration']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Thanh điều hướng dưới cùng
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

