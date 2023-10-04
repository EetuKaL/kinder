import 'package:flutter/material.dart';

class AppScale {
  BuildContext _ctxt;

  AppScale(this._ctxt);

  double get cardWidth => scaledWidth(0.9);
  double get cardHeight => scaledHeight(.7);
  double get cardImageHeight => scaledHeight(.7);
  double get cardImageWidht => scaledWidth(.8);

  double scaledWidth(double widthScale) {
    return MediaQuery.of(_ctxt).size.width * widthScale;
  }

  double scaledHeight(double heightScale) {
    return MediaQuery.of(_ctxt).size.height * heightScale;
  }
}
