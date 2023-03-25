import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_html_viewer.dart';
import 'package:flutter/material.dart';

class BsnHtmlViewerWidget extends StatefulWidget {
  final BsnTab parent;
  final BsnHtmlViewer instance;

  const BsnHtmlViewerWidget(
      {Key? key, required this.parent, required this.instance})
      : super(key: key);

  @override
  State<BsnHtmlViewerWidget> createState() => _BsnHtmlViewerWidgetState();
}

class _BsnHtmlViewerWidgetState extends State<BsnHtmlViewerWidget> {
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Widget widgetToBuild = const Text('BsnHtmlViewer');
    return Utils.buildWidget(
        instance: widget.instance, fieldWidget: widgetToBuild);
  }
}
