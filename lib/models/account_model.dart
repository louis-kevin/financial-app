import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/models/mixins/amount_attribute.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';

class AccountModel with AmountCentsAttribute {
  int id;
  String name;
  Color color;
  int amountCents;
  int totalAmountCents;
  BillState _billState;

  BillState get billState {
    if (_billState == null) _billState = BillState(this);
    return _billState;
  }

  int get toPayCents => amountCents - totalAmountCents;
  double get toPay => toPayCents / 100;
  String get toPayMonetized => toPay.monetize;

  double get totalAmount => totalAmountCents / 100;
  String get totalAmountMonetized => totalAmount.monetize;

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
}
