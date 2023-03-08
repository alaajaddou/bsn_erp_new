import 'package:bisan_systems_erp/utils/configs.dart';
import 'package:bisan_systems_erp/view_models/bsn_menu_item.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/entity.dart';
import 'package:bisan_systems_erp/widgets/bsn_tab.dart';
import 'package:bisan_systems_erp/constants/constants.dart' as constants;
import 'package:bisan_systems_erp/constants/fields.dart' as bsn_fields;

class FrameService {
  List<dynamic> frames = [];
  openFrame(BsnMenuItem element) {
    tabSubject.add({'tab': element, 'action': 'add'});
  }

  createFrame(actionContent) {
    print(actionContent);
    String recordType = actionContent[constants.recordType];
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

    print('=========');
    print(newTab);
    print('=========');
    return newTab;
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
}