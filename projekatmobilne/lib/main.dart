import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/consts/theme_data.dart';
import 'package:projekatmobilne/providers/cart_provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/providers/theme_provider.dart';
import 'package:projekatmobilne/providers/viewed_recently_provider.dart';
import 'package:projekatmobilne/providers/wishlist_provider.dart';
import 'package:projekatmobilne/screen/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Sweet Haven',
            theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme,
              context: context,
            ),
            home: const RootScreen(),
          );
        },
      ),
    );
  }
}
