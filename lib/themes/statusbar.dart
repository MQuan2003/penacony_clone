// status_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBar extends StatelessWidget {
  final Color backgroundColor;
  final bool isDarkIcon;

  const StatusBar({
    super.key,
    this.backgroundColor = Colors.transparent,  // Mặc định là trong suốt
    this.isDarkIcon = false, // Mặc định là icon sáng
  });

  @override
  Widget build(BuildContext context) {
    // Tùy chỉnh màu sắc thanh trạng thái
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: backgroundColor, // Màu nền thanh trạng thái
        statusBarIconBrightness: isDarkIcon ? Brightness.dark : Brightness.light, // Màu sắc icon (dark hoặc light)
      ),
    );

    return SizedBox(
      height: MediaQuery.of(context).padding.top, // Đảm bảo không bị che khuất bởi thanh trạng thái
    );
  }
}
