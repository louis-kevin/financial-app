import 'package:flutter/foundation.dart';
import 'package:recase/recase.dart';

class UserModel {
  int id;
  String name;
  String email;

  UserConfig config;

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    if (json.containsKey('config') && json['config'] != null) {
      this.config = UserConfig.fromJson(json['config']);
    }
  }

  bool get needsConfig => config == null;

  Map<String, dynamic> toJson() {
    var data = {'id': this.id, 'name': this.name, 'email': this.email};

    return data;
  }
}

enum DayType { workDay, allDays }

enum IncomeOption { nextWorkDay, previousDay }

class UserConfig {
  int day;
  DayType dayType;
  int incomeCents;
  IncomeOption incomeOption;
  bool workInHolidays;

  UserConfig.empty() {
    this.day = 0;
    this.incomeCents = 0;
  }

  UserConfig.fromJson(Map<String, dynamic> json) {
    this.day = json['day'];
    this.incomeCents = json['income_cents'];
    this.workInHolidays = json['work_in_holidays'];

    this.dayType = DayType.values.firstWhere((value) =>
        ReCase(describeEnum(value)).snakeCase ==
        ReCase(json['day_type']).snakeCase);
    this.incomeOption = IncomeOption.values.firstWhere((value) =>
        ReCase(describeEnum(value)).snakeCase ==
        ReCase(json['income_option']).snakeCase);
  }

  double get income => incomeCents / 100;

  Map<String, dynamic> toJson() {
    var data = {
      'day': this.day,
      'day_type': ReCase(describeEnum(this.dayType)).snakeCase,
      'income_cents': this.incomeCents,
      'income_option': ReCase(describeEnum(this.incomeOption)).snakeCase,
      'work_in_holidays': this.workInHolidays
    };

    return data;
  }
}
