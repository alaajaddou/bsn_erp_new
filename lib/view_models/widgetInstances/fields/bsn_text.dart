import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

@reflectable
class BsnText extends BsnField {
  BsnText() {
    fields = [
      ...fields,
      bsn_fields.size,
      bsn_fields.columns,
      bsn_fields.pattern,
      bsn_fields.link,
      bsn_fields.pad,
      bsn_fields.nameValue,
      bsn_fields.autoComplete
    ];

    updateEnable();
    updateVisible();
  }

  bool? _autoComplete;

  bool? get autoComplete =>
      _autoComplete ?? getAttributeDefaultValue(bsn_fields.autoComplete);

  set autoComplete(bool? autoComplete) {
    _autoComplete = autoComplete;
  }

  String? _nameValue;

  String? get nameValue =>
      _nameValue ?? getAttributeDefaultValue(bsn_fields.nameValue);

  set nameValue(String? nameValue) {
    _nameValue = nameValue;
  }

  String? _pad;

  String? get pad => _pad ?? getAttributeDefaultValue(bsn_fields.pad);

  set pad(String? pad) {
    _pad = pad;
  }

  num? _size;

  num? get size => _size ?? getAttributeDefaultValue(bsn_fields.size);

  set size(num? size) {
    _size = size;
  }

  num? _columns;

  num? get columns => _columns ?? getAttributeDefaultValue(bsn_fields.columns);

  set columns(num? columns) {
    _columns = columns;
  }

  String? _pattern;

  String? get pattern =>
      _pattern ?? getAttributeDefaultValue(bsn_fields.pattern);

  set pattern(String? pattern) {
    _pattern = pattern;
  }

  String? _link;

  String? get link => _link ?? getAttributeDefaultValue(bsn_fields.link);

  set link(String? link) {
    _link = link;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.size:
        return 20 as T;
      case bsn_fields.columns:
        return size as T;
      case bsn_fields.autoComplete:
        return false as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }

  open() {
    if (link == null) {
      return false;
    }
    //openLink(this, { link });
  }

  getWidth() {
    return Utils.getTextWidth(size: size);
  }

  hasNameValue() {
    return nameValue != null;
  }
}
