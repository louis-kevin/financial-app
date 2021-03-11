import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/locale/messages/messages_en.dart';
import 'package:financialapp/locale/messages/messages_pt-br.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:intl/intl.dart';

var messages = {
  "en": enMessages,
  "pt-br": ptBrMessages,
};

var _controller = MoneyMaskedTextController(
  decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
  thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
  leftSymbol: MoneyTextKeys.leftSymbol.i18n,
);

extension Localization on String {
  static var _t = Translations.byLocale("pt-br") + messages;

  String get i18n => localize(this, _t);

  String plural(int value) {
    recordKey(this);
    return this.replaceAll("%d", value.toString());
  }

  String fill(List<Object> params) => localizeFill(this, params);
}

extension LocalizationNumber on num {
  String get monetize {
    _controller.updateValue(this.toDouble());

    String text = _controller.text;

    if (this < 0) {
      String leftSymbol = MoneyTextKeys.leftSymbol.i18n;
      text = text.replaceFirst(leftSymbol, "$leftSymbol - ");
    }

    return text;
  }
}

extension LocatizationDateTime on DateTime {
  String get dateLocalized =>
      DateFormat(DateFormatKey.dateFormat.i18n).format(this);
}
