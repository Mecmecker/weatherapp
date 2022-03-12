import 'package:flutter/material.dart';

class LayerProvider extends ChangeNotifier {
  int _layerPos = 0;

  int get layerPos => _layerPos;

  set layerPos(int pos) {
    _layerPos = pos;
    notifyListeners();
  }
}
