import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fakebook_frontend/constants/Palette.dart';
import 'package:fakebook_frontend/constants/localdata/LocalData.dart';
import 'package:fakebook_frontend/screens/menu/widgets/MenuWidgets.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.grey[100],
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
                                  const Text('See your profile', style: TextStyle(color: Palette.facebookBlue),),
                                ],
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Divider(height: 10.0, thickness: 2),
                    const ExpansionTile(
                      title: Text('Help & Support',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.help, size: 35.0, color: Colors.black),
                      children: [
                        _ActionButton(
                            icon: Icons.policy, buttonText: 'Terms & Policies'),
                        SizedBox(height: 8.0),
                        // _ActionButton(
                        //     icon: Icons.help_center, buttonText: 'Help Center'),
                        // SizedBox(height: 8.0),
                      ],
                    ),
                    // const Divider(height: 10.0, thickness: 2),
                    const ExpansionTile(
                      title: Text('Settings & Privacy',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      leading:
                      Icon(Icons.settings, size: 35.0, color: Colors.black),
                      children: [
                        _ActionButton(
                            icon: Icons.admin_panel_settings,
                            buttonText: 'Settings'),
                        SizedBox(height: 8.0),
                        _ActionButton(
                            icon: Icons.lock_person_sharp, buttonText: 'Privacy'),
                        SizedBox(height: 8.0),
                      ],
                    ),
                    // const Divider(height: 10.0, thickness: 2),
                    const ExpansionTile(
                      title: Text('Log out',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.close, size: 35.0, color: Colors.black),
                      children: [
                        _ActionButton(icon: Icons.logout, buttonText: 'Log out'),
                        SizedBox(height: 8.0),
                        _ActionButton(
                            icon: Icons.exit_to_app, buttonText: 'Close app'),
                        SizedBox(height: 8.0),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String buttonText;

  const _ActionButton({Key? key, required this.icon, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: Colors.grey[350],
          minimumSize: const Size(double.infinity, 50.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0))),
      onPressed: () => print(buttonText),
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: Text(
        buttonText,
        style: const TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
