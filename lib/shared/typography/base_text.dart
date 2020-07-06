import 'package:financialapp/locale/locale_i18n.dart';
import 'package:flutter/material.dart';

abstract class BaseText extends StatelessWidget {
  final BoxFit fit;

  BaseText(
    this.text, {
    Key key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textColor,
    this.textKey,
    this.fit,
  }) : super(key: key);

  BaseText.key(
    this.textKey, {
    Key key,
    this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textColor,
    this.fit,
  }) : super(key: key);

  TextStyle buildTextStyle(context);

  final String text;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final Color textColor;
  final String textKey;

  @override
  Widget build(BuildContext context) {
    if (fit != null) return FittedBox(fit: fit, child: getText(context));

    return getText(context);
  }

  getText(context) {
    TextStyle textStyle = style;
    if (textColor != null && textStyle == null) {
      textStyle = TextStyle(color: textColor);
    }
    return Text(
      text ?? textKey.i18n,
      style: buildTextStyle(context).merge(textStyle),
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
    );
  }
}
