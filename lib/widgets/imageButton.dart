import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimpleImageButton extends StatefulWidget {
  final String normalImage;
  final String pressedImage;
  final void Function()? onPressed;
  // final double width;
  final String title;

  const SimpleImageButton({
    required Key key,
    required this.normalImage,
    required this.pressedImage,
    required this.onPressed,
    // required this.width,
    this.title = '',
  });

  @override
  State<StatefulWidget> createState() {
    return _SimpleImageButtonState();
  }
}

class _SimpleImageButtonState extends State<SimpleImageButton> {
  @override
  Widget build(BuildContext context) {
    return ImageButton(
      normalImage: Image(
        image: AssetImage(widget.normalImage),
        // width: widget.width,
        // height: widget.width,
      ),
      pressedImage: Image(
        image: AssetImage(widget.pressedImage),
        // width: widget.width,
        // height: widget.width,
      ),
      title: widget.title,
      normalStyle: TextStyle(
          color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
      pressedStyle: TextStyle(
          color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
      onPressed: widget.onPressed,
      key: UniqueKey(),
    );
  }
}

class ImageButton extends StatefulWidget {
  final Image normalImage;
  final Image pressedImage;
  final String title;
  final TextStyle normalStyle;
  final TextStyle pressedStyle;
  final void Function()? onPressed;
  final double padding;

  ImageButton({
    required Key key,
    required this.normalImage,
    required this.pressedImage,
    required this.onPressed,
    required this.title,
    this.normalStyle = const TextStyle(),
    this.pressedStyle = const TextStyle(),
    this.padding = 5,
  }) : super(key: key);

  @override
  _ImageButtonState createState() {
    return _ImageButtonState();
  }
}

class _ImageButtonState extends State<ImageButton> {
  var isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isPressed ? widget.pressedImage : widget.normalImage,
          widget.title.isNotEmpty
              ? Padding(padding: EdgeInsets.fromLTRB(0, widget.padding, 0, 0))
              : Container(),
          widget.title.isNotEmpty
              ? Text(
                  widget.title,
                  style: isPressed ? widget.pressedStyle : widget.normalStyle,
                )
              : Container(),
        ],
      ),
      onTap: widget.onPressed,
      onTapDown: (d) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (d) {
        setState(() {
          isPressed = false;
        });
      },
    );
  }
}

class ExpandedImageButton extends StatefulWidget {
  final Image normalImage;
  final Image pressedImage;
  final String title;
  final TextStyle normalStyle;
  final TextStyle pressedStyle;
  final void Function()? onPressed;
  final double padding;
  // final double width;
  // final double height;
  final BoxDecoration decoration;

  ExpandedImageButton(
      {required Key key,
      required this.normalImage,
      required this.pressedImage,
      required this.onPressed,
      required this.title,
      // required this.width,
      // required this.height,
      this.normalStyle = const TextStyle(),
      this.pressedStyle = const TextStyle(),
      this.padding = 5,
      this.decoration = const BoxDecoration()})
      : super(key: key);

  @override
  _ExpandedImageButtonState createState() {
    return _ExpandedImageButtonState();
  }
}

class _ExpandedImageButtonState extends State<ExpandedImageButton> {
  var isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isPressed ? widget.pressedImage : widget.normalImage,
          widget.title != ''
              ? Padding(padding: EdgeInsets.fromLTRB(0, widget.padding, 0, 0))
              : Container(),
          widget.title != ''
              ? Container(
                  decoration: widget.decoration,
                  alignment: Alignment.center,
                  // width: widget.width,
                  // height: widget.height,
                  child: Text(
                    widget.title,
                    style: isPressed ? widget.pressedStyle : widget.normalStyle,
                  ),
                )
              : Container(),
        ],
      ),
      onTap: widget.onPressed,
      onTapDown: (d) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (d) {
        setState(() {
          isPressed = false;
        });
      },
    );
  }
}

class SvgButton extends StatefulWidget {
  final SvgPicture normalSvg;
  final SvgPicture pressedSvg;
  final String? title;
  final TextStyle? normalStyle;
  final TextStyle? pressedStyle;
  final void Function()? onPressed;
  final double padding;

  SvgButton({
    required Key key,
    required this.normalSvg,
    required this.pressedSvg,
    required this.onPressed,
    this.title = '',
    this.normalStyle = const TextStyle(),
    this.pressedStyle = const TextStyle(),
    this.padding = 5,
  }) : super(key: key);

  @override
  _SvgButtonState createState() {
    return _SvgButtonState();
  }
}

class _SvgButtonState extends State<SvgButton> {
  var isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isPressed ? widget.pressedSvg : widget.normalSvg,
          widget.title!.isNotEmpty
              ? Padding(padding: EdgeInsets.fromLTRB(0, widget.padding, 0, 0))
              : Container(),
          widget.title!.isNotEmpty
              ? Text(
                  widget.title!,
                  style: isPressed ? widget.pressedStyle : widget.normalStyle,
                )
              : Container(),
        ],
      ),
      onTap: widget.onPressed,
      onTapDown: (d) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (d) {
        setState(() {
          isPressed = false;
        });
      },
    );
  }
}
