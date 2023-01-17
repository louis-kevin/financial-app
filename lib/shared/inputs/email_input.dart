import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailInput extends FormBuilderTextField {
  EmailInput(
    BuildContext context, {
    Key key,
    String name,
    InputDecoration decoration,
    TextStyle style,
    String errorMessage,
    List<FormFieldValidator> validators,
    bool required = false,
  }) : super(
          name: name ?? 'email',
          key: key,
          keyboardType: TextInputType.emailAddress,
          style: style ??
              TextStyle(
                color: Colors.white,
              ),
          decoration: decoration?.copyWith(errorText: errorMessage) ??
              const InputDecoration().copyWith(
                labelText: LabelTextKeys.email.i18n,
                errorText: errorMessage,
              ),
          validator: FormBuilderValidators.compose(
            (validators ?? [])
              ..addAll([
                if (required) FormBuilderValidators.required(),
                FormBuilderValidators.email()
              ]),
          ),
        );
}
