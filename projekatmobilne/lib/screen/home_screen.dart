import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekatmobilne/providers/theme_provider.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';

class HomeScreen extends StatelessWidget { //ne čuva stanje teme, već ga dobija iz ThemeProvider-a
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubtitleTextWidget(label: "Hello"),
          const TitelesTextWidget(label: "Hello this is me again"),
          SwitchListTile(
            title: Text(
                themeProvider.getIsDarkTheme ? "Dark Theme" : "Light Theme"),
            value: themeProvider.getIsDarkTheme,
            onChanged: (value) {
              themeProvider.setDarkTheme(themeValue: value); //menja temu
            },
          )
        ],
      ),
    ));
  }
}