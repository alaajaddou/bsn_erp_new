import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnContainer extends BsnWidget {
  late num width;
  late num _ENTITY_ID;

  BsnContainer() {
    fields = [...fields, bsn_fields.layout, bsn_fields.icon];
  }

  String? _icon;

  String? get icon => _icon ?? getAttributeDefaultValue(bsn_fields.icon);

  set icon(String? icon) {
    _icon = icon;
  }

  String? _layout;

  String? get layout => _layout ?? getAttributeDefaultValue(bsn_fields.layout);

  set layout(String? layout) {
    _layout = layout;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.layout:
        return 'column' as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }

  fxFlex() {
    return {
      'label': 100,
      'labelBefore': 30,
      'withLabel':
      hasLabel() && !hasLabelBefore() && !hasLabelAfter() ? 100 : 70,
      'labelAfter': 30
    };
  }
}
