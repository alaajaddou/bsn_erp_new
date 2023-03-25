import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/containers/bsn_container.dart';
import 'package:bisan_systems_erp/widgets/bsn_container.dart';
import 'package:flutter/material.dart';

class BsnInnerTabWidget extends StatefulWidget {
  final BsnTab frame;
  final BsnContainer instance;
  final dynamic widgetDetails;

  const BsnInnerTabWidget(
      {Key? key,
      required this.widgetDetails,
      required this.frame,
      required this.instance})
      : super(key: key);

  @override
  State<BsnInnerTabWidget> createState() => _BsnInnerTabWidgetState();
}

class _BsnInnerTabWidgetState extends State<BsnInnerTabWidget>
    with TickerProviderStateMixin {
  late List<Widget> tabs = [];
  late TabController tabController;
  late Widget bodyWidget = Container();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // tabs = _buildTabs(widget.widgetDetails);
    tabController = TabController(length: tabs.length, vsync: this);
    _updateWidget(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;

    return Column(
      children: [
        Row(
          children: _getChildTitles(),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: bodyWidget,
        )
      ],
    );
  }

  List<Widget> _getChildTitles() {
    List children = widget.widgetDetails['children'];
    List<Widget> tabs = [];
    for (int index = 0; index < children.length; index++) {
      dynamic child = children[index];
      tabs.add(GestureDetector(
        onTap: () {
          _updateWidget(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.redAccent, width: 0.5)),
          child: Text(child['label'] ?? ' '),
        ),
      ));
    }
    return tabs;
  }

  void _updateWidget(index) {
    selectedIndex = index;

    setState(() {
      if (widget.widgetDetails['children'][selectedIndex]['children'] != null &&
          widget.widgetDetails['children'][selectedIndex]['children']
              .isNotEmpty) {
        bodyWidget = BsnContainerWidget(
            widgetDetails: widget.widgetDetails['children'][selectedIndex],
            frame: widget.frame,
            instance: widget.instance);
      } else {
        bodyWidget = UiGenerator().buildWidget(
            widgetDetails: widget.widgetDetails['children'][selectedIndex],
            frame: widget.frame);
      }
    });
  }
}
