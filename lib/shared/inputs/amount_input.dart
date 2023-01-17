import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AmountInput extends FormBuilderTextField {
  AmountInput(
    BuildContext context,
    MoneyMaskedTextController controller, {
    Key key,
    InputDecoration decoration,
    TextStyle style,
    double value,
    String name,
    List<FormFieldValidator> validators,
    bool required = false,
  }) : super(
          name: name ?? 'amount',
          key: key,
          controller: controller ??
              new MoneyMaskedTextController(
                decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
                thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
                leftSymbol: MoneyTextKeys.leftSymbol.i18n,
                initialValue: value,
              ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.start,
          valueTransformer: (value) {
            controller.text = value;
            double numberValue = controller.numberValue * 100;
            return numberValue.toInt();
          },
          validator: FormBuilderValidators.compose(
            (validators ?? [])
              ..addAll([
                if (required) FormBuilderValidators.required(),
              ]),
          ),
          style: style ??
              TextStyle(
                color: Colors.white,
              ),
          decoration: decoration ??
              const InputDecoration().copyWith(
                labelText: LabelTextKeys.amount.i18n,
              ),
        );
}
