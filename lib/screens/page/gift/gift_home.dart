import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/account/profile.dart';
import 'package:p_cf/screens/page/gift/my_voucher/detail_my_voucher.dart';
import 'package:p_cf/screens/page/gift/my_voucher/my_voucher_page.dart';
import 'package:p_cf/screens/page/gift/new_voucher/detail_new_voucher.dart';
import 'package:p_cf/screens/page/gift/new_voucher/voucher_page.dart';

import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/menu/menu.dart';
import 'package:p_cf/screens/page/promotion/promotion_screen.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header section
          Container(
            color: Colors.teal,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '0 P',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyVoucherPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'My voucher',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/barcode.png', // Replace with a valid barcode asset
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'MV100203',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tabs section
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Trade P'),
                _buildTabButton('History trade P'),
              ],
            ),
          ),
          const Divider(),
          // Voucher lists
          Expanded(
            child: ListView(
              children: [
                _buildVoucherSection('New voucher', context, true),
                _buildVoucherSection('Voucher của tôi', context, false),
              ],
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

  Widget _buildTabButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title),
    );
  }

  Widget _buildVoucherSection(
      String title, BuildContext context, bool showPoints) {
    final vouchers = [
      {
        'title': 'Discount 10%',
        'expiration': '30/11/2024',
        'description': 'Áp dụng cho hóa đơn từ 2 món trở lên',
        'points': '490',
      },
      {
        'title': 'Free Coffee',
        'expiration': '31/12/2024',
        'description': 'Tặng 1 ly coffee miễn phí cho đơn hàng trên 100k',
        'points': '700',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => title == 'Voucher của tôi'
                          ? const MyVoucherPage()
                          : const VoucherPage(),
                    ),
                  );
                },
                child: const Text('See all'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              final voucher = vouchers[index];
              return _buildVoucherItem(context, voucher, showPoints);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherItem(
      BuildContext context, Map<String, String> voucher, bool showPoints) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          voucher['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hạn sử dụng: ${voucher['expiration']}',
              style: const TextStyle(color: Colors.grey),
            ),
            if (showPoints) ...[
              const SizedBox(height: 4),
              Text(
                'Số điểm cần để đổi: ${voucher['points']} điểm',
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ],
          ],
        ),
        onTap: () {
          // Điều hướng đến trang chi tiết tùy thuộc vào loại voucher
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => showPoints
                  ? VoucherDetailPage(
                      title: voucher['title']!,
                      expiration: voucher['expiration']!,
                      description: voucher['description']!,
                    )
                  : MyVoucherDetailPage(
                      title: voucher['title']!,
                      expiration: voucher['expiration']!,
                      description: voucher['description']!,
                    ),
            ),
          );
        },
      ),
    );
  }
}
