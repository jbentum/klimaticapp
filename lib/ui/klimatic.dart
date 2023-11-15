import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'util/utils.dart' as util;
import 'dart:async';

class Klimatic extends StatefulWidget {
  const Klimatic({super.key});

  @override
  State<Klimatic> createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  void showStuff() async {
    Map data = await getWeather(util.appId, util.defaultCity);
    debugPrint(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: showStuff,
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'images/umbrella.png',
              width: 490.0,
              height: 1200,
              fit: BoxFit.fill,
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text(
              'Spokane',
              style: cityStyle(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          //Container which will have our weather data
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290, 0.0, 0.0),
            child: Text(
              '67.8F',
              style: tempStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid='
        '${util.appId}&units=imperial';

    // Convert the String URL to a Uri object
    Uri uri = Uri.parse(apiUrl);

    http.Response response = await http.get(uri);

    return jsonDecode(response.body);
  }
}

TextStyle cityStyle() {
  return const TextStyle(
      color: Colors.white, fontSize: 22.9, fontStyle: FontStyle.italic);
}

TextStyle tempStyle() {
  return const TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 49.9);
}
