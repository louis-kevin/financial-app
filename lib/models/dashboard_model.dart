import 'package:financialapp/locale/locale_i18n.dart';

class DashboardModel {
  double overheadPerDay;
  double totalRemainingDebit;
  DateTime lastPayment;
  DateTime nextPayment;
  int holidays;
  int businessDays;
  int weekendDays;

  String get overheadPerDayMonetized => overheadPerDay.monetize;
  String get totalRemainingDebitMonetized => totalRemainingDebit.monetize;

  String get lastPaymentFormatted => lastPayment.dateLocalized;
  String get nextPaymentFormatted => nextPayment.dateLocalized;
  String get todayFormatted => DateTime.now().dateLocalized;

  double get percentageUntilIncome {
    int a = lastPayment.difference(DateTime.now()).inDays;
    int b = lastPayment.difference(nextPayment).inDays;
    return (a / b).toDouble();
  }

  DashboardModel.fromJson(Map<String, dynamic> json) {
    this.overheadPerDay = double.parse(json['overhead_per_day'].toString());
    this.totalRemainingDebit =
        double.parse(json['total_remaining_debit'].toString());
    this.lastPayment = DateTime.parse(json['last_payment']);
    this.nextPayment = DateTime.parse(json['next_payment']);
    this.holidays = json['holidays'];
    this.businessDays = json['business_days'];
    this.weekendDays = json['weekend_days'];
  }
}
