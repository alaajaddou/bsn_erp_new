import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_text.dart';

@reflectable
class BsnNumeric extends BsnText {
  BsnNumeric() {
    fields = [
      ...fields,
      bsn_fields.float,
      bsn_fields.showZero,
      bsn_fields.commas,
      bsn_fields.fractions,
      bsn_fields.maxFraction
    ];

    // TODO add pattern, size & maxFractions validators
    // if (pattern != null) {
    //   pattern = pattern;
    // } else if (size && _fractions) {
    //   const length = size;
    //   const digits = size - (_fractions);
    //   const scale = _fractions;
    //   const regexString = "^\\d{1," + length + "}$|^\\d{1," + digits + "}.\\d{0," + scale + "}$";
    //   pattern = new RegExp(regexString, "g").source;
    // }
  }

  bool? _float;

  bool? get float => _float ?? getAttributeDefaultValue(bsn_fields.float);

  set float(bool? float) {
    _float = float;
  }

  bool? _showZero;

  bool? get showZero =>
      _showZero ?? getAttributeDefaultValue(bsn_fields.showZero);

  set showZero(bool? showZero) {
    _showZero = showZero;
  }

  bool? _commas;

  bool? get commas => _commas ?? getAttributeDefaultValue(bsn_fields.commas);

  set commas(bool? commas) {
    _commas = commas;
  }

  num? _fractions;

  num? get fractions =>
      _fractions ?? getAttributeDefaultValue(bsn_fields.fractions);

  set fractions(num? fractions) {
    _fractions = fractions;
  }

  num? _maxFraction;

  num? get maxFraction =>
      _maxFraction ?? getAttributeDefaultValue(bsn_fields.maxFraction);

  set maxFraction(num? maxFraction) {
    _maxFraction = maxFraction;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.float:
      case bsn_fields.showZero:
        return false as T;
      case bsn_fields.commas:
        return true as T;
      case bsn_fields.fractions:
      case bsn_fields.maxFraction:
        return 0 as T;
      case bsn_fields.align:
        return Utils.getTextDirection(align: 'right') as T;
      default:
        return super.getAttributeDefaultValue(attribute);
    }
  }
}
