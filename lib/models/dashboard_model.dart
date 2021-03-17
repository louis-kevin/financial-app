import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/models/account_model.dart';

class DashboardModel {
  int overheadPerDayCents = 0;
  int totalAmountCents = 0;
  DateTime lastPayment;
  DateTime nextPayment;
  int holidays;
  int weekdaysUntilPayment;
  int weekendUntilPayment;
  double percentageUntilIncome = 0;

  List<AccountModel> accounts = [];

  double get overheadPerDay => overheadPerDayCents / 100;

  double get totalAmount => totalAmountCents / 100;

  String get overheadPerDayMonetized => overheadPerDay.monetize;

  String get totalRemainingDebitMonetized => totalAmountCents.monetize;

  String get lastPaymentFormatted => lastPayment.dateLocalized;

  String get nextPaymentFormatted => nextPayment.dateLocalized;

  String get todayFormatted => DateTime.now().dateLocalized;

  bool get hasAccounts => accounts != null && accounts.isNotEmpty;

  DashboardModel.fromJson(Map<String, dynamic> json) {
    this.overheadPerDayCents = json['overhead_per_day_cents'];
    this.totalAmountCents = json['total_amount_cents'];
    this.lastPayment = DateTime.parse(json['last_payment']);
    this.nextPayment = DateTime.parse(json['next_payment']);
    this.holidays = json['holidays'];
    this.weekdaysUntilPayment = json['weekdays_until_payment'];
    this.weekendUntilPayment = json['weekend_until_payment'];
    this.percentageUntilIncome = json['percentage_until_income'].toDouble();

    var accounts = json['accounts'] as List;

    this.accounts = accounts
        .map((account) => AccountModel.fromJson(account))
        .cast<AccountModel>()
        .toList();
  }
}
