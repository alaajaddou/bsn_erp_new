import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

class BsnSplitPane extends BsnWidget {
  BsnSplitPane();

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.layout:
        return 'row' as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }
}
