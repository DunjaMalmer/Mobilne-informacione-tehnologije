import 'package:flutter/material.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const bool _isEmpty = false;
  static const List<Map<String, dynamic>> _cartItems = [
    {'name': 'Coko malina torta', 'price': 2400, 'qty': 1},
    {'name': 'Pistaci makaronsi', 'price': 690, 'qty': 2},
    {'name': 'Cheesecake mini', 'price': 480, 'qty': 2},
  ];

  int _totalPrice() {
    return _cartItems.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (_isEmpty) {
      return Scaffold(
        body: EmptyBagWidget(
          imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
          title: "Korpa je prazna",
          subtitle: "Dodaj svoje omiljene poslastice i zavrsi porudzbinu.",
          buttonText: "Idi na meni",
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("${AssetsManager.imagePath}/logo.png"),
        ),
        title: const Text("Sweet Haven"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: 'Obrisi sve',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        children: [
          Text(
            'Tvoja korpa',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${_cartItems.length} proizvoda spremno za porudzbinu',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          ..._cartItems.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(
                    Icons.cake_outlined,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                title: Text(
                  item['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('Kolicina: ${item['qty']}'),
                trailing: Text(
                  '${item['price']} RSD',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: scheme.outlineVariant),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ukupno',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${_totalPrice()} RSD',
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
                child: const Text('Nastavi na placanje'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
