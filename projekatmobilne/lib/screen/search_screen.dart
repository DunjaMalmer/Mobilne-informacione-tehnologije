import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const List<String> _filters = [
    'Torte',
    'Kolaci',
    'Makaronsi',
    'Bez secera',
  ];

  static const List<Map<String, String>> _results = [
    {'name': 'Red velvet mini', 'category': 'Torte', 'price': '550 RSD'},
    {'name': 'Vanila tart', 'category': 'Kolaci', 'price': '320 RSD'},
    {'name': 'Lemon makaronsi', 'category': 'Makaronsi', 'price': '690 RSD'},
    {'name': 'Cheesecake mini', 'category': 'Deserti', 'price': '480 RSD'},
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
              hintText: 'Pretrazi proizvode u Sweet Haven',
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
                backgroundColor: scheme.surfaceContainerHighest,
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
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(
                    Icons.bakery_dining_outlined,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                title: Text(
                  item['name']!,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(item['category']!),
                trailing: Text(
                  item['price']!,
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
