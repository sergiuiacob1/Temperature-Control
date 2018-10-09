import 'package:flutter/material.dart';
import 'api.dart';

class TemperatureControl {
  double _userTargetTemp;

  TemperatureControl() {
    _userTargetTemp = -1.0;
    updateUserTargetTemp();
  }

  Future<void> updateUserTargetTemp() async {
    List list = await Api.getRoomInfo();
    _userTargetTemp = list[2];
  }

  void _setTargetTemp() {
    if (_userTargetTemp == -1.0) return;
    Api.postTargetTemp(_userTargetTemp);
  }

  void _decreaseTemp() {
    if (_userTargetTemp == null) return;
    _userTargetTemp -= 0.5;
  }

  void _increaseTemp() {
    if (_userTargetTemp == null) return;
    _userTargetTemp += 0.5;
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildIconButton(
                Icons.remove_circle_outline, 'Minus 0,5 grade', _decreaseTemp),
            _buildTextField(_userTargetTemp),
            _buildIconButton(
                Icons.add_circle_outline, 'Plus 0,5 grade', _increaseTemp),
          ],
        ),
        _buildSetButton(),
      ],
    );
  }

  Widget _buildTextField(double targetTemp) {
    return new Text(targetTemp.toString(), style: TextStyle(fontSize: 24.0));
  }

  Widget _buildIconButton(IconData icon, String text, Function function) {
    return new IconButton(
      iconSize: 100.0,
      icon: new Icon(icon),
      tooltip: text,
      onPressed: () => function(),
    );
  }

  Widget _buildSetButton() {
    return new RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: () => _setTargetTemp(),
      child: new Text(
        "Seteaza temperatura",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
