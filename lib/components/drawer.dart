import 'package:flutter/material.dart';
import 'package:note/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(Icons.note),
          ),
          // notes tile
          DrawerTile(
            title: 'Notes',
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),

          // setting tile
          DrawerTile(
            title: 'Settings',
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/settingsPage');
            },
          ),
        ],
      ),
    );
  }
}
