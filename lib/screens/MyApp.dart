import 'package:flutter/material.dart';
import 'package:multiple_flavor/config/flavor_config.dart';
import 'package:multiple_flavor/data_parsing/api_data_fetching.dart';
import 'package:multiple_flavor/widgets/side_bar_navigation.dart';

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            // themeMode: ThemeMode.system,
            themeMode: currentMode,
            title: FlavorConfig.instance.name,
            home: HomePage(),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NavigationDrawer()));
              },
              icon: Icon(Icons.menu)),
          title: Text(FlavorConfig.instance.name),
          actions: [
            IconButton(
                icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                })
          ]),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Flavor: ${FlavorConfig.instance.name}"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RestApiFetchExample()));
              },
              child: Text("Get Api")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp()));
              },
              child: Text("Notification")),
        ]),
      ),
    );
  }
}
