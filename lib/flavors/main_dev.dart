import 'package:flutter/material.dart';
import 'package:multiple_flavor/screens/MyApp.dart';

import '../config/flavor_config.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(baseUrl: ""));
  runApp(MyApp());
}
