import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_chart.dart';
import 'package:flutter/material.dart';

class BsnChartWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnChart instance;

  const BsnChartWidget({Key? key, required this.parent, required this.instance})
      : super(key: key);

  @override
  State<BsnChartWidget> createState() => _BsnChartWidgetState();
}

class _BsnChartWidgetState extends State<BsnChartWidget> {
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget widgetToBuild = const Text('BsnChart');
    return Utils.buildWidget(
        instance: widget.instance, fieldWidget: widgetToBuild);
  }
}
