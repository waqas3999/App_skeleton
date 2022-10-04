import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
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
          children: const [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1594361487118-f4e2b2288aea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dHVya2lzaCUyMGdpcmx8ZW58MHx8MHx8&w=1000&q=80"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Random Girl for Sir Jhonny",
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
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_outlined),
            title: const Text("Favourite"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_add_outlined),
            title: const Text("Bookmarks"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text("Privacy"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text("Logout"),
            onTap: () {},
          ),
        ],
      );
}
