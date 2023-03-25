import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_tags.dart';
import 'package:flutter/material.dart';

class BsnTagsWidget extends StatelessWidget {
  final BsnTab parent;
  final BsnTags instance;
  final dynamic map;

  const BsnTagsWidget(
      {Key? key,
      required this.instance,
      required this.parent,
      required this.map})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Text('BsnTags');
  }
}
