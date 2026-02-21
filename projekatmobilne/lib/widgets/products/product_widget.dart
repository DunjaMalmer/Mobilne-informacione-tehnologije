import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:projekatmobilne/models/product_model.dart';
import 'package:projekatmobilne/consts/app_colors.dart';
//import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          log("Navigate to product details: ${product.productTitle}");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                product.productImage,
                height: size.height * 0.22,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 12.0),

        
            Row(
              children: [
                Expanded(
                  child: TitelesTextWidget(
                    label: product.productTitle,
                    fontSize: 18,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconlyLight.heart),
                ),
              ],
            ),

            const SizedBox(height: 6.0),

        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleTextWidget(
                  label: "${product.productPrice} RSD",
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkPrimary,
                ),
                Material(
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
              ],
            ),

            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
