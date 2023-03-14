import 'package:bisan_systems_erp/view_models/entity.dart';

class BsnAction {
  final String? recordType;
  final String name;
  final String? label;
  final String newAction;
  String? code;
  final String? tempCode;
  final Entity entity;

  BsnAction(this.recordType, this.name, this.newAction, this.code,
      this.tempCode, this.entity, this.label);

  @override
  String toString() {
    // TODO: implement toString
    return 'recordType = $recordType, name = $name, newAction = $newAction, code = $code, tempCode = $tempCode, entity = $entity, label = $label,';
  }
}
