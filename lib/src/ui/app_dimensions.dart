import 'package:flutter/widgets.dart';

class AppDimensions {

  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static const horizontalPadding8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const horizontalPadding24 = EdgeInsets.symmetric(horizontal: 24.0);

  static const verticalPadding8 = EdgeInsets.symmetric(vertical: 8.0);
  static const verticalPadding16 = EdgeInsets.symmetric(vertical: 16.0);
  static const verticalPadding24 = EdgeInsets.symmetric(vertical: 24.0);

  static final borderRadius4 = BorderRadius.circular(4.0);
  static final borderRadius16 = BorderRadius.circular(16.0);
}