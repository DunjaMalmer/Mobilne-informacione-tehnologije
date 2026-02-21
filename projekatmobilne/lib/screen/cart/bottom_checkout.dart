import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/consts/app_colors.dart';
import 'package:projekatmobilne/providers/cart_provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitelesTextWidget(
                            label:
                                "Total (${cartProvider.getCartitems.length} products/${cartProvider.getQty()} items)")),
                    SubtitleTextWidget(
                      label:
                          "${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)} RSD",
                      color: AppColors.darkPrimary,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}