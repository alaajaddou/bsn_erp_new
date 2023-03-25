import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_text.dart';

@reflectable
class BsnTextArea extends BsnText {
  BsnTextArea() {
    fields = [...fields, bsn_fields.rows];
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.rows:
        return 5 as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }
}
