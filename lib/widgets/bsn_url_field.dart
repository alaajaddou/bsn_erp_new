import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_url.dart';
import 'package:flutter/material.dart';

class BsnUrlField extends StatefulWidget {
  final BsnUrl instance;
  final BsnTab parent;
  final dynamic map;

  BsnUrlField(
      {Key? key,
      required this.parent,
      required this.instance,
      required this.map})
      : super(key: key);

  @override
  State<BsnUrlField> createState() => _BsnUrlFieldState();
}

class _BsnUrlFieldState extends State<BsnUrlField> {
  String value = '';

  @override
  void initState() {
    value = widget.parent.entity.getField(fieldName: widget.map['name']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Text(value);
  }
}
