import 'package:financialapp/locale/locale_i18n.dart';

mixin AmountAttribute {
  double amount;

  String get amountMonetized => amount.monetize;
}
