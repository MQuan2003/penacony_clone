import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _usernameController = TextEditingController(text: 'Username');
  final TextEditingController _fullnameController = TextEditingController(text: 'Full Name user');
  final TextEditingController _emailController = TextEditingController(text: 'Email');
  final TextEditingController _dobController = TextEditingController(text: 'DOB');
  final TextEditingController _genderController = TextEditingController(text: 'Gender');

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12, // Kích thước hintText
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin cá nhân"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar_placeholder.png'), // Thay ảnh mặc định
                      backgroundColor: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {
                        // Logic thay đổi ảnh
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Các ô nhập liệu
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Tên đăng nhập',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'Tên đăng nhập',
                controller: _usernameController,
                enabled: false,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Họ và tên',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'Nhập họ và tên',
                controller: _fullnameController,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'Email của bạn',
                controller: _emailController,
                enabled: false,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Ngày sinh',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'VD: 01/01/2000',
                controller: _dobController,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Giới tính',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'VD: Nam, Nữ',
                controller: _genderController,
              ),
              const SizedBox(height: 32),

              // Nút cập nhật
              ElevatedButton(
                onPressed: () {
                  // Xử lý cập nhật
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
