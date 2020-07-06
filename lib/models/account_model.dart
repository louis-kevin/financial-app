import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:flutter/material.dart';

import 'mixins/amount_attribute.dart';

class AccountModel extends ChangeNotifier with AmountAttribute {
  bool _busy = false;

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  bool _loadingBills = false;

  bool get loadingBills => _loadingBills;

  set loadingBills(bool loadingBills) {
    _loadingBills = loadingBills;
    notifyListeners();
  }

  int id;
  String name;
  Color color;

  double amount;
  double toPay;

  double get totalAccount => (amount ?? 0) - (toPay ?? 0);

  String get billSumMonetized => toPay.monetize;

  String get totalAccountMonetized => totalAccount.monetize;

  List<BillModel> bills = [];

  AccountModel({this.id, this.name, this.color, this.amount, this.toPay});

  AccountModel.fromJson(Map<String, dynamic> data) {
    fill(data);
  }

  void fill(Map<String, dynamic> data) {
    double oldAmount = this.totalAccount;
    this.id = data['id'] ?? this.id;
    this.name = data['name'] ?? this.name;
    this.amount =
        double.tryParse(data['amount'].toString()) ?? this.amount ?? 0;
    this.toPay =
        double.tryParse(data['bill_sum'].toString()) ?? this.toPay ?? 0;
    this.color = data.containsKey('color') ? Color(data['color']) : this.color;
    double newAmount = this.totalAccount;

    if (oldAmount != newAmount)
      Notifier()
        ..fire(TotalAmountUpdate(
          oldAmount: oldAmount,
          newAmount: newAmount,
        ));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['color'] = this.color.value;

    return data;
  }

  needUpdate(AccountModel accountModel) {
    return accountModel.name != name ||
        accountModel.amount != amount ||
        accountModel.color != color;
  }

  void addBill(BillModel bill) {
    this.bills.add(bill);
  }

  void updateBill(BillModel bill) {
    int index = bills.indexWhere((item) => item.id == bill.id);
    bills[index] = bill;
  }

  void addOrUpdateBill(BillModel bill) {
    updateBillSum(callback: () {
      if (bill.id == null) return this.addBill(bill);
//      this.updateBill(bill);
    });
  }

  void addBills(List<BillModel> bills) {
    updateBillSum(callback: () => this.bills = bills);
  }

  void updateBillSum({Function callback}) {
    double oldAmount = this.totalAccount;

    if (callback != null) callback();

    this.toPay = 0;

    bills.where((bill) => !bill.payed).forEach((bill) => toPay += bill.amount);

    double newAmount = this.totalAccount;

    if (oldAmount != newAmount)
      Notifier()
        ..fire(TotalAmountUpdate(
          oldAmount: oldAmount,
          newAmount: newAmount,
        ));

    notifyListeners();
  }
}
