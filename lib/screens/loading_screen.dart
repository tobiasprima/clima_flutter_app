import 'package:flutter/material.dart';
import 'package:clima_flutter_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'baa92d57d2567d8c27162c96406667ca';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();

    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];

      int condition = decodedData['weather'][0]['id'];

      String city_name = decodedData(data)['name'];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
