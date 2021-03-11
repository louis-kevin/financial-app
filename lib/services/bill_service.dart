import 'dart:math';

import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

var billOnce = {
  'id': 1,
  'name': 'Random Once',
  'amount': 1234.56,
  'account_id': 1,
  'payment_day': 20,
  'payed': false,
  'type': 'once'
};

var billDaily = {
  'id': 1,
  'name': 'Random Daily',
  'amount': 1234.56,
  'account_id': 1,
  'payment_day': 13,
  'payed': false,
  'type': 'daily'
};

var billMonthly = {
  'id': 1,
  'name': 'Random Monthly',
  'amount': 1234.56,
  'account_id': 1,
  'payment_day': 2,
  'payed': false,
  'type': 'monthly'
};

class BillService extends BaseService {
  Future<Response> fetchBillsByAccount(int accountId) {
    List<Map<String, dynamic>> bills = [
      ..._buildBills(accountId, billOnce),
      ..._buildBills(accountId, billMonthly),
      ..._buildBills(accountId, billDaily),
    ];

    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(
          data: bills, statusCode: 200, request: RequestOptions(path: 'test')),
    );
  }

  saveBill(Map<String, dynamic> data, {int id}) {
    return Future.delayed(
      Duration(seconds: 1),
      () => Response(
          data: data, statusCode: 200, request: RequestOptions(path: 'test')),
    );
  }

  _buildBills(int accountId, Map<String, dynamic> bill) {
    var rng = new Random();

    if (rng.nextDouble().round() > 0.5) return [];

    bill['account_id'] = accountId;

    return Iterable<int>.generate(rng.nextInt(7)).map<Map>((value) {
      bill['amount'] = rng.nextInt(1000) * rng.nextDouble();

      return bill;
    });
  }
}
