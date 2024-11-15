class Food {
  final String title;
  final String price;
  final String backgroundImg;  // Thêm thuộc tính hình ảnh nền

  Food({required this.title, required this.price, required this.backgroundImg});
}


// Giả sử bạn có một danh sách các bộ phim
final List<Food> foods = [
  Food(title: 'Inception', price: '100', backgroundImg: 'assets/inception.jpg'),
  Food(title: 'Titanic', price: '10', backgroundImg: 'assets/titanic.jpg'),
  Food(title: 'Avengers', price: '99', backgroundImg: 'assets/avengers.jpg'),
];
