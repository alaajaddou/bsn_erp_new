import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_text.dart';

@reflectable
class BsnDate extends BsnText {
  BsnDate() {
    fields = [...fields, bsn_fields.dateType];
  }

  String? _dateType;

  String? get dateType => _dateType;

  set dateType(String? value) {
    _dateType = value;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.dateType:
        return 'date' as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }
}
