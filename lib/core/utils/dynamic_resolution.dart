import 'package:flutter/material.dart';

class DynamicResolution {
  static bool isMobile(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    return useMobileLayout;
  }

  static double getUnitMetric(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    unitHeightValue = (unitHeightValue < 1) ? 1 : unitHeightValue;
    return isMobile(context) ? unitHeightValue : unitHeightValue * 1.3;
  }
}
