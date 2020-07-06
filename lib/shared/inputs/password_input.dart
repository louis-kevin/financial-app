import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PasswordInput extends FormBuilderTextField {
  PasswordInput({
    Key key,
    InputDecoration decoration,
    TextStyle style,
    String attribute,
  }) : super(
          attribute: attribute ?? 'password',
          key: key,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          maxLines: 1,
          style: style ??
              TextStyle(
                color: Colors.white,
              ),
          decoration: decoration ??
              const InputDecoration().copyWith(
                labelText: LabelTextKeys.password.i18n,
              ),
        );
}
