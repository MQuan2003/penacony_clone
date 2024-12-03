// profile_screen.dart

import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/account/account_detail_item.dart';
import 'package:p_cf/screens/page/account/screens/change_password_screen.dart';
import 'package:p_cf/screens/page/account/screens/personal_info_screen.dart';
import 'package:p_cf/screens/page/gift/gift_home.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/menu/menu.dart';
import 'package:p_cf/screens/page/promotion/promotion_screen.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'N L D M Q',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  '100P',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Chức năng đăng xuất
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green, backgroundColor: Colors.white,
              ),
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
        backgroundColor: Colors.green[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Ảnh đại diện
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            // Thông tin tài khoản
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin tài khoản',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  AccountDetailItem(
                    title: 'Thông tin cá nhân', 
                    destination: UpdateProfileScreen(),
                  ),
                  AccountDetailItem(
                    title: 'Đổi mật khẩu', 
                    destination: ChangePasswordScreen(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Thông tin cá nhân
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Account details',
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //       ),
            //       SizedBox(height: 16),
            //       AccountDetailItem(
            //         title: 'Payment Methods', 
            //         destination: PaymentMethodScreen(),
            //       ),
            //       AccountDetailItem(
            //         title: 'Notifications', 
            //         destination: NotificationScreen(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      // Thanh điều hướng dưới cùng

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
