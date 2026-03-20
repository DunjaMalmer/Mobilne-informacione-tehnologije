import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/screen/cart/cart_screen.dart';
import 'package:projekatmobilne/screen/home_screen.dart';
import 'package:projekatmobilne/screen/profile_screen.dart';
import 'package:projekatmobilne/screen/search_screen.dart';

class RootScreen extends StatefulWidget {
  static const String routeName = "/RootScreen";
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final List<Widget> screens;
  int currentScreen = 0;
  late final PageController controller;
  bool isLoadingProd = true;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    try {
      await productsProvider.fetchProducts();
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchFCT();
      isLoadingProd = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentScreen = index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        height: 72,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.animateToPage(
            currentScreen,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: "Početna",
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: "Pretraga",
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.bag2),
            icon: Icon(IconlyLight.bag2),
            label: "Korpa",
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
