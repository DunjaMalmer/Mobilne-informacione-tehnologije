import 'package:flutter/material.dart';
import 'package:projekatmobilne/consts/app_colors.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/screen/inner_screen/product_details.dart';
import 'package:projekatmobilne/widgets/products/heart_btn.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routName);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    "${AssetsManager.imagePath}/coko.jpg",
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              /// DETAILS
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),

                    const Text(
                      "Čoko malina torta",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    FittedBox(
                      child: Row(
                        children: [
                          const HeartButtonWidget(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    const FittedBox(
                      child: SubtitleTextWidget(
                        label: "2400 RSD",
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
