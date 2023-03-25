import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_dropdown.dart';
import 'package:flutter/material.dart';

class BsnDropdownWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnDropDown instance;

  const BsnDropdownWidget(
      {Key? key,
      required this.map,
      required this.parent,
      required this.instance})
      : super(key: key);

  final dynamic map;

  @override
  BsnDropdownWidgetState createState() => BsnDropdownWidgetState();
}

class BsnDropdownWidgetState extends State<BsnDropdownWidget> {
  // Initial Selected Value
  late String value;
  late String label;

  // List of items in our dropdown menu
  List<DropdownMenuItem<String>> items = [];

  @override
  void initState() {
    items = _createOptions(widget.instance.options);
    label = widget.instance.label!;
    value = widget.instance
            .getRoot()
            .getEntity()
            .getField(fieldName: widget.instance.name) ??
        '';
    super.initState();
  }

  List<DropdownMenuItem<String>> _createOptions(List<dynamic> options) {
    List<DropdownMenuItem<String>> items = [];
    for (var option in options) {
      String tempValue = '';
      if (option != null) {
        tempValue = option;
      }
      DropdownMenuItem<String> item = DropdownMenuItem(
        value: tempValue,
        child: Text(tempValue),
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget widgetToBuild = DropdownButton<String>(
      // Initial Value
      value: value,
      isExpanded: true,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items,
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        _onDropDownChanged(newValue ?? '');
      },
    );
    return Utils.buildWidget(
        instance: widget.instance, fieldWidget: widgetToBuild);
  }

  void _onDropDownChanged(String val) {
    widget.instance.blurField(val);
    setState(() {
      value = val;
    });
  }
}
