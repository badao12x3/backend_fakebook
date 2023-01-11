import 'package:fakebook_frontend/screens/menu/sub_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:fakebook_frontend/screens/menu/widgets/menu_widgets.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey[100],
          automaticallyImplyLeading: false,
          title: const Text(
            'Menu',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          floating: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            CircleButton(
                icon: Icons.search,
                iconSize: 30.0,
                onPressed: () => print('Search')),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.grey[200],
            child: Column(
              children: [
                TextButton(
                  onPressed: () => print('See profile'),
                  child: Row(
                    children: [
                      ProfileAvatar(imageUrl: currentUser.imageUrl),
                      const SizedBox(width: 12.0),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentUser.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black)),
                          const Text(
                            'See your profile',
                            style: TextStyle(color: Palette.facebookBlue),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Divider(height: 10.0, thickness: 2),
                ExpansionTile(
                  title: const Text('Help & Support',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  leading:
                      const Icon(Icons.help, size: 35.0, color: Colors.black),
                  children: [
                    ActionButton(
                        icon: Icons.policy,
                        buttonText: 'Terms & Policies',
                        onPressed: () => print('object')),
                    const SizedBox(height: 8.0),
                    // _ActionButton(
                    //     icon: Icons.help_center, buttonText: 'Help Center'),
                    // SizedBox(height: 8.0),
                  ],
                ),
                // const Divider(height: 10.0, thickness: 2),
                ExpansionTile(
                  title: const Text('Settings & Privacy',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  leading: const Icon(Icons.settings,
                      size: 35.0, color: Colors.black),
                  children: [
                    ActionButton(
                      icon: Icons.admin_panel_settings,
                      buttonText: 'Settings',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()));
                      },
                    ),
                    const SizedBox(height: 8.0),
                    ActionButton(
                      icon: Icons.lock_person_sharp,
                      buttonText: 'Privacy',
                      onPressed: () => print('object'),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
                // const Divider(height: 10.0, thickness: 2),
                ExpansionTile(
                  title: const Text('Log out',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  leading:
                      const Icon(Icons.close, size: 35.0, color: Colors.black),
                  children: [
                    ActionButton(
                      icon: Icons.logout,
                      buttonText: 'Log out',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 8.0),
                    ActionButton(
                      icon: Icons.exit_to_app,
                      buttonText: 'Close app',
                      onPressed: () => print('Close app'),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
                // ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
