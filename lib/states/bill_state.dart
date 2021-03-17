import 'package:dio/dio.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/services/bill_service.dart';

import 'base_state.dart';

class BillState extends BaseState {
  BillState(this.account);

  final AccountModel account;

  BillService billService = BillService();

  List<BillModel> bills = [];

  Future<List<BillModel>> fetchBills() async {
    var async = () async {
      Response response = await billService.fetchBillsByAccount(account.id);

      List data = response.data["data"];

      bills = data.map((bill) => BillModel.fromJson((bill))).toList();

      account.addBills(bills);

      notifyListeners();

      return bills;
    };

    return handleAsync(async);
  }

  saveBill(BillModel model) async {
    model.busy = true;
    Function async = () async {
      bool modelExists = model.id != null;

      Response response =
          await billService.saveBill(model.toJson(), id: model.id);

      model.fill(response.data);

      account.addOrUpdateBill(model);

      if (!modelExists) {
        bills.add(model);
        notifyListeners();
      }
    };

    Function runAlways = () {
      model.busy = false;
    };

    return handleAsync(async, runAlways: runAlways);
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
