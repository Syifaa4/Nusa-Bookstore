
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

const List<Book> sampleBooks = [
  Book(
    id: 'B001',
    title: 'Laut Bercerita',
    author: 'Leila S. Chudori',
    price: 95000,
    imageAsset: 'assets/images/books/laut_bercerita.jpg',
  ),
  Book(
    id: 'B002',
    title: 'Amba',
    author: 'Laksmi Pamuntjak',
    price: 151200,
    imageAsset: 'assets/images/books/amba.jpg',
  ),
  Book(
    id: 'B003',
    title: 'Keajaiban Toko Kelontong Namiya',
    author: 'Keigo Higashino',
    price: 111200,
    imageAsset: 'assets/images/books/keajaiban.jpg',
  ),
  Book(
    id: 'B004',
    title: 'Tragedi Pedang Keadilan',
    author: 'Keigo Higashino',
    price: 103200,
    imageAsset: 'assets/images/books/tragedi.jpg',
  ),
  Book(
    id: 'B005',
    title: 'Loversation',
    author: 'Valerie Patkar',
    price: 111750,
    imageAsset: 'assets/images/books/loversation.jpg',
  ),
  Book(
    id: 'B006',
    title: 'Sang Alkemis (The Alchemist)',
    author: 'Paulo Coelho',
    price: 55200,
    imageAsset: 'assets/images/books/sang_alkemis.jpg',
  ),
  Book(
    id: 'B007',
    title: 'Seporsi Mie Ayam Sebelum Mati',
    author: 'Brian Khrisna',
    price: 83700,
    imageAsset: 'assets/images/books/seporsi_mieAyam.jpg',
  ),
];

String formatRupiah(int price) {
  final digits = price.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);

    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp$buffer';
}

const Map<String, String> bookDescriptions = {
  'B001':
      'Laut Bercerita berkisah tentang keluarga yang kehilangan, '
      'sekumpulan sahabat yang merasakan kekosongan, serta keluarga '
      'yang mencari kejelasan tentang nasib anak-anak mereka. Novel '
      'karya Leila S. Chudori ini mengangkat kisah tentang kehilangan, '
      'perjuangan, pengkhianatan, dan cinta yang tak akan luntur.',
  'B002':
      'Pada tahun 2006, Amba pergi ke Pulau Buru untuk mencari '
      'Bhisma, laki-laki yang dicintainya dan ayah dari anaknya. '
      'Bhisma, seorang dokter lulusan Leipzig, ditangkap pemerintah '
      'Orde Baru dan dibuang ke Pulau Buru, tetapi tak pernah kembali '
      'setelah kamp tahanan politik dibubarkan. Berlatar sejarah '
      'Indonesia, novel karya Laksmi Pamuntjak ini mengisahkan '
      'perjalanan cinta Amba, perpisahan akibat pergolakan politik, '
      'serta pencarian jawaban tentang masa lalu Bhisma.',
  'B003':
      'Ketika tiga pemuda berandal bersembunyi di toko kelontong '
      'tak berpenghuni setelah melakukan pencurian, sebuah surat '
      'misterius berisi permintaan saran masuk melalui lubang surat. '
      'Surat tersebut membawa mereka dalam petualangan melintasi '
      'waktu dan menggantikan peran kakek pemilik toko yang dahulu '
      'memberikan nasihat kepada orang-orang. Hanya dalam satu malam, '
      'kehidupan ketiga pemuda itu berubah selamanya.',
  'B004':
      'Sejak istrinya meninggal, Nagamine Shigeki hidup bersama '
      'putrinya, Ema. Namun, Ema ditemukan tewas setelah pergi '
      'menonton festival musim panas. Ketika Nagamine menemukan '
      'rekaman yang mengungkap peristiwa pemerkosaan dan pembunuhan '
      'putrinya, ia diliputi duka dan amarah. Karena yakin para pelaku '
      'akan mendapat hukuman ringan akibat masih di bawah umur, '
      'Nagamine memutuskan untuk mengadili mereka dengan tangannya '
      'sendiri. Novel ini mempertanyakan keadilan dan batas antara '
      'hukum serta balas dendam.',
  'B005':
      'Theala bersembunyi di balik keheningan sebagai perempuan '
      'mandiri yang enggan memiliki angan-angan, sedangkan Dirga '
      'menutupi dirinya di balik keramaian dan kesenangan. Di balik '
      'kepribadian mereka, terdapat trauma masa kecil dan perasaan '
      'yang terpendam. Melalui komunikasi dan keberanian untuk '
      'berbicara, kisah Loversation karya Valerie Patkar mengajak '
      'pembaca memahami diri sendiri, menemukan teman bicara, '
      'serta menyebarkan cinta dan kebaikan.',
  'B006':
      'Santiago, seorang anak gembala dari Spanyol, melakukan '
      'perjalanan menuju padang pasir Mesir untuk mencari harta '
      'karun di Piramida. Dalam perjalanannya, ia bertemu dengan '
      'seorang perempuan Gipsi, lelaki yang mengaku sebagai raja, '
      'dan seorang alkemis yang membantunya menemukan jalan. '
      'Perjalanan untuk mencari harta duniawi perlahan berubah '
      'menjadi pencarian jati diri, kekuatan mimpi, dan kebijaksanaan '
      'untuk mendengarkan suara hati.',
  'B007':
      'Seperti malam-malam biasanya, seorang pria pulang setelah '
      'lembur dan menghabiskan malam ulang tahunnya sendirian. '
      'Ia merasa takut belum menjalani hidup sebagaimana mestinya '
      'dan mempertanyakan apakah hidupnya pantas dilanjutkan. '
      'Di tengah kesepian dan pergulatan batinnya, ia memutuskan '
      'untuk mengakhiri hidupnya 24 jam kemudian. Novel karya '
      'Brian Khrisna ini mengangkat kesepian, pergulatan hidup, '
      'dan pencarian makna di tengah perasaan kehilangan arah.',
};

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Map<String, int> _selectedQuantities = {};
  final Set<String> _favorites = {};

  int _quantityFor(Book book) => _selectedQuantities[book.id] ?? 1;

  void _changeQuantity(Book book, int difference) {
    final current = _quantityFor(book);
    final next = current + difference;

    if (next < 1 || next > 99) return;

    setState(() {
      _selectedQuantities[book.id] = next;
    });
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (_favorites.contains(book.id)) {
        _favorites.remove(book.id);
      } else {
        _favorites.add(book.id);
      }
    });
  }

  void _addToCart(Book book, {int? quantity}) {
    final selectedQuantity = quantity ?? _quantityFor(book);
    final cart = context.read<CartProvider>();

    for (int i = 0; i < selectedQuantity; i++) {
      cart.addItem(book);
    }

    setState(() {
      _selectedQuantities[book.id] = 1;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$selectedQuantity ${book.title} ditambahkan ke keranjang',
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Lihat',
            onPressed: _openCart,
          ),
        ),
      );
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartScreen(),
      ),
    );
  }

  void _showBookDetails(Book book) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final isDark =
            Theme.of(sheetContext).brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            void changeSheetQuantity(int difference) {
              final next = _quantityFor(book) + difference;

              if (next < 1 || next > 99) return;

              setState(() {
                _selectedQuantities[book.id] = next;
              });

              setSheetState(() {});
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  24 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 88,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 132,
                          height: 164,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF344454)
                                : const Color(0xFFF1E5D2),
                            borderRadius: BorderRadius.circular(18),
                          ),                         
                          child: Image.asset(
                            book.imageAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image_outlined,
                                size: 48,
                                color: Colors.redAccent,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        book.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Oleh ${book.author}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        formatRupiah(book.price),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xFFD18A45),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sinopsis',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bookDescriptions[book.id] ??
                            'Informasi buku belum tersedia.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jumlah buku',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          _QuantitySelector(
                            quantity: _quantityFor(book),
                            onDecrease: () => changeSheetQuantity(-1),
                            onIncrease: () => changeSheetQuantity(1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total harga'),
                          Text(
                            formatRupiah(
                              book.price * _quantityFor(book),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD18A45),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            final selected = _quantityFor(book);
                            Navigator.pop(sheetContext);
                            _addToCart(book, quantity: selected);
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Tambah ke Keranjang'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFD18A45),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          isDark
              ? 'assets/images/logo_dark.png'
              : 'assets/images/logo_light.png',
          height: 48,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'NusaBookstore',
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Ganti ke Light Mode' : 'Ganti ke Dark Mode',
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                return IconButton(
                  tooltip: 'Keranjang belanja',
                  onPressed: _openCart,
                  icon: Badge(
                    label: Text('${cart.totalItems}'),
                    isLabelVisible: cart.totalItems > 0,
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF29251F)
                  : const Color(0xFF243B53),
              borderRadius: BorderRadius.circular(24),
              border: isDark
                  ? Border.all(color: const Color(0xFF6C5435))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.auto_stories_rounded,
                  color: Color(0xFFE9B967),
                  size: 38,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Temukan cerita,\nluaskan duniamu.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pilihan bacaan untuk menemani setiap perjalanan.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'KOLEKSI PILIHAN  •  4 BUKU',
                    style: TextStyle(
                      color: Color(0xFFE9B967),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jelajahi Buku',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '${sampleBooks.length} buku',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Ketuk buku untuk membaca sinopsisnya.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          ...sampleBooks.map(
            (book) => _BookCard(
              book: book,
              quantity: _quantityFor(book),
              isFavorite: _favorites.contains(book.id),
              onDecrease: () => _changeQuantity(book, -1),
              onIncrease: () => _changeQuantity(book, 1),
              onFavorite: () => _toggleFavorite(book),
              onDetails: () => _showBookDetails(book),
              onAdd: () => _addToCart(book),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Temukan bacaan favoritmu di NusaBookstore',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor.withValues(alpha: 0.6),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;
  final int quantity;
  final bool isFavorite;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onFavorite;
  final VoidCallback onDetails;
  final VoidCallback onAdd;

  const _BookCard({
    required this.book,
    required this.quantity,
    required this.isFavorite,
    required this.onDecrease,
    required this.onIncrease,
    required this.onFavorite,
    required this.onDetails,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onDetails,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 94,
                    height: 128,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF344454)
                          : const Color(0xFFF1E5D2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(
                      book.imageAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                          color: Colors.redAccent,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: InkWell(
                    onTap: onDetails,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            book.author,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            formatRupiah(book.price),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD18A45),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Lihat sinopsis  →',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: isFavorite
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                _QuantitySelector(
                  quantity: quantity,
                  onDecrease: onDecrease,
                  onIncrease: onIncrease,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF302B25)
                    : const Color(0xFFFAF3E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total harga',
                    style: TextStyle(fontSize: 13),
                  ),
                  Flexible(
                    child: Text(
                      formatRupiah(book.price * quantity),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Color(0xFFD18A45),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_shopping_cart, size: 19),
                label: const Text('Tambah ke Keranjang'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF243B53),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantitySelector({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Kurangi jumlah',
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          onPressed: quantity > 1 ? onDecrease : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        SizedBox(
          width: 28,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          tooltip: 'Tambah jumlah',
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          onPressed: quantity < 99 ? onIncrease : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
