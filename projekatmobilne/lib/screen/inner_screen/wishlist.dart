import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/models/product_model.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/providers/wishlist_provider.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/empty_bag.dart';
import 'package:projekatmobilne/widgets/products/product_widget.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = "/WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    final wishlistProducts = wishlistProvider.getWishlists.values
        .map((item) => productsProvider.findByProductId(item.productId))
        .whereType<ProductModel>()
        .toList();

    if (wishlistProducts.isEmpty) {
      return const Scaffold(
        body: EmptyBagWidget(
          imagePath: "${AssetsManager.imagePath}/bag/wishlist.png",
          title: "Wishlist je prazna",
          subtitle: "Dodaj omiljene proizvode u wishlist.",
          buttonText: "Pogledaj proizvode",
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("${AssetsManager.imagePath}/bag/wishlist.png"),
        ),
        title: TitelesTextWidget(label: "Wishlist (${wishlistProducts.length})"),
        actions: [
          IconButton(
            onPressed: () => wishlistProvider.clearLocalWishlist(),
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: wishlistProducts.length,
        crossAxisCount: 2,
        builder: (context, index) {
          return ProductWidget(product: wishlistProducts[index]);
        },
      ),
    );
  }
}
