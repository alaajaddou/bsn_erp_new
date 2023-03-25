import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_checkbox.dart';
import 'package:flutter/material.dart';

class BsnCheckboxWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnCheckBox instance;
  final dynamic map;

  const BsnCheckboxWidget(
      {Key? key,
      required this.instance,
      required this.map,
      required this.parent})
      : super(key: key);

  @override
  _BsnCheckboxWidgetState createState() => _BsnCheckboxWidgetState();
}

class _BsnCheckboxWidgetState extends State<BsnCheckboxWidget> {
  bool value = false;
  String? label;

  @override
  void initState() {
    super.initState();
    widget.instance.labelAlign = 'after';
    label = widget.instance.label;
    value = widget.instance.toBoolean(widget.instance.value);
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    // todo here
    Widget widgetToBuild = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: (value) {
            widget.instance.blurField(value);

            setState(() {
              this.value = value ?? false;
            });
          },
        ),
        Text(widget.instance.label!)
      ],
    );
    return widgetToBuild;
  }
}
