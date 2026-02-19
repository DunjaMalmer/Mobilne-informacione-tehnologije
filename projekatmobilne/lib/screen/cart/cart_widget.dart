import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:projekatmobilne/consts/app_colors.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/screen/cart/quantity_btm_sheet.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  "${AssetsManager.imagePath}/cokomalina.jpg",
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 10),

              /// DETAILS
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: TitelesTextWidget(
                            label: "Čoko malina torta",
                            maxLines: 2,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.darkPrimary,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                IconlyLight.heart,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        const SubtitleTextWidget(
                          label: "2400 RSD",
                          color: AppColors.darkPrimary,
                        ),
                        const Spacer(),

                        OutlinedButton.icon(
                          onPressed: () async {
                            await showModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return const QuantityBottomSheetWidget();
                              },
                            );
                          },
                          icon: const Icon(IconlyLight.arrowDown2),
                          label: const Text("Qty: 5"),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
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
      ),
    );
  }
}
