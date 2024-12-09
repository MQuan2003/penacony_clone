import 'package:p_cf/database/database_helper.dart';

class Voucher {
  final int id;
  final String title;
  final String description;
  final String image;
  final int requiredPoint;
  final int end_date;

  Voucher({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.requiredPoint,
    required this.end_date,
  });

  // Tạo một đối tượng `Voucher` từ Map
  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      id: map['voucher_id'],
      title: map['title'],
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      requiredPoint: map['required_point'],
      end_date: map['end_date']
    );
  }

  // Chuyển đổi `Voucher` thành Map
  Map<String, dynamic> toMap() {
    return {
      'voucher_id': id,
      'title': title,
      'description': description,
      'image': image,
      'required_point': requiredPoint,
      'end_date': end_date,
    };
  }
}

class VoucherRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Lấy tất cả voucher từ cơ sở dữ liệu
  Future<List<Voucher>> getAllVouchers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('voucher');

    return List.generate(maps.length, (i) => Voucher.fromMap(maps[i]));
  }

  // Lấy voucher theo ID
  Future<Voucher?> getVoucherById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'voucher',
      where: 'voucher_id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Voucher.fromMap(maps.first);
    }
    return null;
  }

  // Thêm voucher mới
  Future<void> insertVoucher(Voucher voucher) async {
    if (voucher.title.isEmpty) {
      throw Exception('Voucher title cannot be empty');
    }
    final db = await _dbHelper.database;
    await db.insert('voucher', voucher.toMap());
  }

  // Cập nhật voucher
  Future<void> updateVoucher(Voucher voucher) async {
    final db = await _dbHelper.database;
    await db.update(
      'voucher',
      voucher.toMap(),
      where: 'voucher_id = ?',
      whereArgs: [voucher.id],
    );
  }
  

  // Lấy voucher của người dùng
  Future<List<Voucher>> getUserVouchers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('user_vouchers');
    return maps.map((map) => Voucher.fromMap(map)).toList();
  }

  // Xóa voucher
  Future<void> deleteVoucher(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'voucher',
      where: 'voucher_id = ?',
      whereArgs: [id],
    );
  }
}
