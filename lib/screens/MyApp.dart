import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:multiple_flavor/api_data_fetching.dart';
import 'package:multiple_flavor/config/flavor_config.dart';
import 'package:multiple_flavor/l10n/l10n.dart';
import 'package:multiple_flavor/provider/locale_provider.dart';
import 'package:multiple_flavor/widgets/language_picker_widget.dart';
import 'package:multiple_flavor/widgets/side_bar_navigation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  static final String title = 'Localication';
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);

        return OverlaySupport.global(
          child: ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (_, ThemeMode currentMode, __) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  darkTheme: ThemeData.dark(),
                  // themeMode: ThemeMode.system,
                  themeMode: currentMode,
                  title: FlavorConfig.instance.name,
                  locale: provider.locale,
                  supportedLocales: L10n.all,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: HomePage(),
                );
              }),
        );
      });
}

class HomePage extends StatelessWidget {
  bool hasConnection = false;
  ConnectivityResult _result = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home),
          NavigationDestination(
              icon: Icon(Icons.add_box_outlined),
              label: AppLocalizations.of(context)!.add),
          NavigationDestination(
              icon: Icon(Icons.add_a_photo_outlined),
              label: AppLocalizations.of(context)!.photo),
          NavigationDestination(
              icon: Icon(Icons.add_location_alt_outlined),
              label: AppLocalizations.of(context)!.location)
        ],
      ),
      appBar: AppBar(title: Text(FlavorConfig.instance.name), actions: [
        LanguagePickerWidget(),
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
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          Text("Flavor: ${FlavorConfig.instance.name}"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestApiFetchExample()),
                  );
                },
                child: Text(AppLocalizations.of(context)!.open)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: getConnectionNetworkReport,
                child: Text(
                  AppLocalizations.of(context)!.checknetwork,
                )),
          ),
        ],
      ),
    );
  }

/* 
   First you have to put 3 dependencies in your pubspec.yaml.
   Just run these commands in your terminal to get dependencies.

   1) flutter pub add internet_connection_checker
   2) flutter pub add overlay_support
   3) flutter pub add connectivity_plus
*/

  getConnectionNetworkReport() async {
    hasConnection = await InternetConnectionChecker().hasConnection;

    _result = await Connectivity().checkConnectivity();

    final color = hasConnection ? Colors.green : Colors.red;
    final text = hasConnection ? 'Internet Available' : 'No Internet';

    if (_result == ConnectivityResult.mobile) {
      showSimpleNotification(
          Text(
            "$text: Mobile Internet",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          background: color);
    } else if (_result == ConnectivityResult.wifi) {
      showSimpleNotification(
          Text(
            "$text: Wifi Internet",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          background: color);
    } else {
      showSimpleNotification(
          Text(
            "$text: No Internet",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          background: color);
    }
  }

  void clickedApi() {}
}
