import 'package:flutter/material.dart';
import 'dart:ui';

class BlurOvalWidget extends StatelessWidget {
  final Widget _widget;
  double _padding = 10;

  BlurOvalWidget(this._widget, {double padding = 0}) {
    if (padding != 0) this._padding = padding;
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50,
          sigmaY: 50,
        ),
        child: Container(
          // color: Colors.transparent,
          padding: EdgeInsets.all(_padding),
          // decoration: new BoxDecoration(
          // color: Colors.transparent,
          // boxShadow: [
          //   BoxShadow(color: Colors.grey, blurRadius: 20.0)],
          // ),
          child: _widget,
        ),
      ),
    );
  }
}

class BlurRectWidget extends StatelessWidget {
  final Widget _widget;
  double _padding = 10;

  BlurRectWidget(this._widget, {double padding = 0}) {
    if (padding != 0) this._padding = padding;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            color: Colors.white10,
            padding: EdgeInsets.all(_padding),
            child: _widget,
          ),
        ),
      ),
    );
  }
}
