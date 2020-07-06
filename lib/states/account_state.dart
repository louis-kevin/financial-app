import 'package:dio/dio.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/services/account_service.dart';
import 'package:financialapp/services/bill_service.dart';
import 'package:flutter/material.dart';

class AccountState extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  AccountService accountService = AccountService();

  BillService billService = BillService();

  List<AccountModel> accounts = [];

  Future<List<AccountModel>> fetchAccounts() async {
    busy = true;

    Response response = await accountService.fetchAccounts();
    List<Map> data = response.data as List;
    accounts = data.map((account) => AccountModel.fromJson((account))).toList();

    busy = false;

    return accounts;
  }

  saveAccount(AccountModel model) async {
    model.busy = true;

    bool modelExists = model.id != null;

    Response response =
        await accountService.saveAccount(model.toJson(), id: model.id);

    model.fill(response.data);

    model.id = (accounts.last?.id ?? 0) + 1;

    if (!modelExists) accounts.add(model);

    model.busy = false;
  }

  updateAccountAmount(int id, double amount) async {
    var model = findById(id);

    if (model.amount == amount) return;

    model.amount = amount;

    saveAccount(model);

    notifyListeners();
  }

  AccountModel findById(int id) {
    return accounts.firstWhere(
      (account) => account.id == id,
      orElse: () => null,
    );
  }

  void deleteAccount(AccountModel account) {
    accounts.remove(account);
    notifyListeners();
  }

  Future<List<BillModel>> fetchBillsFromAccount(AccountModel account) async {
    Response response = await billService.fetchBillsByAccount(account.id);

    var data = response.data as List<Map<String, dynamic>>;

    return data.map((bill) => BillModel.fromJson(bill)).toList();
  }
}
