import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:bisan_systems_erp/constants/constants.dart';
import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/services/api.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
import 'package:bisan_systems_erp/utils/configs.dart';
import 'package:bisan_systems_erp/view_models/bsn_action.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/entity.dart';
import 'package:bisan_systems_erp/widgets/bsn_tab.dart';
import 'package:bisan_systems_erp/widgets/bsn_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BsnTab extends BsnWidget {
  String type = '';
  late Icon? icon;
  late Widget widget = Container();
  late Entity entity;
  late String title;
  late Widget titleWidget;
  bool isListing = false;
  bool isHorizontal = false;
  Map tabDetails;
  bool closable = false;
  List<String> selectedCodes = [];
  Map enabledTrigger = {};
  Map visibleTrigger = {};
  Map<String, TextEditingController> entityControllers = {};
  bool hasToolbar = false;
  List<BsnActionToolbar> toolbarActions = [];
  bool isDataListNeeded = false;
  String tableName = '';
  final BehaviorSubject uiSelectedField = BehaviorSubject();

  BsnTab({required this.tabDetails});

  @override
  getRoot() {
    return this;
  }

  void addEntityController({required String name}) {}

  setEntity(Entity entity) {
    this.entity = entity;
  }

  @override
  getEntity() {
    return entity;
  }

  addControl({required name, required TextEditingController controller}) {
    entityControllers[name] = controller;
    // TODO add the control to the formGroup and add the blur event to it.
    // const control = new FormControl({
    // value,
    // disabled: !isEnabled
    // }, {
    // updateOn: "blur"
    // });
    // this.formGroup.addControl(name, control);
  }

  /// @required children to be initialized.
  void initializeWidget() {
    widget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  void initializeTitleWidget(tab) {
    titleWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(entity.getField(fieldName: 'title')),
              GestureDetector(
                child: const Icon(Icons.close),
                onTap: () => tabSubject.add({'tab': tab, 'action': 'remove'}),
              )
            ]));
  }

  Icon? getIcon(String? icon) {
    return null;
  }

  void buildToolbarActions(map) {
    // debugPrint(' = = = = = = = ');
    // debugPrint(map);
  }

  Future<void> actionToRecord(
      {String? code,
      required String title,
      required String name,
      String? tempCode,
      required String action}) async {
    BsnAction bsnAction = BsnAction(
      tableName,
      name,
      action,
      code,
      getTempCode(),
      entity,
        title
    );
    tabSubject.add({'tab': bsnAction, 'action': 'add'});
  }

  getController({required String fieldName}) {}

  getEntityId() {
    if (entity.hasField(fieldName: "_ENTITY_ID")) {
      return entity.getField(fieldName: "_ENTITY_ID");
    }
    return null;
  }

  @override
  T? getAttributeDefaultValue<T>(String attribute) {
    switch (attribute) {
      case bsn_fields.isDialog:
        return false as T;
      default:
        return super.getAttributeDefaultValue(attribute) as T;
    }
  }
}
