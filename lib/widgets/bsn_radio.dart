import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_radio.dart';
import 'package:flutter/material.dart';

class TimeValue {
  final int _key;
  final String _value;

  TimeValue(this._key, this._value);
}

class BsnRadioWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnRadio instance;

  const BsnRadioWidget(
      {Key? key,
      required this.instance,
      required this.map,
      required this.parent})
      : super(key: key);

  final dynamic map;

  @override
  _BsnRadioWidgetState createState() => _BsnRadioWidgetState();
}

class _BsnRadioWidgetState extends State<BsnRadioWidget> {
  bool? value;
  String? label;
  int currentTimeValue = 1;

  final _buttonOptions = [
    TimeValue(30, "30 minutes"),
    TimeValue(60, "1 hour"),
    TimeValue(120, "2 hours"),
    TimeValue(240, "4 hours"),
    TimeValue(480, "8 hours"),
    TimeValue(720, "12 hours"),
  ];
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    label = widget.map['label'];
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Row(children: <Widget>[
      Expanded(
        child: Text(label!, textAlign: TextAlign.left),
      ),
      Expanded(
        child: Column(
          children: _buttonOptions
              .map((timeValue) => RadioListTile<int>(
                    groupValue: currentTimeValue,
                    title: Text(timeValue._value),
                    value: timeValue._key,
                    onChanged: (val) {
                      setState(() {
                        currentTimeValue = val!;
                      });
                    },
                  ))
              .toList(),
        ),
      )
    ]);
  }
}
