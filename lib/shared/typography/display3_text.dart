import 'package:flutter/material.dart';

import 'base_text.dart';

class Display3Text extends BaseText {
  Display3Text(
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
        );

  Display3Text.key(
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
        );

  @override
  buildTextStyle(context) => Theme.of(context).textTheme.display3;
}
