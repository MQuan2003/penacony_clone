import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allProducts = [
    'Bạc Xỉu Lắc Sữa Yến Mạch',
    'Bạc Xỉu Lắc Caramel Muối',
    'Bạc Xỉu Lắc Hạnh Nhân Nướng',
    'Cà Phê Sữa Đá',
    'Trà Sữa Trân Châu',
    'Trà Đào Cam Sả',
    'Sinh Tố Xoài',
  ]; // Danh sách sản phẩm mẫu
  List<String> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
  }

  void _searchProducts(String query) {
    final results = _allProducts.where((product) {
      return product.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm sản phẩm...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: _searchProducts,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              _searchController.clear();
              _searchProducts(''); // Hiển thị tất cả khi xóa tìm kiếm
            },
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(_filteredProducts[index]),
              subtitle: const Text('Giá: 45.000đ'), // Giá mẫu cho mỗi sản phẩm
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/product_placeholder.png', // Thay thế bằng đường dẫn hình ảnh thực
                  fit: BoxFit.cover,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // Xử lý thêm sản phẩm vào giỏ hàng
                },
              ),
              onTap: () {
                // Xử lý khi chọn sản phẩm
              },
            ),
          );
        },
      ),
    );
  }
}