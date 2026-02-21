import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/theme_provider.dart';
import 'package:projekatmobilne/services/assets_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final scheme = Theme.of(context).colorScheme;

    void onStubTap(String label) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label uskoro dostupno')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(AssetsManager.logo, fit: BoxFit.contain),
        ),
        title: const Text("Moj profil"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withOpacity(0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: scheme.primaryContainer,
                    backgroundImage: const NetworkImage(
                      "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dunja Malmer",
                          style: TextStyle(
                            color: scheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "dunjamalmer@gmail.com",
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sweet Haven Club član",
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Nalozi i porudžbine",
              style: TextStyle(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            _ProfileActionTile(
              imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
              title: "Moje porudžbine",
              onTap: () => onStubTap("Moje porudžbine"),
            ),
            _ProfileActionTile(
              imagePath: "${AssetsManager.imagePath}/bag/wishlist.png",
              title: "Lista želja",
              onTap: () => onStubTap("Lista zelja"),
            ),
            _ProfileActionTile(
              imagePath: "${AssetsManager.imagePath}/profile/repeat.png",
              title: "Skoro gledano",
              onTap: () => onStubTap("Skoro gledano"),
            ),
            _ProfileActionTile(
              imagePath: "${AssetsManager.imagePath}/address.png",
              title: "Adresa dostave",
              onTap: () => onStubTap("Adresa dostave"),
            ),
            const SizedBox(height: 16),
            Text(
              "Podešavanja",
              style: TextStyle(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Image.asset(
                "${AssetsManager.imagePath}/profile/night-mode.png",
                height: 32,
              ),
              title: Text(
                themeProvider.getIsDarkTheme ? "Tamna tema" : "Svetla tema",
              ),
              subtitle: const Text("Promeni izgled aplikacije"),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => onStubTap("Prijava"),
                icon: const Icon(Icons.login_rounded),
                label: const Text("Prijavi se"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(imagePath, height: 30),
      title: Text(title),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
