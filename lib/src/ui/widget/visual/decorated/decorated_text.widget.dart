import 'package:decorated_flutter/src/utils/utils.export.dart';
import 'package:flutter/material.dart';

class DecoratedText extends StatelessWidget {
  const DecoratedText(
    this.data, {
    Key key,
    this.padding,
    this.margin,
    this.decoration,
    this.style,
    this.strutStyle = const StrutStyle(),
    this.safeArea,
    this.onPressed,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.constraints,
    this.expanded = false,
    this.visible,
    this.width,
    this.height,
    this.center,
    this.transform,
    this.sliver,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxDecoration decoration;
  final TextStyle style;
  final StrutStyle strutStyle;
  final String data;
  final bool safeArea;
  final ContextCallback onPressed;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final BoxConstraints constraints;
  final bool expanded;
  final double width;
  final double height;
  final bool visible;
  final bool center;
  final bool sliver;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    Widget result = Text(
      data,
      maxLines: maxLines,
      style: style ?? DefaultTextStyle.of(context).style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      overflow: overflow,
    );

    if (center == true) {
      result = Center(child: result);
    }

    if (decoration != null ||
        padding != null ||
        margin != null ||
        width != null ||
        height != null ||
        transform != null) {
      result = Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: decoration,
        constraints: constraints,
        transform: transform,
        child: result,
      );
    }

    if (safeArea == true) {
      result = SafeArea(child: result);
    }

    if (onPressed != null) {
      result = GestureDetector(
        onTap: () => onPressed(context),
        child: result,
      );
    }

    if (visible == true) {
      result = Visibility(visible: visible, child: result);
    }

    if (expanded == true) {
      result = Expanded(child: result);
    }

    if (sliver == true) {
      result = SliverToBoxAdapter(child: result);
    }

    return result;
  }
}
