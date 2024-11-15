import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/menu.dart';

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
              child: const Text('Sign out'),
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
                    'Account details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  AccountDetailItem(),
                  AccountDetailItem(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Thông tin cá nhân
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  AccountDetailItem(),
                  AccountDetailItem(),
                ],
              ),
            ),
          ],
        ),
      ),
      // Thanh điều hướng dưới cùng
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PromotionScreen()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GiftScreen()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

// Widget cho mỗi mục thông tin cá nhân
class AccountDetailItem extends StatelessWidget {
  const AccountDetailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Personal information',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Switch(
            value: true,
            onChanged: (bool value) {
              // Chức năng khi bật tắt
            },
          ),
        ],
      ),
    );
  }
}
