import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnTable extends BsnField {
  BsnTable() {
    fields = [
      ...fields,
      bsn_fields.editable,
      bsn_fields.addRow,
      bsn_fields.rowHeader,
      bsn_fields.tableCols
    ];
  }
}
