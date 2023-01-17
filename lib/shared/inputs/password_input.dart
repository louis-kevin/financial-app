import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordInput extends FormBuilderTextField {
  PasswordInput(
    BuildContext context, {
    Key key,
    InputDecoration decoration,
    TextStyle style,
    String name,
    String errorMessage,
    List<FormFieldValidator> validators,
    bool required = false,
  }) : super(
          name: name ?? 'password',
          key: key,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          maxLines: 1,
          style: style ??
              TextStyle(
                color: Colors.white,
              ),
          decoration: decoration?.copyWith(errorText: errorMessage) ??
              const InputDecoration().copyWith(
                labelText: LabelTextKeys.password.i18n,
                errorText: errorMessage,
              ),
          validator: FormBuilderValidators.compose(
            (validators ?? [])
              ..addAll([
                if (required) FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6)
              ]),
          ),
        );
}
