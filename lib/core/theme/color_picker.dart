import 'dart:math';

import 'package:flutter/animation.dart';

class ColorPicker {
  final List<int> _colors = [
    // Shades of blue
    0xFF00FFFF, // Aqua
    0xFF89CFF0, // Baby Blue
    0xFF0000FF, // Blue
    0xFF7393B3, // Blue Gray
    0xFF088F8F, // Blue Green
    0xFF0096FF, // Bright Blue
    0xFF1434A4, // Egyptian Blue
    0xFF00A36C, // Jade
    0xFF5D3FD3, // Iris
    0xFF191970, // Midnight Blue
    0xFFCCCCFF, // Periwinkle
    0xFF96DED1, // Robin Egg Blue
    0xFF9FE2BF, // Seafoam Blue
    0xFF008080, // Teal

    // Shades of brown
    0xFFE1C16E, // Brass
    0xFFCD7F32, // Bronze
    0xFFDAA06D, // Buff
    0xFF800020, // Burgundy
    0xFFE97451, // Burnt Sienna
    0xFF6E260E, // Burnt Umber
    0xFF7B3F00, // Chocolate
    0xFF6F4E37, // Coffee
    0xFF8B0000, // Dark Red
    0xFFE5AA70, // Fawn
    0xFFF0E68C, // Khaki
    0xFFC04000, // Mahogany
    0xFF800000, // Maroon

    // Shades of green
    0xFFAFE1AF, // Celadon
    0xFF50C878, // Emerald green
    0xFF228B22, // Forest green
    0xFF32CD32, // Lime green
    0xFF478778, // Lincoln green
    0xFF93C572, // Pistachio

    // Shades of orange
    0xFFFFBF00, // Amber
    0xFFFFAC1C, // Bright orange
    0xFFF88379, // Coral pink
    0xFFFF7F50, // Coral
    0xFFE49B0F, // Gamboge
    0xFFF4BB44, // Mango
    0xFFFF5F1F, // Neon orange
    0xFFEC5800, // Persimmon
    0xFFFA8072, // Salmon

    // Shades of pink
    0xFF9F2B68, // Amaranth
    0xFFDE3163, // Cerise
    0xFFAA336A, // Dark pink
    0xFFFF69B4, // Hot pink
    0xFF770737, // Mulberry
    0xFFDA70D6, // Orchid
    0xFF800080, // Purple
    0xFFE30B5C, // Raspberry
    0xFFF33A6A, // Rose
    0xFFD8BFD8, // Thistle

    // Shades of purple
    0xFFCF9FFF, // Light violet
    0xFF51414F, // Quartz
    0xFF7F00FF, // Violet

    // Shades of yellow
    0xFFFFEA00, // Bright yellow
    0xFFFDDA0D, // Cadmium yellow
    0xFFFAD5A5, // Desert
    0xFFFFD700, // Gold
    0xFFFADA5E, // Navel yellow
  ];

  List<int> get colors => _colors;

  int getRandomHexColor() {
    return _colors[Random().nextInt(_colors.length)];
  }

  Color getRandomColor() {
    return Color(getRandomHexColor());
  }
}
