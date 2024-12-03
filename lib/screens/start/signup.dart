import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p_cf/screens/start/otp.dart';
import 'package:p_cf/themes/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _validateCredentials() {
    setState(() {
      _usernameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;

      // Biểu thức RegExp để kiểm tra email
      final emailRegex =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

      // Biểu thức RegExp để kiểm tra độ mạnh của mật khẩu
      final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d).{8,}$");

      // Validate username
      if (_usernameController.text.isEmpty) {
        _usernameError = 'Hãy nhập tên đăng nhập của bạn';
      }

      // Validate email
      if (_emailController.text.isEmpty ||
          !emailRegex.hasMatch(_emailController.text)) {
        _emailError = 'Email không hợp lệ';
      }

      // Validate password
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Hãy nhập mật khẩu của bạn';
      } else if (!passwordRegex.hasMatch(_passwordController.text)) {
        _passwordError = 'Mật khẩu phải có ít nhất 8 ký tự, 1 chữ hoa và 1 số';
      }

      // Validate confirm password
      if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Mật khẩu xác nhận không khớp';
      }

      // Nếu không có lỗi, tiếp tục xử lý
      if (_usernameError == null &&
          _emailError == null &&
          _passwordError == null &&
          _confirmPasswordError == null) {
        // Thực hiện đăng ký
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPVerificationScreen(
              email: 'user@example.com', // Email từ màn hình trước
              purpose: 'Đăng ký',
            ),
          ),
        );

        print('Đăng ký thành công!');
      }
    });
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    bool isPasswordField = false,
    String? errorText,
    bool isConfirmPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: isPasswordField &&
            (isConfirmPassword
                ? _isConfirmPasswordVisible
                : _isPasswordVisible),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    (isConfirmPassword
                            ? _isConfirmPasswordVisible
                            : _isPasswordVisible)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: isConfirmPassword
                      ? _toggleConfirmPasswordVisibility
                      : _togglePasswordVisibility,
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          errorText: errorText,
          hintStyle: const TextStyle(
            color: AppColors.hinttext,
            fontSize: 11,
          ),
        ),
        onTap: () {
          setState(() {
            if (controller == _usernameController) {
              _usernameError = null;
            } else if (controller == _emailController) {
              _emailError = null;
            } else if (controller == _passwordController) {
              _passwordError = null;
            } else if (controller == _confirmPasswordController) {
              _confirmPasswordError = null;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Chào mừng thành viên mới,',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hãy tạo tài khoản để tham gia cùng chúng tôi.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Username field
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
                    errorText: _usernameError,
                  ),
                  const SizedBox(height: 16),

                  // Email field
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
                    hintText: 'Email',
                    controller: _emailController,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Mật khẩu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    hintText: 'Mật khẩu',
                    controller: _passwordController,
                    isPasswordField: true,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: 16),

                  // Confirm password field
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Xác nhận mật khẩu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    hintText: 'Xác nhận mật khẩu',
                    controller: _confirmPasswordController,
                    isPasswordField: true,
                    errorText: _confirmPasswordError,
                    isConfirmPassword: true,
                  ),
                  const SizedBox(height: 16),

                  // Sign up button
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: _validateCredentials,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              AppColors.primary, // Màu nền của button
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already a member?
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: 'Bạn đã có tài khoản? ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Đăng nhập',
                              style: const TextStyle(
                                color: AppColors.orangepeel,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(
                                      context); // Quay lại trang đăng nhập
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
