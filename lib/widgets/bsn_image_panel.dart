import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_image_pane.dart';
import 'package:flutter/material.dart';

class BsnImagePaneWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnImagePane instance;

  const BsnImagePaneWidget(
      {Key? key, required this.parent, required this.instance})
      : super(key: key);

  @override
  State<BsnImagePaneWidget> createState() => _BsnImagePaneWidgetState();
}

class _BsnImagePaneWidgetState extends State<BsnImagePaneWidget> {
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget widgetToBuild = const Text('BsnImagePanel');
    return Utils.buildWidget(
        instance: widget.instance, fieldWidget: widgetToBuild);
  }
}
