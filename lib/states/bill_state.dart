import 'dart:async';

import 'package:dio/dio.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/services/bill_service.dart';

import 'base_state.dart';

class BillState extends BaseState {
  BillState(this.account);

  final AccountModel account;

  BillService billService = BillService();

  List<BillModel> bills;

  Future<List<BillModel>> fetchBills() {
    var async = () async {
      Response response = await billService.fetchBillsByAccount(account.id);

      List data = response.data["data"];

      bills = data.map((bill) => BillModel.fromJson((bill))).toList();

      notifyListeners();

      return bills;
    };

    return handleAsync(async);
  }

  Future<void> saveBill(BillModel model) async {
    Function async = () async {
      bool modelExists = model.id != null;

      Response response =
          await billService.saveBill(model.toJson(), id: model.id);

      model.fill(response.data);

      if (!modelExists) {
        bills.add(model);
        account.totalAmountCents -= model.amountCents;
        Notifier()..fire(AccountSaved(account));
        notifyListeners();
      }
    };

    return handleAsync(async);
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

  void updatePayed(BillModel bill, bool value) {
    var billInList = bills.firstWhere((item) => item.id == bill.id);

    billInList.payed = value;

    updateAccountAmountByBill(billInList);

    withDebounce(() {
      saveBill(billInList).then((_) {
        if (errors.isEmpty) return;

        billInList.payed = false;
        updateAccountAmountByBill(billInList);
      }).catchError((error) {
        billInList.payed = false;

        updateAccountAmountByBill(billInList);
      });
    });
  }

  void updateAccountAmountByBill(BillModel bill) {
    int newAccountAmount = account.totalAmountCents;

    if (bill.payed) {
      newAccountAmount += bill.amountCents;
    } else {
      newAccountAmount -= bill.amountCents;
    }

    account.totalAmountCents = newAccountAmount;

    Notifier()..fire(AccountSaved(account));
  }
}
