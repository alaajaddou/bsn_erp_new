import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/entity.dart';
import 'package:flutter/material.dart';
import 'package:reflectable/reflectable.dart';

class BsnReflectable extends Reflectable {
  const BsnReflectable()
      : super(
            invokingCapability,
            declarationsCapability,
            typeCapability,
            instanceInvokeCapability,
            typeRelationsCapability,
            reflectedTypeCapability);
}

const reflectable = BsnReflectable();

@reflectable
class BsnWidget {

  BsnWidget() {
    fields = [
      bsn_fields.bsnClass,
      bsn_fields.dragAndDropSource,
      bsn_fields.dragAndDropDestination,
      bsn_fields.enabled,
      bsn_fields.flex,
      bsn_fields.label,
      bsn_fields.labelAlign,
      bsn_fields.message,
      bsn_fields.shortcut,
      bsn_fields.size,
      bsn_fields.visible,
      bsn_fields.xCords,
      bsn_fields.yCords,
      bsn_fields.name
    ];
  }

  late Entity _entity;

  getEntity() {
    return _entity;
  }

  String? _labelAlign;

  String? get labelAlign =>
      _labelAlign ?? getAttributeDefaultValue<String>('labelAlign');

  set labelAlign(dynamic labelAlign) {
    _labelAlign = labelAlign;
  }

  List<String> _fields = [];

  List<String> get fields => _fields;

  set fields(List<String> fields) {
    _fields = fields;
  }

  List<Widget> _children = [];

  List<Widget> get children => _children;

  set children(List<Widget> children) {
    _children = children;
  }

  BsnWidget? _parent;

  BsnWidget? get parent =>
      _parent ?? getAttributeDefaultValue<BsnWidget>('parent');

  set parent(BsnWidget? parent) {
    _parent = parent;
  }

  String? _className;

  String? get className =>
      _className ?? getAttributeDefaultValue<String>('className');

  set className(String? className) {
    _className = className;
  }

  String? _dndDestination;

  String? get dndDestination =>
      _dndDestination ?? getAttributeDefaultValue<String>('dndDestination');

  set dndDestination(String? dndDestination) {
    _dndDestination = dndDestination;
  }

  String? _dndSource;

  String? get dndSource =>
      _dndSource ?? getAttributeDefaultValue<String>('dndSource');

  set dndSource(String? dndSource) {
    _dndSource = dndSource;
  }

  bool? _enabled = true;

  bool? get enabled => _enabled ?? getAttributeDefaultValue<bool>('enabled');

  set enabled(bool? enabled) {
    _enabled = enabled;
  }

  int? _flex;

  int? get flex => _flex ?? getAttributeDefaultValue<int>('flex');

  set flex(int? flex) {
    _flex = flex;
  }

  String? _label;

  String? get label => _label ?? getAttributeDefaultValue<String>('label');

  set label(String? label) {
    _label = label;
  }

  String? _message;

  String? get message =>
      _message ?? getAttributeDefaultValue<String>('message');

  set message(String? message) {
    _message = message;
  }

  String? _name;

  String? get name => _name ?? getAttributeDefaultValue<String>('name');

  set name(String? name) {
    _name = name;
  }

  String? _shortcut;

  String? get shortcut =>
      _shortcut ?? getAttributeDefaultValue<String>('shortcut');

  set shortcut(String? shortcut) {
    _shortcut = shortcut;
  }

  bool? _visible;

  bool? get visible => _visible ?? getAttributeDefaultValue<bool>('visible');

  set visible(bool? visible) {
    _visible = visible;
  }

  int? _x;

  int? get x => _x ?? getAttributeDefaultValue<int>('x');

  set x(int? x) {
    _x = x;
  }

  int? _y;

  int? get y => _y ?? getAttributeDefaultValue<int>('y');

  set y(int? y) {
    _y = y;
  }

  String? _enableLogic = '';

  String? get enableLogic => _enableLogic;

  set enableLogic(String? value) {
    _enableLogic = value;
  }

  // Object? _enableLogic = () => {};
  //
  // Object? get enableLogic => _enableLogic;
  //
  // set enableLogic(dynamic logic) {
  //   String llogic = 'isNull("isPerson")\u0001isPerson';
  //
  //   Function logicF = () => llogic;
  //   logicF();
  //
  //   var instanceMirror = reflector.reflect(this);
  //   _enableLogic = instanceMirror.invoke('isNull', ['isPerson']);
  //   // Function tempEnableLogic;
  //   // logic = Utils.toBooleanLogic(logic);
  //   // if (logic is bool) {
  //   //   tempEnableLogic = returnBoolean;
  //   // } else if (logic != null) {
  //   //   List<String> split = logic.split("\u0001");
  //   //   String logicString = split[0];
  //   //   List<String> logicParams = split.skip(1).toList();
  //   //   final MultiVariableFunction multiVarFunction = MultiVariableFunction(fromExpression: logicString, withVariables: logicParams);
  //   //   tempEnableLogic = multiVarFunction.call;
  //   // } else {
  //   //   tempEnableLogic = alwaysFalse;
  //   // }
  //   // _enableLogic = tempEnableLogic;
  // }

  bool returnBoolean(bool param) {
    return false;
  }

  bool alwaysFalse() {
    return false;
  }

  String _visibleLogic = '';

  String get visibleLogic => _visibleLogic;

  set visibleLogic(logic) {}

  // Function createFunctionFromString() {
  //   String functionString = "isNull(isPerson) && !isNull(bdate(dob))\u0001isPerson\u0001dob";
  //   List<String> parts = functionString.split("\u0001");
  //   String body = parts.removeAt(0);
  //   var params = parts;
  //
  //   // var func = MultiVariableFunction(fromExpression: body, withVariables: params);
  //   // return func;
  //   // Now you can use the func variable as a function
  // }

  // set visibleLogic(dynamic logic) {
  //   Function tempVisibleLogic;
  //   logic = Utils.toBooleanLogic(logic);
  //   if (logic is bool) {
  //     tempVisibleLogic = returnBoolean;
  //   } else if (logic != null) {
  //     List<String> split = logic.split("\u0001");
  //     String logicString = split[0];
  //     List<String> logicParams = split.skip(1).toList();
  //     final MultiVariableFunction multiVarFunction = MultiVariableFunction(fromExpression: logicString, withVariables: logicParams);
  //     tempVisibleLogic = multiVarFunction.call;
  //   } else {
  //
  //     tempVisibleLogic = alwaysFalse;
  //   }
  //   _visibleLogic = tempVisibleLogic;
  // }

  getRoot() {
    if (parent != null) {
      return parent!.getRoot();
    } else {
      return this;
    }
  }

  T? getAttributeDefaultValue<T>(String attribute) {
    T? defaultValue;
    switch (attribute) {
      case bsn_fields.enabled:
      case bsn_fields.visible:
        defaultValue = true as T;
        break;
      case bsn_fields.flex:
        defaultValue = 0 as T;
        break;
      case bsn_fields.labelAlign:
        defaultValue = 'left' as T;
        break;
      default:
        defaultValue = null;
        break;
    }
    return defaultValue;
  }

  __triggerEnable() {
    var frame = getRoot();
    frame.enabledTrigger[name]?.forEach((trigger) => trigger.updateEnable());
  }

  __triggerVisible() {
    var frame = getRoot();
    frame.visibleTrigger[name]?.forEach((trigger) => trigger.updateVisible());
  }

  hasLabel() {
    return labelAlign != '';
  }

  hasLabelTob() {
    return hasLabel() && labelAlign == 'top';
  }

  hasLabelBefore() {
    return hasLabel() && labelAlign == 'before';
  }

  hasLabelAfter() {
    return hasLabel() && labelAlign == 'after';
  }

  hasLabelPlaceholder() {
    return hasLabel() && labelAlign == 'placeholder';
  }

  updateEnable() {
    _enabled = true;
    // if (_enabled!) {
    //   getRoot()?.getFormGroup()?.controls[name]?.enable();
    // } else {
    //   getRoot()?.getFormGroup()?.controls[name]?.disable();
    // }
  }

  updateVisible() {
    _visible = true;
  }

  getValue(field) {
    if (field.includes("#")) {
      return true;
    }
    return getRoot()?.getFormGroup()?.value[field];
  }

  isNull(field) {
    if (field.includes("#")) {
      return true;
    }
    return !getRoot()?.getFormGroup()?.value[field];
  }

  bdate(field) {
    if (field.includes("#")) {
      return true;
    }
    // TODO: return field's value as date
    return true;
  }

  inRes(resource, field) {
    if (field.includes("#")) {
      return true;
    }
    return Utils.resourcesMap[resource] ==
        getRoot().getEntity().getField(fieldName: field);
  }

  infoEnabled(field) {
    if (field.includes("#")) {
      return true;
    }
    // for table info panel
    return true;
  }
}
