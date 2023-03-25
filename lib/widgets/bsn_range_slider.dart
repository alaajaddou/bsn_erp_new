import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_range.dart';
import 'package:flutter/material.dart';

class BsnRangeSlider extends StatefulWidget {
  final BsnTab parent;
  final BsnRange instance;

  const BsnRangeSlider(
      {Key? key,
      required this.instance,
      required this.map,
      required this.parent})
      : super(key: key);

  final dynamic map;

  @override
  _BsnRangeSliderState createState() => _BsnRangeSliderState();
}

class _BsnRangeSliderState extends State<BsnRangeSlider> {
  RangeValues _values = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return RangeSlider(
      values: _values,
      max: 100,
      divisions: 5,
      labels: RangeLabels(
        _values.start.round().toString(),
        _values.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _values = values;
        });
      },
    );
    ;
  }
}
