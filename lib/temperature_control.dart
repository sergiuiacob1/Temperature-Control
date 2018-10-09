import 'package:flutter/material.dart';
import 'api.dart';

class TemperatureControl {
  TemperatureControl();

  void _decreaseTemp() {}

  void _increaseTemp() {
    print('minus');
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new IconButton(
              iconSize: 20.0,
              icon: new Icon(Icons.remove_circle),
              tooltip: 'Minus 0,5 grade',
              onPressed: () => _decreaseTemp(),
            ),
            new IconButton(
              iconSize: 20.0,
              icon: new Icon(Icons.add_circle),
              tooltip: 'Plus 0,5 grade',
              onPressed: () => _increaseTemp(),
            ),
          ],
        ),
        _buildSetButton(),
      ],
    );
  }

  Widget _buildSetButton() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlatButton(
          splashColor: Colors.blue,
          child: const Text('Apasa pentru : ', style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            // Perform some action
          },
        ),
      ],
    );
  }
}
