import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/cart_provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final scheme = Theme.of(context).colorScheme;

    final cartItems = cartProvider.getCartitems.values.toList();

    if (cartItems.isEmpty) {
      return const Scaffold(
        body: EmptyBagWidget(
          imagePath: AssetsManager.logo,
          title: "Korpa je prazna",
          subtitle:
              "Dodaj svoje omiljene poslastice i završi porudžbinu.",
          buttonText: "Idi na meni",
        ),
      );
    }

    double totalPrice = 0;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.logo),
        ),
        title: const Text("Sweet Haven"),
        actions: [
          IconButton(
            onPressed: () {
              cartProvider.clearLocalCart();
            },
            icon: const Icon(Icons.delete_outline_rounded),
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
            '${cartItems.length} proizvoda spremno za porudžbinu',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          /// PRODUCTS
          ...cartItems.map((cartItem) {
            final product = productsProvider
                .findByProductId(cartItem.productId);

            if (product == null) return const SizedBox();

            totalPrice +=
                product.productPrice * cartItem.quantity;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  backgroundImage:
                      AssetImage(product.productImage),
                ),
                title: Text(
                  product.productTitle,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                    'Količina: ${cartItem.quantity}'),
                trailing: Text(
                  '${(product.productPrice * cartItem.quantity).toStringAsFixed(0)} RSD',
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

      /// TOTAL SECTION
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ukupno',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(0)} RSD',
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
                child: const Text('Nastavi na plaćanje'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
