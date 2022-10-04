import 'package:flutter/material.dart';
import 'package:multiple_flavor/config/flavor_config.dart';
import 'package:multiple_flavor/screens/MyApp.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.QA,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(baseUrl: ""));
  runApp(MyApp());
}
