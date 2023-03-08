import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnCheckBox extends BsnField {
  BsnCheckBox();

  bool toBoolean(String value) {
    return Utils.toBooleanLogic(value) as bool;
  }
}
