import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

var _controller = MoneyMaskedTextController(
  decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
  thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
  leftSymbol: MoneyTextKeys.leftSymbol.i18n,
);

class AmountInput extends FormBuilderTextField {
  AmountInput(
    BuildContext context, {
    Key key,
    InputDecoration decoration,
    TextStyle style,
    double value,
    String name,
    MoneyMaskedTextController controller,
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
                initialValue: value ?? 0,
              ),
          initialValue: value?.toString() ?? 0.toString(),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.start,
          valueTransformer: (value) {
            _controller.text = value;
            return _controller.numberValue;
          },
          validator: FormBuilderValidators.compose(
            (validators ?? [])
              ..addAll([
                if (required) FormBuilderValidators.required(context),
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
