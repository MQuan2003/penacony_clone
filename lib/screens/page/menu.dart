import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/page/profile.dart';
import 'package:p_cf/widgets/filter_dialog.dart';  // Nhập khẩu FilterDialog

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  // Danh sách các categories (danh mục)
  final List<String> categories = [
    'Burgers', 'Pizza', 'Drinks', 'Desserts', 'Snacks', 'Salads', 'Ice Cream', 'Pasta'
  ];

  // Danh sách các sản phẩm của từng category
  final Map<String, List<Map<String, String>>> products = {
    'Burgers': [
      {'name': 'Cheeseburger', 'price': '\$5.99'},
      {'name': 'Bacon Burger', 'price': '\$6.99'},
    ],
    'Pizza': [
      {'name': 'Pepperoni Pizza', 'price': '\$8.99'},
      {'name': 'Margarita Pizza', 'price': '\$7.99'},
    ],
    'Drinks': [
      {'name': 'Coke', 'price': '\$1.99'},
      {'name': 'Pepsi', 'price': '\$1.99'},
    ],
    'Desserts': [
      {'name': 'Chocolate Cake', 'price': '\$3.99'},
      {'name': 'Ice Cream', 'price': '\$2.99'},
    ],
    // Thêm các danh mục và sản phẩm khác ở đây
  };

  // Biến lưu trữ danh mục được chọn
  String selectedCategory = 'Burgers';

  // ScrollController để điều khiển cuộn
  final ScrollController _scrollController = ScrollController();

  // Lưu trữ vị trí của từng category trong danh sách
  final Map<String, GlobalKey> categoryKeys = {};

  @override
  void initState() {
    super.initState();
    // Khởi tạo GlobalKey cho từng category
    for (var category in categories) {
      categoryKeys[category] = GlobalKey();
    }
  }

  // Hàm cuộn tới danh mục được chọn
  void scrollToCategory(String category) {
    final keyContext = categoryKeys[category]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Menu'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Điều hướng đến trang tìm kiếm
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),  // Biểu tượng lọc
            onPressed: () {
              // Hiển thị Filter Dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const FilterDialog();  // Hiển thị dialog bộ lọc
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              // Phần danh sách danh mục (hàng ngang)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length, // Số lượng danh mục
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[index]; // Cập nhật danh mục được chọn
                        });
                        // Cuộn đến danh mục được chọn
                        scrollToCategory(categories[index]);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(child: Icon(Icons.fastfood)), // Icon mặc định
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            categories[index],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),
              
              
              // Hiển thị danh sách sản phẩm tương ứng với category đã chọn
              for (var category in categories) ...[
                // Tạo một key cho mỗi category để cuộn tới
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    key: categoryKeys[category],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        
                        // Danh sách sản phẩm của category
                        ListView.builder(
                          shrinkWrap: true,  // Giúp ListView không chiếm hết không gian
                          physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn cho ListView
                          itemCount: products[category]?.length ?? 0,  // Lấy số sản phẩm của category đã chọn
                          itemBuilder: (context, index) {
                            var product = products[category]![index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Center(child: Icon(Icons.fastfood)), // Placeholder hình ảnh
                                ),
                                title: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(product['price']!, style: const TextStyle(color: Colors.grey)),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Xử lý khi người dùng click vào sản phẩm
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      // Thanh điều hướng phía dưới
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // Điều hướng đến các trang khác nhau
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PromotionScreen()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GiftScreen()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
