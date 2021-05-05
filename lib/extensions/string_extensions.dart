import 'dart:ui';

import 'package:flutter/cupertino.dart';

extension ColorExtension on String? {
  Color get hexToColor {
    var hexColor = this;
    hexColor ??= '#FFFFFF';
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension IconExtension on String {
  IconData get iconData {
    var strIcon = this;
    switch (strIcon) {
      case 'shopping_cart': return CupertinoIcons.shopping_cart;
      case 'star': return CupertinoIcons.star;
      case 'heart': return CupertinoIcons.heart;
      case 'exclamationmark_triangle': return CupertinoIcons.exclamationmark_triangle;
      case 'clock': return CupertinoIcons.clock;
    }
    return CupertinoIcons.chat_bubble;
  }
}