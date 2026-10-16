
class Book {
  final String id;
  final String title;
  final String author;
  final int price;
  final String? imageUrl;
  final String imageAsset;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.imageUrl,
    required this.imageAsset,
  });
}
