import 'package:flutter/material.dart';
import 'dart:async';
import 'api.dart';
import 'temperature_control.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Caldurik',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Reglaj temperatura calorifer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TemperatureControl temperatureControl;
  String _currentTempString, _targetTempString, _humidityString;

  @override
  void initState() {
    super.initState();

    const updateInterval = const Duration(seconds: 1);
    temperatureControl = new TemperatureControl();
    _humidityString = "Se incarca...";
    _currentTempString = "Se incarca...";
    _targetTempString = "Se incarca...";

    new Timer.periodic(updateInterval, (Timer t) {
      updateTemps();
    });
  }

  Widget _createTextWidget(String text) {
    return new Text(
      text,
      style: new TextStyle(
        fontSize: 30.0,
      ),
    );
  }

  void updateTemps() async {
    double _currentTemp, _targetTemp, _humidity;
    List temps;
    try {
      temps = await Api.getRoomInfo();
      _humidity = temps[0];
      _currentTemp = temps[1];
      _targetTemp = temps[2];

      if (_currentTemp != null && _targetTemp != null)
        setState(() {
          _humidityString = "Umiditate: " + _humidity.toString();
          _currentTempString =
              "Temperatura camerei: " + _currentTemp.toString();
          _targetTempString = "Termostat setat la: " + _targetTemp.toString();
        });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _createTextWidget(_humidityString),
            _createTextWidget(_currentTempString),
            _createTextWidget(_targetTempString),
            Divider(
              height: 100.0,
              color: Colors.transparent,
            ),
            temperatureControl.body(),
          ],
        ),
      ),
    );
  }
}
