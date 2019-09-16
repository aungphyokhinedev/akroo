import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {

  static const List<Color> defaultColors = [
    Colors.blueGrey,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
  ];

  static Map<int, Color> _colors = Map();

  static Map<int, Color> get colors {
    if (_colors.isNotEmpty) {
      return _colors;
    }

    defaultColors.forEach((color)  {
        _colors[color.value] = color;
    });
    return _colors;
  }

  static Color getColorFrom({int id}) {
    return colors.containsKey(id) ? colors[id] : defaultColors[0];
  }
}

class ColorTransition {
  List<Color> colors;
  double offset;
  double maxExtent;

  Color blendedColor;

  ColorTransition({
    this.colors,
    this.offset,
    this.maxExtent,
  }) {
    double period = maxExtent / (colors.length - 1);

    /// limit index to positive integers
    int index = max(0, (offset / period).floor());

    Color firstColor = colors[index];

    /// this stops us from trying to blend a null secondColor
    /// when we're at the end of the list
    if (index != colors.length - 1) {
      Color secondColor = colors[index + 1];

      /// limit offset to within the bounds,
      /// this is to help with iOS overshooting scroll bounds
      double blend = (min(max(0.0, offset), maxExtent) % period) / period;

      this.blendedColor = Color.lerp(firstColor, secondColor, blend);
    } else {
      /// we're at the end of the list, so there's nothing to interpolate towards
      this.blendedColor = firstColor;
    }
  }
}

class DoubleColor {
  double number;
  Color color;

  DoubleColor(this.number, this.color);
}