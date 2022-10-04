import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiFetchExample extends StatefulWidget {
  const RestApiFetchExample({Key? key}) : super(key: key);

  @override
  _RestApiFetchExampleState createState() => _RestApiFetchExampleState();
}

class _RestApiFetchExampleState extends State<RestApiFetchExample> {
  late TextEditingController _urlController;
  late TextEditingController _apiTokenController;
  String _responseBody = '[ empty ]';
  String _error = '[ none ]';
  bool _pending = false;

  @override
  void initState() {
    super.initState();
    _apiTokenController = TextEditingController();
    _urlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Screen")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'URL to GET',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _apiTokenController,
            decoration: const InputDecoration(
              labelText: 'Optional api token',
              border: OutlineInputBorder(),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed: _pending
                    ? null
                    : () =>
                        _httpGet(_urlController.text, _apiTokenController.text),
                child: const Text('Get Data'),
              ),
              ElevatedButton(
                onPressed: _reset,
                child: const Text('Reset Data'),
              ),
            ],
          ),
          Text('Response body=$_responseBody'),
          const Divider(),
          Text('Error=$_error'),
        ],
      ),
    );
  }

  void _reset({bool resetControllers = true}) {
    setState(() {
      if (resetControllers) {
        _urlController.text = '';
      }
      _responseBody = '[ empty ]';
      _error = '[ none ]';
      _pending = false;
    });
  }

  // Using the http package we can easily GET data from REST APIs.
  Future<void> _httpGet(String url, String apiToken) async {
    setState(() => _pending = true);
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: apiToken},
      );
      // use compute() function (from flutter/foundation.dart) to run
      // heavy json parsing work in a background isolate.
      final parsed = await compute(jsonDecode, response.body);
      print('parsed json object=$parsed');
      setState(() => _responseBody = response.body);
    } catch (e) {
      setState(() => _error = e.toString());
    }
    setState(() => _pending = false);
  }
}
