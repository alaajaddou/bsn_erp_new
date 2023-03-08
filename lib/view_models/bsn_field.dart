import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/entity.dart';
import 'package:flutter/material.dart';

@reflectable
class BsnField extends BsnWidget {
  TextEditingController controller = TextEditingController();

  BsnField() {
    fields = [
      ...fields,
      bsn_fields.state,
      bsn_fields.max,
      bsn_fields.min,
      bsn_fields.align,
      bsn_fields.value
    ];
  }

//
  focusField() {
    // TODO Need implementation.
    //  show the selected widget status.
  }

//
  blurField(newVal) {
    Entity entity = getRoot().entity;
    if (name == null) {
      return;
    }

    if (entity.checkIfChanged(fieldName: name!, value: newVal)) {
      entity.setField(fieldName: name!, value: newVal);
      // this.formGroup.controls[name].markAsDirty();
      entity.sendUnFlushedData();
      entity.triggerEnable();
      entity.triggerVisible();
    }
  }

  String? _align;

  String? get align {
    if (_align != null) {
      return Utils.getTextDirection(align: _align);
    }
    return Utils.getTextDirection(
        align: getAttributeDefaultValue(bsn_fields.align));
  }

  set align(String? align) {
    _align = align;
  }

  num? _max;

  num? get max => _max ?? getAttributeDefaultValue<num?>(bsn_fields.max);

  set max(dynamic max) {
    try {
      _max = num.parse(max);
    } catch (e) {
      _max = null;
    }
  }

  num? _min;

  num? get min => _min ?? getAttributeDefaultValue<num?>(bsn_fields.min);

  set min(dynamic min) {
    try {
      _min = num.parse(min);
    } catch (e) {
      _min = null;
    }
  }

  String? _state;

  String? get state =>
      _state ?? getAttributeDefaultValue<String?>(bsn_fields.state);

  set state(String? state) {
    _state = state;
  }

  String get value {
    if (getRoot().getEntity().getField(fieldName: name) != null) {
      return getRoot().getEntity().getField(fieldName: name);
    } else {
      return getAttributeDefaultValue(bsn_fields.value);
    }
  }

  set value(String value) {
    Entity entity = getRoot().getEntity();

    if (entity.getField(fieldName: name!) != value) {
      entity.setField(fieldName: name!, value: value);
    }
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    T? defaultValue;
    switch (attribute) {
      case bsn_fields.align:
        defaultValue = Utils.getTextDirection(align: 'leading') as T;
        break;
      case bsn_fields.labelAlign:
        defaultValue = 'before' as T;
        break;
      default:
        defaultValue = super.getAttributeDefaultValue<T>(attribute);
        break;
    }
    return defaultValue;
  }
}
