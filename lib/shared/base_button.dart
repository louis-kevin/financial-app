import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, danger }

class BaseButton extends StatelessWidget {
  final Function onPressed;

  final ButtonType type;

  final String text;

  final Color textColor;

  final Color color;

  final bool block;

  final String textKey;

  const BaseButton({
    Key key,
    this.onPressed,
    this.type = ButtonType.primary,
    this.text,
    this.textColor,
    this.color,
    this.block = true,
    this.textKey,
  })  : assert(text != null || textKey != null),
        super(key: key);

  Color _findButtonColor(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).buttonTheme.colorScheme;

    switch (type) {
      case ButtonType.primary:
        return colorScheme.primary;
        break;
      case ButtonType.secondary:
        return colorScheme.secondary;
        break;
      case ButtonType.danger:
        return colorScheme.error;
        break;
      default:
        return colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = this.color ?? _findButtonColor(context);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
      child: buildContent(context),
    );
  }

  Widget buildContent(context) {
    if (!this.block) return buildText(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: buildText(context),
    );
  }

  Widget buildText(context) {
    return Center(
      child: BodyMediumText(
        text ?? textKey.i18n,
        textColor: textColor ?? Colors.white,
      ),
    );
  }
}
