import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

var accountNeon = {
  'id': 1,
  'name': 'Neon',
  'color': 4282557941,
  'amount': 1234.56,
  'bill_sum': 3212
};
var accountBradesco = {
  'id': 2,
  'name': 'Bradesco',
  'color': 4294198070,
  'amount': 357.21,
  'bill_sum': 1324,
};

var accounts = [accountNeon, accountBradesco];

class AccountService extends BaseService {
  Future<Response> fetchAccounts() {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(data: accounts, statusCode: 200),
    );
  }

  Future<Response> saveAccount(Map<String, dynamic> data, {int id}) {
    data['id'] = id;
    return Future.delayed(
      Duration(seconds: 1),
      () => Response(data: data, statusCode: 200),
    );
  }
}
