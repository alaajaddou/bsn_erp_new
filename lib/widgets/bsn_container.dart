import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/containers/bsn_container.dart';
import 'package:flutter/material.dart';

class BsnContainerWidget extends StatefulWidget {
  final dynamic widgetDetails;
  final BsnTab frame;
  final BsnContainer instance;

  // final List<Widget> children;

  const BsnContainerWidget({
    Key? key,
    required this.widgetDetails,
    required this.frame,
    required this.instance,
    // required this.children
  }) : super(key: key);

  @override
  State<BsnContainerWidget> createState() => _BsnContainerWidgetState();
}

class _BsnContainerWidgetState extends State<BsnContainerWidget> {
  get _getDirection => widget.widgetDetails['layout'] != null &&
          widget.widgetDetails['layout'] != 'column'
      ? Axis.horizontal
      : Axis.vertical;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget container;
    List<Widget> children = UiGenerator()
        .getChildren(widget.frame, widget.widgetDetails['children']);
    if (widget.widgetDetails['layout'] == 'row') {
      container = Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: children.length,
          childAspectRatio: 1,
          children: children,
        ),
      );
    } else {
      container = Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ));
    }
    return Utils.buildWidget(instance: widget.instance, fieldWidget: container);
  }
}
