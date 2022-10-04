// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationDrawer extends StatelessWidget {
  static const String title = 'Localication';
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1594361487118-f4e2b2288aea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dHVya2lzaCUyMGdpcmx8ZW58MHx8MHx8&w=1000&q=80"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                AppLocalizations.of(context)!.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text(
              AppLocalizations.of(context)!.home,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_outlined),
            title: Text(
              AppLocalizations.of(context)!.favourite,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_add_outlined),
            title: Text(
              AppLocalizations.of(context)!.bookmark,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(
              AppLocalizations.of(context)!.privacy,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text(
              AppLocalizations.of(context)!.logout,
            ),
            onTap: () {},
          ),
        ],
      );
}
