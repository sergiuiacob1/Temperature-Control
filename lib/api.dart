import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Api {
  static final getRequest =
      'https://api.thingspeak.com/channels/596590/feeds.json?results=1';
  Api();

  static Future<List> getRoomInfo() async {
    double _currentTemp, _targetTemp, _humidity;
    dynamic jsonObject;

    final response = await http.get(getRequest);
    if (response.statusCode == 200) {
    } else
      throw Exception('Failed to retrieve temperatures!');

    jsonObject = json.decode(response.body);
    try {
      _humidity = double.parse(jsonObject["feeds"][0]["field1"]);
      _currentTemp = double.parse(jsonObject["feeds"][0]["field2"]);
      _targetTemp = double.parse(jsonObject["feeds"][0]["field3"]);
    } catch (e) {
      print('Failed to parse temperatures from json!');
      print(e.toString());
    }
    return [_humidity, _currentTemp, _targetTemp];
  }

  static Future<void> postTargetTemp(double temp) async {
    List list;
    double _currentTemp, _humidity;
    list = await getRoomInfo();
    _humidity = list[0];
    _currentTemp = list[1];
    final String postRequest =
        'http://api.thingspeak.com/update?api_key=6OURMUW6NIIMYABB&field1=$_humidity&field2=$_currentTemp&field3=$temp';

    final response = await http.get(postRequest);
    if (response.statusCode == 200) {
    } else
      throw Exception('Failed to post targetTemp!');
  }
}
