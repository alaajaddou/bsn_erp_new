import 'package:bisan_systems_erp/view_models/entity.dart';

class BsnAction {
  final String? recordType;
  final String name;
  final String newAction;
  String? code;
  final String? tempCode;
  final Entity entity;

  BsnAction(this.recordType, this.name, this.newAction, this.code,
      this.tempCode, this.entity);
}
