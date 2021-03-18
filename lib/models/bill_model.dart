import 'package:financialapp/models/mixins/amount_attribute.dart';

enum BillType { once, daily, monthly }

class BillModel with AmountCentsAttribute {
  int id;
  int amountCents;
  String name;
  BillType repetitionType;
  int paymentDay;
  bool payed;
  int accountId;

  BillModel({
    this.id,
    this.amountCents,
    this.name,
    this.repetitionType,
    this.paymentDay,
    this.payed,
  });

  BillModel.fromJson(Map<String, dynamic> json) {
    fill(json);
  }

  void fill(Map<String, dynamic> data) {
    this.id = data['id'] ?? this.id;
    this.accountId = data['account_id'] ?? this.accountId;
    this.amountCents = data['amount_cents'] ?? this.amountCents;
    this.name = data['name'] ?? this.name;
    this.payed = data['payed'] ?? this.payed;
    this.paymentDay = data['payment_day'] ?? this.paymentDay;
    this.repetitionType = data.containsKey('repetition_type')
        ? BillType.values.firstWhere((item) {
            return item.toString().replaceAll('BillType.', '') ==
                data['repetition_type'];
          })
        : this.repetitionType;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{
      'id': id,
      'account_id': accountId,
      'name': name,
      'amount_cents': amountCents,
      'payed': payed,
      'payment_day': paymentDay,
      'repetition_type': repetitionType.toString().replaceAll('BillType.', ''),
    };

    return data;
  }
}
