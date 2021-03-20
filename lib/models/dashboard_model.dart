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

  double get overheadPerDay => overheadPerDayCents / 100;

  double get totalAmount => totalAmountCents / 100;

  String get overheadPerDayMonetized => overheadPerDay.monetize;

  String get totalRemainingDebitMonetized => totalAmount.monetize;

  String get lastPaymentFormatted => lastPayment.dateLocalized;

  String get nextPaymentFormatted => nextPayment.dateLocalized;

  String get todayFormatted => DateTime.now().dateLocalized;

  DashboardModel.fromJson(Map<String, dynamic> json) {
    this.overheadPerDayCents = json['overhead_per_day_cents'];
    this.totalAmountCents = json['total_amount_cents'];
    this.lastPayment = DateTime.parse(json['last_payment']);
    this.nextPayment = DateTime.parse(json['next_payment']);
    this.holidays = json['holidays'];
    this.weekdaysUntilPayment = json['weekdays_until_payment'];
    this.weekendUntilPayment = json['weekend_until_payment'];
    this.percentageUntilIncome = json['percentage_until_income'].toDouble();
  }

  void calculateTotalAmountCents(List<AccountModel> accounts) {
    var newAmount = 0;

    accounts.forEach((element) {
      // print("${element.name}: ${element.totalAmountCents}");
      newAmount += element.totalAmountCents;
    });

    this.totalAmountCents = newAmount;

    int daysUntilPayment = DateTime.now().difference(lastPayment).inDays;
    overheadPerDayCents = (totalAmountCents / daysUntilPayment).round();
  }
}
