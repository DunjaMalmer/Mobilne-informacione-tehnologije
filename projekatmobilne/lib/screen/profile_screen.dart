import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/models/user_model.dart';
import 'package:projekatmobilne/providers/theme_provider.dart';
import 'package:projekatmobilne/providers/user_provider.dart';
import 'package:projekatmobilne/screen/auth/login.dart';
import 'package:projekatmobilne/screen/inner_screen/orders/orders_screen.dart';
import 'package:projekatmobilne/screen/inner_screen/viewed_recently.dart';
import 'package:projekatmobilne/screen/inner_screen/wishlist.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/services/my_app_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;
  bool _hasFetched = false;

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
      user = FirebaseAuth.instance.currentUser;
    } catch (error) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_hasFetched) {
      _hasFetched = true;
      fetchUserInfo();
    }
    super.didChangeDependencies();
  }

  ImageProvider _profileImage() {
    final image = userModel?.userImage ?? "";
    if (image.isEmpty) {
      return const AssetImage("${AssetsManager.imagePath}/profile/profil.png");
    }
    return NetworkImage(image);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
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
                          backgroundImage: _profileImage(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: userModel == null
                              ? Text(
                                  "Prijavite se kako biste imali neograničen pristup",
                                  style: TextStyle(color: scheme.onSurfaceVariant),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userModel!.userName,
                                      style: TextStyle(
                                        color: scheme.onSurface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      userModel!.userEmail,
                                      style: TextStyle(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Sweet Haven Club clan",
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
                    "Nalozi i porudzbine",
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: userModel != null,
                    child: _ProfileActionTile(
                      imagePath: "${AssetsManager.imagePath}/bag/checkout.png",
                      title: "Moje porudzbine",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrdersScreen()),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: userModel != null,
                    child: _ProfileActionTile(
                      imagePath: "${AssetsManager.imagePath}/bag/wishlist.png",
                      title: "Lista zelja",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WishlistScreen()),
                        );
                      },
                    ),
                  ),
                  _ProfileActionTile(
                    imagePath: "${AssetsManager.imagePath}/profile/repeat.png",
                    title: "Skoro gledano",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ViewedRecentlyScreen(),
                        ),
                      );
                    },
                  ),
                  _ProfileActionTile(
                    imagePath: "${AssetsManager.imagePath}/address.png",
                    title: "Adresa dostave",
                    onTap: () => onStubTap("Adresa dostave"),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Podesavanja",
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
                      onPressed: () async {
                        if (user == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                          return;
                        }

                        await MyAppFunctions.showErrorOrWarningDialog(
                          context: context,
                          subtitle: "Are you sure you want to signout?",
                          isError: false,
                          fct: () async {
                            await FirebaseAuth.instance.signOut();
                            if (!mounted) return;
                            setState(() {
                              user = null;
                              userModel = null;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        user == null ? Icons.login_rounded : Icons.logout_rounded,
                      ),
                      label: Text(user == null ? "Prijavi se" : "Odjavi se"),
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
