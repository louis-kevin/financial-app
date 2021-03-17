import 'package:financialapp/locale/locale_i18n.dart';

mixin AmountCentsAttribute {
  int amountCents;

  double get amount => amountCents/100;

  String get amountMonetized => amount.monetize;
}
