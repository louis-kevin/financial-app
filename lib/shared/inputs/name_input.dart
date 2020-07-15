import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NameInput extends FormBuilderTextField {
  NameInput({
    Key key,
    InputDecoration decoration,
    TextStyle style,
    String attribute,
    String errorMessage,
    List<FormFieldValidator> validators,
    bool required = false,
  }) : super(
          attribute: attribute ?? 'name',
          key: key,
          keyboardType: TextInputType.text,
          style: style ??
              TextStyle(
                color: Colors.white,
              ),
          decoration: decoration?.copyWith(errorText: errorMessage) ??
              const InputDecoration().copyWith(
                labelText: LabelTextKeys.name.i18n,
                errorText: errorMessage,
              ),
          validators: (validators ?? [])
            ..addAll([
              if (required) FormBuilderValidators.required(),
            ]),
        );
}
