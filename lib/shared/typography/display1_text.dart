import 'package:flutter/material.dart';

import 'base_text.dart';

class Display1Text extends BaseText {
  Display1Text(
    String text, {
    style,
    strutStyle,
    textAlign,
    textDirection,
    locale,
    softWrap,
    overflow,
    textScaleFactor,
    maxLines,
    semanticsLabel,
    textWidthBasis,
    textColor,
    textKey,
    BoxFit fit,
  }) : super(
          text,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textColor: textColor,
          textKey: textKey,
          fit: fit,
        );

  Display1Text.key(
    String textKey, {
    style,
    strutStyle,
    textAlign,
    textDirection,
    locale,
    softWrap,
    overflow,
    textScaleFactor,
    maxLines,
    semanticsLabel,
    textWidthBasis,
    textColor,
    text,
    BoxFit fit,
  }) : super.key(
          textKey,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textColor: textColor,
          text: text,
          fit: fit,
        );

  @override
  buildTextStyle(context) => Theme.of(context).textTheme.display1;
}
