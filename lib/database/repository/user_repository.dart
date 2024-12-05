import 'package:p_cf/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Thêm người dùng mới
  Future<void> registerUser(String username, String email, String password) async {
    final db = await _dbHelper.database;
    await db.insert(
      'user', // Sử dụng bảng `user` đã có
      {
        'username': username,
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.fail, // Nếu có xung đột (username/email trùng), sẽ báo lỗi
    );
  }

  /// Tìm người dùng bằng tên đăng nhập và mật khẩu
  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'user', // Sử dụng bảng `user` đã có
      where: 'username = ? AND password = ?', // Điều kiện
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null; // Trả về kết quả đầu tiên nếu tìm thấy
  }

  /// Kiểm tra xem người dùng đã tồn tại chưa
  Future<bool> checkUserExists(String username, String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'user', // Sử dụng bảng `user` đã có
      where: 'username = ? OR email = ?', // Kiểm tra trùng username hoặc email
      whereArgs: [username, email],
    );
    return result.isNotEmpty;
  }
}
