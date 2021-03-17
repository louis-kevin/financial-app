import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/models/mixins/amount_attribute.dart';
import 'package:flutter/material.dart';

class AccountModel extends ChangeNotifier with AmountCentsAttribute {
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

  int amountCents;
  int totalAmountCents;

  double get totalAmount => totalAmountCents / 100;

  String get totalAmountMonetized => totalAmount.monetize;

  List<BillModel> bills = [];

  AccountModel({this.id, this.name, this.color, this.amountCents});

  AccountModel.fromJson(Map<String, dynamic> data) {
    fill(data);
  }

  void fill(Map<String, dynamic> data) {
    this.id = data['id'] ?? this.id;
    this.name = data['name'] ?? this.name;

    this.amountCents =
        int.parse(data['amount_cents'].toString()) ?? this.amountCents ?? 0;

    if (data.containsKey('color')) {
      this.color = Color(int.parse(data['color'].toString()));
    }

    if (data.containsKey('total_amount_cents')) {
      this.totalAmountCents = int.parse(data['total_amount_cents'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['id'] = this.id;
    data['name'] = this.name;
    data['amount_cents'] = this.amountCents;
    data['color'] =
        this.color.toString().replaceAll('Color(', '').replaceAll(')', '');

    return data;
  }

  needUpdate(AccountModel accountModel) {
    return accountModel.name != name ||
        accountModel.amountCents != amountCents ||
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

  void updateBillSum({Function callback}) {}
}
