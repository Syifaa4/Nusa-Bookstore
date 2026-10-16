
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import 'catalog_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.totalItems == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 76,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Keranjangmu masih kosong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Yuk, temukan buku yang ingin kamu baca.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Jelajahi Buku'),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final book = cart.items[index];
                    final quantity = cart.quantityOf(book.id);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                book.imageAsset,
                                width: 64,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 64,
                                    height: 90,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    child: const Icon(
                                      Icons.menu_book_rounded,
                                      size: 34,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(book.author),
                                  const SizedBox(height: 8),
                                  Text(
                                    formatRupiah(book.price * quantity),
                                    style: const TextStyle(
                                      color: Color(0xFFD18A45),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        tooltip: 'Kurangi jumlah',
                                        visualDensity:
                                            VisualDensity.compact,
                                        onPressed: () {
                                          context
                                              .read<CartProvider>()
                                              .removeItem(book.id);
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),
                                      Text(
                                        '$quantity',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Tambah jumlah',
                                        visualDensity:
                                            VisualDensity.compact,
                                        onPressed: () {
                                          context
                                              .read<CartProvider>()
                                              .addItem(book);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        tooltip: 'Hapus buku',
                                        onPressed: () {
                                          for (int i = 0;
                                              i < quantity;
                                              i++) {
                                            context
                                                .read<CartProvider>()
                                                .removeItem(book.id);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _CheckoutPanel(
                totalItems: cart.totalItems,
                totalPrice: cart.totalPrice,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  final int totalItems;
  final int totalPrice;

  const _CheckoutPanel({
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Item'),
                Text(
                  '$totalItems buku',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pembayaran'),
                Text(
                  formatRupiah(totalPrice),
                  style: const TextStyle(
                    color: Color(0xFFD18A45),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Konfirmasi Checkout'),
                      content: Text(
                        'Bayar ${formatRupiah(totalPrice)} '
                        'untuk $totalItems buku?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: const Text('Batal'),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);

                            context.read<CartProvider>().clearCart();

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Checkout berhasil! Terima kasih '
                                    'sudah berbelanja di NusaBookstore.',
                                  ),
                                ),
                              );
                          },
                          child: const Text('Bayar Sekarang'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Checkout / Bayar'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFD18A45),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
