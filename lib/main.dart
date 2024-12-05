import 'package:flutter/material.dart';
import 'package:p_cf/database/seed_data.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/start/welcome.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Xóa cơ sở dữ liệu cũ nếu cần
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'my_database.db');
  await deleteDatabase(path);  // Xóa cơ sở dữ liệu cũ
  
  final sampleDataManager = SampleDataManager();
  await sampleDataManager.addSampleData();  // Thêm dữ liệu mẫu vào tất cả các bảng
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
