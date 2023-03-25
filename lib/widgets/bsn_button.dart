import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_button.dart';
import 'package:flutter/material.dart';

class BsnButtonWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnButton instance;
  final dynamic map;

  BsnButtonWidget(
      {Key? key,
      required this.parent,
      required this.instance,
      required this.map})
      : super(key: key);

  @override
  State<BsnButtonWidget> createState() => _BsnButtonWidgetState();
}

class _BsnButtonWidgetState extends State<BsnButtonWidget> {
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget widgetToBuild = IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        // Handle onPressed event
      },
    );
    if (widget.instance.hasLabel()) {
      widgetToBuild = TextButton.icon(
        icon: const Icon(Icons.edit),
        label: Text(widget.instance.label ?? ''),
        onPressed: () {
          // Handle onPressed event
        },
      );
    }

    return widgetToBuild;
  }
}
