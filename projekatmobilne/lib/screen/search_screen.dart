import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/screen/inner_screen/product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  bool _isNetworkImage(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final productsProvider = Provider.of<ProductsProvider>(context);

    final allProducts = productsProvider.getProducts;
    final searchText = _searchTextController.text.trim();
    final shownProducts = searchText.isEmpty
        ? allProducts
        : productsProvider.searchQuery(
            searchText: searchText,
            passedList: allProducts,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pretraga'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "OVO JE SEARCH",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchTextController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'Pretrazi proizvode u Sweet Haven',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Predlozi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          if (shownProducts.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: Text("No products found")),
            )
          else
            ...shownProducts.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                          name: item.productTitle,
                          priceRsd: item.productPrice,
                          imagePath: item.productImage,
                          description: item.productDescription,
                          category: item.productCategory,
                        ),
                      ),
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _isNetworkImage(item.productImage)
                        ? Image.network(
                            item.productImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            item.productImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: Text(
                    item.productTitle,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(item.productCategory),
                  trailing: Text(
                    "${item.productPrice.toStringAsFixed(0)} RSD",
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
