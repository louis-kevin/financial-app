import 'package:flutter/material.dart';

import 'mixins/amount_attribute.dart';

enum BillType { once, daily, monthly }

class BillModel extends ChangeNotifier with AmountAttribute {
  bool _busy = false;

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  int id;
  double amount;
  String name;
  BillType type;
  int paymentDay;
  bool _payed;

  bool get payed => _payed;

  set payed(bool payed) {
    _payed = payed;
    notifyListeners();
  }

  int accountId;

  BillModel({
    this.id,
    this.amount,
    this.name,
    this.type,
    this.paymentDay,
    bool payed = false,
  }) : _payed = payed;

  BillModel.fromJson(Map<String, dynamic> json) {
    fill(json);
  }

  void fill(Map<String, dynamic> data) {
    this.id = data['id'] ?? this.id;
    this.accountId = data['account_id'] ?? this.accountId;
    this.amount = double.parse(data['amount'].toString()) ?? this.amount;
    this.name = data['name'] ?? this.name;
    this.payed = data['payed'] ?? this.payed;
    this.paymentDay = data['payment_day'] ?? this.paymentDay;
    this.type = data.containsKey('type')
        ? BillType.values.firstWhere((item) {
            return item.toString().replaceAll('BillType.', '') == data['type'];
          })
        : this.type;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{
      'id': id,
      'account_id': accountId,
      'name': name,
      'amount': amount,
      'payed': payed,
      'payment_day': paymentDay,
      'type': type.toString().replaceAll('BillType.', ''),
    };

    return data;
  }
}
