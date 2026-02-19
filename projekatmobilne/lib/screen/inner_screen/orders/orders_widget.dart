import 'package:flutter/material.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "${AssetsManager.imagePath}/cokomalina.jpg",
              height: size.width * 0.25,
              width: size.width * 0.25,
              fit: BoxFit.cover,
            ),
          ),

          /// DETAILS
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: TitelesTextWidget(
                          label: 'Čoko malina torta',
                          maxLines: 2,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  const Row(
                    children: [
                      TitelesTextWidget(
                        label: 'Price: ',
                        fontSize: 15,
                      ),
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "2400 RSD",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  const SubtitleTextWidget(
                    label: "Qty: 1",
                    fontSize: 15,
                  ),

                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
