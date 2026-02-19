import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/theme_provider.dart';
import 'package:projekatmobilne/screen/inner_screen/product_details.dart';
import 'package:projekatmobilne/services/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> _categories = [
    {'title': 'Torte'},
    {'title': 'Kolači'},
    {'title': 'Makaronsi'},
    {'title': 'Bez šećera'},
  ];

  static const List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'Čoko malina torta',
      'priceRsd': 2400,
      'category': 'Torte',
      'imagePath': '${AssetsManager.imagePath}/cokomalina.jpg',
      'description': 'Čokoladna baza i lagani fil od maline.',
    },
    {
      'name': 'Pistać makaronsi',
      'priceRsd': 690,
      'category': 'Makaronsi',
      'imagePath': '${AssetsManager.imagePath}/pistaci.jpg',
      'description': 'Kremasti pistać fil i hrskava korica.',
    },
    {
      'name': 'Mini cheesecake',
      'priceRsd': 480,
      'category': 'Deserti',
      'imagePath': '${AssetsManager.imagePath}/mini.jpg',
      'description': 'Lagani mini cheesecake za brzo slatko uživanje.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('Sweet Haven'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          scheme.primaryContainer,
                          scheme.secondaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dnevna ponuda',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '10% popusta na voćne torte',
                                style: TextStyle(
                                  color: scheme.onPrimaryContainer,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            '${AssetsManager.imagePath}/vocna.jpg',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Kategorije',
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _categories.map((item) {
                      return Chip(
                        label: Text(item['title']!),
                        backgroundColor: scheme.surfaceVariant,
                        side: BorderSide.none,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Najpopularnije',
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _popularItems[index];
                return ListTile(
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  subtitle: Text(
                      item['name'] == 'Čoko malina torta'
                      ? 'Bogata čokolada i sveža malina'
                     : item['name'] == 'Pistać makaronsi'
                     ? 'Omiljeni izbor kupaca'
                    : item['name'] == 'Mini cheesecake'
                    ? 'Lagan i osvežavajući dezert'
                    : '',
),

                  trailing: Text(
                    "${item['priceRsd']} RSD",
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
              childCount: _popularItems.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              title: Text(
                themeProvider.getIsDarkTheme ? 'Tamna tema' : 'Svetla tema',
              ),
              subtitle: const Text('Promeni izgled aplikacije'),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
