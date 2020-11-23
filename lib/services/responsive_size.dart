import 'package:flutter/material.dart';

class ResponsiveSize {
  static double _width = 375;
  static double _height = 812;
  static void init({@required double height, @required double width}) {
    _width = width;
    _height = height;
  }

  static double width(num value) {
    return value * (_width / 375.0);
  }

  static double height(num value) {
    return value * (_height / 812.0);
  }
}

extension ResponsiveOnNum on num {
  num get width => ResponsiveSize.width(this);
  num get height => ResponsiveSize.height(this);
}
