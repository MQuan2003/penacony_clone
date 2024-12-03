import 'package:flutter/material.dart';

class DetailPromotionScreen extends StatelessWidget {
  final String title;
  final String description;
  final String expiration;

  const DetailPromotionScreen({
    super.key,
    required this.title,
    required this.description,
    required this.expiration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(description),
            const Divider(),
            Text('Ngày hết hạn: $expiration'),
          ],
        ),
      ),
    );
  }
}
