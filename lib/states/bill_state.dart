import 'package:dio/dio.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/services/bill_service.dart';
import 'package:flutter/material.dart';

class BillState extends ChangeNotifier {
  bool _busy = false;

  BillState(this.account);

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  final AccountModel account;

  BillService billService = BillService();

  List<BillModel> bills = [];

  Future<List<BillModel>> fetchBills() async {
    Response response = await billService.fetchBillsByAccount(account.id);

    List<Map> data = response.data as List;

    bills = data.map((bill) => BillModel.fromJson((bill))).toList();

    account.addBills(bills);

    notifyListeners();

    return bills;
  }

  saveBill(BillModel model) async {
    model.busy = true;

    bool modelExists = model.id != null;

    Response response =
        await billService.saveBill(model.toJson(), id: model.id);

    model.fill(response.data);

    model.id = bills.isEmpty ? 1 : bills.last.id + 1;

    account.addOrUpdateBill(model);

    if (!modelExists) {
      bills.add(model);
      notifyListeners();
    }

    model.busy = false;
  }

  BillModel findById(int id) {
    return bills.firstWhere(
      (bill) => bill.id == id,
      orElse: () => null,
    );
  }

  void deleteAccount(BillModel bill) {
    bills.remove(bill);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    BillModel bill = bills.removeAt(oldIndex);
    bills.insert(newIndex, bill);
    notifyListeners();
  }
}
