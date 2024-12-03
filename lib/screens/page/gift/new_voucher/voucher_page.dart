import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/gift/new_voucher/detail_new_voucher.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vouchers = [
      {
        'title': 'Discount 20%',
        'expiration': '15/12/2024',
        'description': 'Áp dụng cho đơn hàng trên 200k',
        'points': '800',
      },
      {
        'title': 'Free Dessert',
        'expiration': '01/01/2025',
        'description': 'Miễn phí món tráng miệng khi đặt từ 2 món chính',
        'points': '600',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Voucher'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Tên Voucher'),
              subtitle: const Text('Hạn sử dụng: 30/11/2024'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VoucherDetailPage(
                      title: 'Discount 10%',
                      expiration: '30/11/2024',
                      description: 'Áp dụng cho hóa đơn từ 2 món trở lên',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
