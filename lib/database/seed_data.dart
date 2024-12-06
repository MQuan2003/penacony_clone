import 'package:p_cf/database/repository/promotion_repository.dart';

import 'database_helper.dart';

class SampleDataManager {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addSampleData() async {
    await _addSampleCategories();
    await _addSampleFoods();
    await _addSamplePromotions();
    await _addSampleVouchers();
  }

  Future<void> _addSampleCategories() async {
    final db = await _dbHelper.database;
    final categories = await db.query('category');
    if (categories.isEmpty) {
      await db
          .insert('category', {'name': 'Cà phê', 'icon': 'coffee_icon.png'});
      await db.insert('category', {'name': 'Trà', 'icon': 'tea_icon.png'});
    }
  }

  Future<void> _addSampleFoods() async {
    final db = await _dbHelper.database;
    final foods = await db.query('food');
    if (foods.isEmpty) {
      await db.insert('food', {
        'category_id': 1,
        'name': 'Cà phê sữa',
        'price': 35000,
        'description': 'Cà phê sữa đặc biệt với hương vị đậm đà.',
        'is_best_seller': 1,
        'image': 'assets/images/coffee_milk.png',
      });
      await db.insert('food', {
        'category_id': 2,
        'name': 'Trà đào',
        'price': 45000,
        'description': 'Trà đào tươi mát, giải nhiệt.',
        'is_best_seller': 0,
        'image': 'assets/images/peach_tea.png',
      });
    }
  }

  Future<void> _addSamplePromotions() async {
    final repo = PromotionRepository();
    final promotions = await repo.getPromotions();
    if (promotions.isEmpty) {
      final samplePromotions = [
        Promotion(
          id: 1,
          title: 'Giảm Giá 20% Toàn Bộ Cà Phê',
          description:
              'Đừng bỏ lỡ cơ hội thưởng thức cà phê yêu thích với ưu đãi giảm giá 20%! Áp dụng cho tất cả các loại cà phê từ 01/12 đến 31/12/2024.',
          image: 'assets/images/promo1.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-31',
        ),
        Promotion(
          id: 2,
          title: 'Mua 1 Latte, Tặng 1 Latte',
          description:
              'Thỏa mãn vị giác với ưu đãi đặc biệt: Mua 1 cốc latte bất kỳ, nhận thêm 1 cốc miễn phí. Áp dụng từ 10/12 đến 25/12/2024.',
          image: 'assets/images/promo2.webp',
          startDate: '2024-12-10',
          endDate: '2024-12-25',
        ),
        Promotion(
          id: 3,
          title: 'Combo Điểm Tâm Năng Lượng',
          description:
              'Combo bánh mì ốp la xúc xích và cà phê sữa đá chỉ với ưu đãi 15%. Thưởng thức bữa sáng ngon lành và tiết kiệm!',
          image: 'assets/images/promo3.webp',
          startDate: '2024-12-05',
          endDate: '2024-12-20',
        ),
        Promotion(
          id: 4,
          title: 'Giảm giá 10% món ăn trưa',
          description:
              'Nhận ngay ưu đãi giảm 10% cho tất cả các món ăn trưa từ 11:00 - 14:00 hàng ngày. Hãy đến và thưởng thức ngay!',
          image: 'assets/images/promo4.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-31',
        ),
        Promotion(
          id: 5,
          title: 'Giảm 10% Cho Món Trà Sữa',
          description:
              'Ưu đãi giảm giá 10% cho tất cả các món trà sữa. Thích hợp để thưởng thức cùng bạn bè hoặc một mình. Áp dụng từ 01/12 đến 15/12/2024.',
          image: 'assets/images/promo5.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-15',
        ),
        // Promotion(
        //   id: 6,
        //   title: 'Tặng 1 Ly Trà Đào Cho Hóa Đơn Trên 100K',
        //   description:
        //       'Nhận ngay 1 ly trà đào cam sả miễn phí khi hóa đơn đạt từ 100,000đ. Ưu đãi áp dụng từ 01/12 đến 20/12/2024.',
        //   image: 'assets/images/promo6.webp',
        //   startDate: '2024-12-01',
        //   endDate: '2024-12-20',
        // ),
      ];
      for (var promotion in samplePromotions) {
        await repo.insertPromotion(promotion);
      }
    }
  }

  Future<void> _addSampleVouchers() async {
    final db = await _dbHelper.database;
    final vouchers = await db.query('voucher');
    if (vouchers.isEmpty) {
      await db.insert('voucher', {
        'title': 'Voucher 50%',
        'description': 'Giảm 50% cho đơn hàng từ 100.000đ.',
        'required_point': 50,
        'end_date': '2024-12-31',
        'image': 'assets/images/voucher1.png',
      });
    }
  }
}
