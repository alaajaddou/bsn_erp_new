import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
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
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    // Widget container;
    // String layout = 'column';
    // if (widget.instance.icon != null) {
    //   String layout = 'row';
    // }
    // if (MediaQuery.of(context).size.width < 600) {
    //   container = Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Expanded(
    //         child: _getContainer(),
    //       )
    //     ],
    //   );
    // } else {
    //   if (layout == 'row') {
    //     container = _getContainer();
    //   } else {
    //     container = _getContainer();
    //   }
    // }
    return _getContainer();
    // return Utils.buildWidget(fieldWidget: container, instance: widget.instance);
  }

  Widget _getContainer() {
    Widget container;
    List<Widget> children = UiGenerator()
        .getChildren(widget.frame, widget.widgetDetails['children']);
    if (widget.widgetDetails['layout'] != null &&
        widget.widgetDetails['layout'] != 'column') {
      container = Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ));
    } else {
      container = Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ));
    }
    return container;
  }
}
