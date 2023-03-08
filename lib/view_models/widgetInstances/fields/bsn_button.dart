import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnButton extends BsnField {
  BsnButton() {
    fields = [...fields, bsn_fields.icon];
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.icon:
        return null;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }

  getDisplayText(item) {
    if (!item) {
      return "";
    }
    return Utils.getDisplayText(element: item);
  }
}
