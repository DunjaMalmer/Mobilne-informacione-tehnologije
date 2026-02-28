import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/products_provider.dart';
import 'package:projekatmobilne/screen/admin/edit_product_screen.dart';
import 'package:projekatmobilne/screen/admin/add_product_screen.dart';


class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  static const String routeName = "/AdminDashboard";

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    final products = productsProvider.getProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin panel"),
        actions: [
          IconButton(
            tooltip: "Dodaj proizvod",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddProductScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text("Nema proizvoda za prikaz."),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.productImage,
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "${product.productPrice.toStringAsFixed(0)} RSD  |  ${product.productCategory}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: "Izmeni proizvod",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProductScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          tooltip: "Obriši proizvod",
                          onPressed: () async {
                            final shouldDelete =
                                await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Brisanje proizvoda"),
                                      content: Text(
                                        "Da li želiš da obrišeš '${product.productTitle}'?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },

                                          child: const Text("Ne"),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Da"),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;

                            if (!shouldDelete) return;
                            context
                                .read<ProductsProvider>()
                                .removeProductById(product.productId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Proizvod je obrisan."),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
