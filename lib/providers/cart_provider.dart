
import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, Book> _books = {};
  final Map<String, int> _quantities = {};

  List<Book> get items => _books.values.toList();

  int quantityOf(String bookId) => _quantities[bookId] ?? 0;

  int get totalItems {
    return _quantities.values.fold(
      0,
      (sum, quantity) => sum + quantity,
    );
  }

  int get totalPrice {
    return _books.values.fold(
      0,
      (sum, book) =>
          sum + book.price * quantityOf(book.id),
    );
  }

  void addItem(Book book) {
    _books[book.id] = book;
    _quantities[book.id] = quantityOf(book.id) + 1;
    notifyListeners();
  }

  void removeItem(String bookId) {
    final quantity = quantityOf(bookId);

    if (quantity == 0) return;

    if (quantity == 1) {
      _quantities.remove(bookId);
      _books.remove(bookId);
    } else {
      _quantities[bookId] = quantity - 1;
    }

    notifyListeners();
  }

  void clearCart() {
    _books.clear();
    _quantities.clear();
    notifyListeners();
  }
}
