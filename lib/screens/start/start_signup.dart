
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p_cf/db_test.dart/credentials.dart';
import 'package:p_cf/screens/start/otp.dart';
import 'package:p_cf/screens/start/signin.dart';

class StartSignup extends StatefulWidget {
  const StartSignup({super.key});

  @override
  StartSignupScreenState createState() => StartSignupScreenState();
}

class StartSignupScreenState extends State<StartSignup> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  void _validateCredentials() {
    setState(() {
      // Reset errors
      _emailError = null;

      // Regular expression for validating an email
      const emailPattern =
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      final emailRegex = RegExp(emailPattern);

      // Check if the email field is empty or invalid
      if (_emailController.text.isEmpty) {
        _emailError = 'Please enter your email';
      } else if (!emailRegex.hasMatch(_emailController.text)) {
        _emailError = 'Please enter a valid email address';
      } else if (_emailController.text == Credentials.username) {
        _emailError = 'Email is already registered';
      } else {
        // Navigate to the next screen if validation is successful
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPVerificationScreen(),
          ),
        );
      }
    });
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.black54),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
          errorText: _emailError,
        ),
        onTap: () {
          setState(() {
            _emailError = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const BackButton(),
          const SizedBox(height: 60),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Đăng ký',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Tạo tài khoản ở đây',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildEmailField(),
          const SizedBox(height: 32),

          // Nút Đăng Ký
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _validateCredentials,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF2E4958),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20), // Thay thế Spacer bằng SizedBox

          // Đăng Nhập
          Padding(
            padding: const EdgeInsets.only(left: 60, bottom: 60),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text.rich(
                TextSpan(
                  text: 'Đã là thành viên? ',
                  style: const TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: 'Đăng nhập',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signin(),
                          ),
                        );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
