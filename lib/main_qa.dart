import 'package:flutter/material.dart';
import 'package:multiple_flavor/MyApp.dart';
import 'package:multiple_flavor/config/flavor_config.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.QA,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(baseUrl: ""));
  runApp(MyApp());
}
