import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cf/screens/start/welcome.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final int _resendTimeout = 30;
  Timer? _timer;
  int _currentTimer = 30;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _currentTimer = _resendTimeout;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimer > 0) {
          _currentTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validateOTP() {
    String otp = _controllers.map((controller) => controller.text).join();

    setState(() {
      if (otp.isEmpty) {
        _errorText = 'Please enter the OTP code';
      } else if (otp != '1234') { // Thay thế '1234' bằng logic xác thực OTP thực tế
        _errorText = 'Incorrect OTP code';
      } else {
        _errorText = null;
        // Xử lý khi xác thực OTP thành công
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const BackButton(),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Xác thực',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Nhập mã OTP mà chúng tôi đã gửi cho bạn',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorText: index == 0 && _errorText != null ? '' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _errorText = null; // Xóa lỗi khi nhập
                      });
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _currentTimer > 0
                    ? 'Gửi lại sau 00:${_currentTimer.toString().padLeft(2, '0')}'
                    : 'Gửi lại mã OTP',
                style: TextStyle(
                  color: _currentTimer > 0 ? Colors.black54 : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _validateOTP,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF2E4958),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
