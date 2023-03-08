import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnDropDown extends BsnField {
  BsnDropDown() {
    fields = [...fields, bsn_fields.options];
  }

  List<dynamic> _options = [];

  List<dynamic> get options =>
      _options ?? getAttributeDefaultValue(bsn_fields.options);

  set options(List<dynamic> options) {
    _options = options;
  }

  String? _listName;

  String? get listName =>
      _listName ?? getAttributeDefaultValue(bsn_fields.listName);

  set listName(String? value) {
    _listName = value;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.options:
        return [] as T;
      case bsn_fields.listName:
        return "" as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }
}
