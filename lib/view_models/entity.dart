import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';

import '../services/api.dart';

// TODO: remove this after upgrade
Map booleans = {"Yes": true, "No": false};

/// @description Creates a dynamic class signature.
///
/// @author Alaa M. Jaddou
/// @since June 2021
///
class Entity {
  late String __entityID;
  final String _type = "";
  late BsnWidget rootWidget;
  final List<Map<String, dynamic>> _unFlushedData = [];
  final Map<String, dynamic> _data = {};
  late BsnTab frame;

  Entity();

  getUnFlushedData() {
    return _unFlushedData;
  }

  setField({required String fieldName, dynamic value, bool isInitial = false}) {
    if (!isInitial) {
      _unFlushedData.add({fieldName: value});
    } else {
      if (value == 'Yes' || value == 'No') {
        value = booleans[value];
      }
    }
    _data[fieldName] = value ?? '';
  }

  getField({required String fieldName}) {
    return _data[fieldName];
  }

  bool checkIfDirty({required String field}) {
    bool controlDirty = false;
    if (frame.getController(fieldName: field).text ==
        getField(fieldName: field)) {
      return true;
    }

    if (Utils.checkIfKeyExist(list: _unFlushedData, field: field)) {
      controlDirty = true;
    }

    return controlDirty;
  }

  bool checkIfChanged({required String fieldName, value}) {
    return getField(fieldName: fieldName) != value;
  }

  hasField({required String fieldName}) {
    return Utils.checkIfKeyExist(list: [_data], field: fieldName);
  }

  toJson() {
    return _data;
  }

  void sendUnFlushedData() async {
    // we need to use _unFlushedData
    final savedUnFlushedValues = _unFlushedData;

    var flushedDataResponse = await Api().postUnflushedData(
        _data['recordType'], _data['_ENTITY_ID'], {"data": _unFlushedData});

    _unFlushedData.asMap().forEach((index, value) {
      if (savedUnFlushedValues.indexWhere((element) =>
              (element.keys.first == value.keys.first &&
                  element.values.first == value.values.first)) !=
          -1) {
        _unFlushedData.removeAt(index);
      }
    });

    print(_unFlushedData);
    if (_unFlushedData.isNotEmpty) sendUnFlushedData();
  }

  void triggerEnable() {}

  void triggerVisible() {}
}
