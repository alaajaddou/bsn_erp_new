import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/containers/bsn_split_pane.dart';
import 'package:flutter/material.dart';

class BsnSplitWidget extends StatelessWidget {
  final BsnTab parent;
  final BsnSplitPane instance;

  const BsnSplitWidget({Key? key, required this.parent, required this.instance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Text('BsnSplit');
  }
}
