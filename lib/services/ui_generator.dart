import 'package:bisan_systems_erp/constants/constants.dart' as constants;
import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;
import 'package:bisan_systems_erp/utils/configs.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_field.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/bsn_widget.dart';
import 'package:bisan_systems_erp/view_models/entity.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/containers/bsn_container.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/containers/bsn_split_pane.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_button.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_chart.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_checkbox.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_color.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_date.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_dropdown.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_email.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_file.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_html_editor.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_html_viewer.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_image.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_image_pane.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_numeric.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_radio.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_range.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_table.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_tags.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_tel.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_text.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_textarea.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_url.dart';
import 'package:bisan_systems_erp/widgets/bsn_container.dart';
import 'package:bisan_systems_erp/widgets/bsn_table.dart';
import 'package:bisan_systems_erp/widgets/bsn_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:reflectable/reflectable.dart';

class UiGenerator {
  dynamic childAttribute = {
    'container': 'child',
    'frame': 'child',
  };

  /// @param data
  /// @param viewContainerRef
  /// @param actionContent
  /// @param values
  /// @param parentComponent
  BsnTab buildFrame(
      {required dynamic actionContent, required String recordType}) {
    dynamic gui = actionContent[constants.gui.toUpperCase()];
    dynamic values = actionContent[constants.values];
    BsnTab newTab = BsnTab(tabDetails: gui);
    newTab.isListing = gui[constants.frameType] == constants.listing;
    if (!isGuiExists(gui[constants.recordType])) {
      setGui(
          guiName:
              gui[newTab.isListing ? bsn_fields.name : constants.recordType],
          gui: gui);
    }
    newTab.setEntity(Entity());
    newTab.entity.setField(
        fieldName: constants.recordType, value: recordType, isInitial: true);
    newTab.entity.setField(
        fieldName: constants.title,
        value: gui[constants.frameType] == constants.listing
            ? gui[bsn_fields.label]
            : (values['nameAR'] ?? 'new'),
        isInitial: true);
    newTab.entity.setField(
        fieldName: 'isListing',
        value: gui[constants.frameType] == constants.listing,
        isInitial: true);
    newTab.entity.frame = newTab;
    newTab.tableName = recordType;
    _buildWidgetValues(frame: newTab, gui: gui, values: values);
    newTab.children = buildChildrenGUI(
        frame: newTab, children: gui['children'], values: values ?? {});
    newTab.initializeWidget();
    newTab.initializeTitleWidget(newTab);

    return newTab;
  }

  List<Widget> buildChildrenGUI(
      {required BsnTab frame,
      required List<dynamic> children,
      required Map values}) {
    List<Widget> widgets = [];
    for (var child in children) {
      widgets.add(buildWidget(frame: frame, widgetDetails: child));
    }
    return widgets;
  }

  buildWidget({required dynamic widgetDetails, required BsnTab frame}) {
    BsnWidget instance =
        _prepareInstance(widgetDetails: widgetDetails, frame: frame);
    // instance.enableLogic();
    Widget widget = getWidget(
        frame: frame, widgetDetails: widgetDetails, instance: instance);
    if (isInput(widgetDetails)) {
      String value = instance
          .getRoot()
          .getEntity()
          .getField(fieldName: widgetDetails['name']);
      (instance as BsnField).controller = TextEditingController(text: value);
      instance.value = value;
      frame.addControl(
          name: widgetDetails['name'], controller: instance.controller);
    }
    print('widget is $widget');
    return widget;
  }

  List<Tab> _buildInnerTabs(widgetDetails) {
    List<Tab> tabBarItems = [];
    for (var element in widgetDetails['children']) {
      tabBarItems.add(Tab(child: Text(element[bsn_fields.label])));
    }
    return tabBarItems;
  }

  List<Widget> _buildInnerTabsContent(
      {required BuildContext context,
      required BsnTab frame,
      required Map values,
      required dynamic widgetDetails}) {
    List<Widget> tabBarItems = buildChildrenGUI(
        children: widgetDetails['children'], frame: frame, values: values);
    return tabBarItems;
  }

  void _buildWidgetValues(
      {required BsnTab frame, required dynamic gui, required dynamic values}) {
    if (frame.isListing) {
      return;
    }

    if (isInput(gui) && gui['name'] != null) {
      if (gui['name'] != null) {
        frame.entity.setField(
            fieldName: gui['name'],
            value: values[gui['name']],
            isInitial: true);
      }
    } else {
      if (gui['children'] != null && gui['children'].length > 0) {
        gui['children'].forEach((child) {
          _buildWidgetValues(frame: frame, values: values, gui: child);
        });
      }
    }
  }

  bool isInput(gui) {
    List inputs = [
      'date',
      'text',
      'email',
      'number',
      'textArea',
      'telephone',
      'select',
      'checkBox',
      'radio',
      'image',
      'range',
      'tags',
      'url',
    ];
    return inputs.contains(gui['type']);
  }

  BsnWidget _getInstance({required dynamic widgetDetails}) {
    print('================== $widgetDetails ===================');
    if (widgetDetails['type'] == null) {
      return BsnWidget();
    }
    String type = widgetDetails['type'];
    switch (type) {
      case 'container':
        return BsnContainer();
      case "table":
        return BsnTable();
      // case "tab":
      //   return BsnTab();
      case "split-pane":
        return BsnSplitPane();
      case "chart":
        return BsnChart();
      case "html-viewer":
        return BsnHtmlViewer();
      case "htmlEditor":
        return BsnHtmlEditor();
      case "image-panel":
        return BsnImagePane();
      case 'button':
        return BsnButton();
      case 'date':
        return BsnDate();
      case 'text':
        return BsnText();
      case 'email':
        return BsnEmail();
      case 'number':
        return BsnNumeric();
      case 'textArea':
        return BsnTextArea();
      case "telephone":
        return BsnTel();
      case "select":
        return BsnDropDown();
      case "checkBox":
        return BsnCheckBox();
      case "radio":
        return BsnRadio();
      case "image":
        return BsnImage();
      case "color":
        return BsnColor();
      case "file":
        return BsnFile();
      case "range":
        return BsnRange();
      case "tags":
        return BsnTags();
      case "url":
        return BsnUrl();
      default:
        return BsnWidget();
    }
  }

  BsnWidget _prepareInstance(
      {required dynamic widgetDetails, required BsnTab frame}) {
    BsnWidget instance = _getInstance(widgetDetails: widgetDetails);
    instance.parent = frame;
    frame.entity.setField(
        fieldName: '_ENTITY_ID',
        value: frame.entity.getField(fieldName: '_ENTITY_ID'),
        isInitial: true);
    frame.entity.setField(
        fieldName: 'code',
        value: frame.entity.getField(fieldName: 'code'),
        isInitial: true);
    if (instance.fields.isNotEmpty) {
      for (var field in instance.fields) {
        if (field == bsn_fields.enabled || field == bsn_fields.visible) {
          // _updateTriggers(
          //     widgetDetails: widgetDetails,
          //     frame: frame,
          //     field: field,
          //     instance: instance);
        } else {
          frame.entity
              .setField(fieldName: 'name', value: field, isInitial: true);

          if (field == bsn_fields.layout && widgetDetails[field] == null) {
            widgetDetails[field] = "column";
          }
          if (field == bsn_fields.bsnClass && widgetDetails[field] == null) {
            widgetDetails[field] = " ";
          }

          String fieldName = field == bsn_fields.bsnClass ? 'className' : field;
          if (reflectable.canReflect(instance)) {
            InstanceMirror instanceMirror = reflectable.reflect(instance);

            if (widgetDetails[fieldName] != null) {
              dynamic value = widgetDetails[fieldName];
              instanceMirror.invokeSetter(fieldName, value);
            }
          }

          if (widgetDetails[bsn_fields.name] != null) {
            if (widgetDetails['type'] == 'checkbox') {
              Utils.toBooleanLogic(frame.entity
                  .getField(fieldName: widgetDetails[bsn_fields.name]));
            }

            String value = frame.entity
                    .getField(fieldName: widgetDetails[bsn_fields.name]) ??
                ' ';
            frame.entity.setField(
                fieldName: widgetDetails[bsn_fields.name],
                value: value,
                isInitial: true);
          }
        }
      }
    }
    return instance;
  }

  _updateTriggers(
      {required BsnTab frame,
      required BsnWidget instance,
      required Map widgetDetails,
      required String field}) {
    if (widgetDetails[field] != null) {
      // build enable & visible Logic
      List<String> parts = widgetDetails[field].split("\u0001");
      String body = parts.removeAt(0);
      if (reflectable.canReflect(instance)) {
        InstanceMirror instanceMirror = reflectable.reflect(instance);

        String field = 'enableLogic';
        if (field == bsn_fields.visible) {
          field = 'visibleLogic';
        }
        instanceMirror.invokeSetter(field, body.toString());
      }
      var params = parts;
      for (String param in params) {
        if (param.contains("#")) {
          continue;
        }

        if (field == bsn_fields.visible) {
          if (frame.visibleTrigger[param]) {
            frame.visibleTrigger[param].push(instance);
          } else {
            frame.visibleTrigger[param] = [instance];
          }
        } else {
          if (frame.enabledTrigger[param]) {
            frame.enabledTrigger[param].push(instance);
          } else {
            frame.enabledTrigger[param] = [instance];
          }
        }
      }
    } else {
      if (reflectable.canReflect(instance)) {
        InstanceMirror instanceMirror = reflectable.reflect(instance);
        instanceMirror.invokeSetter(field, widgetDetails[field]);
      }
    }
  }

  Widget getWidget({frame, widgetDetails, instance}) {
    Widget widget;
    switch (widgetDetails['type']) {
      case 'toolbar':
        widget = BsnToolbarWidget(frame: frame, actionDetails: widgetDetails);
        break;
      case 'container':
        widget = BsnContainerWidget(
            widgetDetails: widgetDetails, frame: frame, instance: instance);
        break;
      case 'table':
        if (frame.isListing) {
          widget = BsnTableWidget(
              map: widgetDetails,
              name: frame.tableName,
              isListing: frame.isListing,
              frame: frame);
        } else {
          widget = Container();
        }
        break;
      default:
        widget = Center(
            child: Text('component not defined yet ${widgetDetails['type']}'));
        break;
    }

    return widget;
  }

  List<Widget> getChildren(frame, children) {
    List<Widget> widgets = [];
    for (dynamic child in children) {
      Widget widget =
          UiGenerator().buildWidget(widgetDetails: child, frame: frame);
      widgets.add(widget);
    }

    return widgets;
  }
}
