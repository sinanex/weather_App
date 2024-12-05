import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListTile(
                trailing: Consumer<themeChangeProvider>(
                    builder: (context, theme, child) => CupertinoSwitch(
                          value: theme.Dark,
                          onChanged: (value) {
                            theme.changeTheme(value);
                          },
                        )),
                title: Text("Dark Theme")),
          ],
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
    );
  }
}
