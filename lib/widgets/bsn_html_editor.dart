import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_html_editor.dart';
import 'package:flutter/material.dart';

class BsnHtmlEditorWidget extends StatelessWidget {
  final BsnTab parent;
  final BsnHtmlEditor instance;

  const BsnHtmlEditorWidget(
      {Key? key, required this.parent, required this.instance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Text('BsnHtmlEditor');
  }
}
