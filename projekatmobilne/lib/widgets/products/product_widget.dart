import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:projekatmobilne/consts/app_colors.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          log("Navigate to product details");
        },
        child: Column(
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                "${AssetsManager.imagePath}/cokomalina.jpg",
                height: size.height * 0.22,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12.0),

            /// TITLE + HEART
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: TitelesTextWidget(
                      label: "Čoko malina torta",
                      fontSize: 18,
                      maxLines: 2,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(IconlyLight.heart),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6.0),

            /// PRICE + CART
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: SubtitleTextWidget(
                      label: "2400 RSD",
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkPrimary,
                    ),
                  ),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColors.lightPrimary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {},
                        splashColor: Colors.blueGrey,
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(Icons.add_shopping_cart_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
