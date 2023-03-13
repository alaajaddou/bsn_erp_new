import 'package:bisan_systems_erp/widgets/bsn_tab.dart';
import 'package:flutter/material.dart';

class TabTitleWidget extends StatefulWidget {
  final String label;
  final num tabIndex;
  const TabTitleWidget({Key? key, required this.label, required this.tabIndex}) : super(key: key);

  @override
  State<TabTitleWidget> createState() => _TabTitleWidgetState();
}

class _TabTitleWidgetState extends State<TabTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(widget.label),
            GestureDetector(
              child: const Icon(Icons.close),
              onTap: () => tabSubject.add({'tab': widget.tabIndex, 'action': 'remove'}),
            )
          ]),
    );
  }
}
