import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/models/product_model.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/providers/viewed_recently_provider.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/empty_bag.dart';
import 'package:projekatmobilne/widgets/products/product_widget.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = "/ViewedRecentlyScreen";
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    final viewedProducts = viewedProvider.getViewedProds.values
        .map((item) => productsProvider.findByProductId(item.productId))
        .whereType<ProductModel>()
        .toList();

    if (viewedProducts.isEmpty) {
      return const Scaffold(
        body: EmptyBagWidget(
          imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
          title: "Nema skoro pregledanih proizvoda",
          subtitle: "Proizvodi koje otvoriš pojaviće se ovde.",
          buttonText: "Pogledaj meni",
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("${AssetsManager.imagePath}/bag/checkout.png"),
        ),
        title: TitelesTextWidget(label: "Viewed recently (${viewedProducts.length})"),
      ),
      body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: viewedProducts.length,
        crossAxisCount: 2,
        builder: (context, index) {
          return ProductWidget(product: viewedProducts[index]);
        },
      ),
    );
  }
}
