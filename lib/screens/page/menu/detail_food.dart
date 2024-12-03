import 'package:flutter/material.dart';
import 'package:p_cf/db_test.dart/food.dart';

class FoodDetailScreen extends StatelessWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết món ăn'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh món ăn
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage(food.backgroundImg),  // Đường dẫn ảnh nền của món ăn
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Tên món ăn
              Text(
                food.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),

              // Giá món ăn
              Text(
                '${food.price}đ',
                style: const TextStyle(fontSize: 20, color: Colors.orange),
              ),
              const SizedBox(height: 16.0),

              // Mô tả món ăn
              const Text(
                'Đây là mô tả chi tiết về món ăn, bao gồm các thành phần, hương vị, cách chế biến, và các thông tin khác để khách hàng hiểu rõ hơn về món ăn.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24.0),

            ],
          ),
        ),
      ),
    );
  }
}
