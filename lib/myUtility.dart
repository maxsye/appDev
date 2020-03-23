import 'dart:io';

import 'package:flutter/material.dart';

double screenWidth;
double screenHeight;

class MyUtility {
  BuildContext context;

  MyUtility(this.context) : assert(context != null);

  double get screenHeight => Platform.isIOS
      ? MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom -
          kToolbarHeight
      : (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight) * 0.93;

  double get screenWidth => Platform.isIOS
      ? MediaQuery.of(context).size.width -
          MediaQuery.of(context).padding.left -
          MediaQuery.of(context).padding.right
      : (MediaQuery.of(context).size.width -
              MediaQuery.of(context).padding.left -
              MediaQuery.of(context).padding.right) *
          1;
}
