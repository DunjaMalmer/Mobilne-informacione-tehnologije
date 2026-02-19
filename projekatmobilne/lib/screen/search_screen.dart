import 'package:flutter/material.dart';
import 'package:projekatmobilne/screen/inner_screen/product_details.dart';
import 'package:projekatmobilne/services/assets_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const List<String> _filters = [
    'Torte',
    'Kolači',
    'Makaronsi',
    'Bez sećera',
  ];

  static const List<Map<String, dynamic>> _results = [
    {
      'name': 'Čoko malina torta',
      'category': 'Torte',
      'priceRsd': 2400,
      'imagePath': '${AssetsManager.imagePath}/cokomalina.jpg',
      'description': 'Čokoladna baza i lagani fil od maline.',
    },
    {
      'name': 'Pistać makaronsi',
      'category': 'Makaronsi',
      'priceRsd': 690,
      'imagePath': '${AssetsManager.imagePath}/pistaci.jpg',
      'description': 'Kremasti pistać fil i hrskava korica.',
    },
    {
      'name': 'Mini cheesecake',
      'category': 'Deserti',
      'priceRsd': 480,
      'imagePath': '${AssetsManager.imagePath}/mini.jpg',
      'description': 'Lagani mini cheesecake za brzo i slatko uživanje.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pretraga'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Pretraži proizvode u Sweet Haven',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _filters.map((filter) {
              return Chip(
                label: Text(filter),
                backgroundColor: scheme.surfaceVariant,
                side: BorderSide.none,
              );
            }).toList(),
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
          ..._results.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(
                        name: item['name'] as String,
                        priceRsd: item['priceRsd'] as int,
                        imagePath: item['imagePath'] as String,
                        description: item['description'] as String,
                        category: item['category'] as String,
                      ),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item['imagePath'] as String,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(item['category'] as String),
                trailing: Text(
                  "${item['priceRsd']} RSD",
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
