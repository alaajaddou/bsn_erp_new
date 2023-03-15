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
  get _getDirection => widget.widgetDetails['layout'] != null &&
          widget.widgetDetails['layout'] != 'column'
      ? Axis.horizontal
      : Axis.vertical;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget container;
    String layout = 'column';
    // if (widget.instance.icon != null) {
    //   String layout = 'row';
    // }
    // if (MediaQuery.of(context).size.width < 600) {
    //   container = ;
    // } else {
    //   if (layout == 'row') {
    //     container = _getContainer(context);
    //   } else {
    //     container = _getContainer(context);
    //   }
    // }
    return FutureBuilder(
      initialData: Container(),
      future: _getContainer(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return Container();
        }
      },
    );
    // return Utils.buildWidget(fieldWidget: container, instance: widget.instance);
  }

  Future<Widget> _getContainer(BuildContext context) async {
    Widget container;

    if (widget.widgetDetails['children'] != null &&
        widget.widgetDetails['children'].isNotEmpty) {
      if (widget.widgetDetails['layout'] == 'row') {
        container = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: UiGenerator()
              .getChildren(widget.frame, widget.widgetDetails['children']),
        );
      } else {
        container = Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: UiGenerator()
              .getChildren(widget.frame, widget.widgetDetails['children']),
        );
      }
    } else {
      container = UiGenerator().buildWidget(
          widgetDetails: widget.widgetDetails, frame: widget.frame);
    }
    return container;
  }
}
