import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/widgets/frame.dart';
import 'package:bisan_systems_erp/widgets/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

final tabSubject = BehaviorSubject<dynamic>();

class BsnTabWidget extends StatefulWidget {
  const BsnTabWidget({Key? key}) : super(key: key);

  @override
  State<BsnTabWidget> createState() => _BsnTabWidgetState();
}

class _BsnTabWidgetState extends State<BsnTabWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<BsnTabWidget> {
  late TabController tabController;
  int _selectedIndex = 0;

  List<Widget> tabViewList = [];
  List<Widget> tabList = [];
  List<BsnTab> openedTabs = [];

  @override
  bool get wantKeepAlive => true;

  List<Widget> getTabs() {
    return tabList;
  }

  @override
  void initState() {
    tabController = TabController(
        length: tabList.length, vsync: this, initialIndex: _selectedIndex);
    tabSubject.stream.listen((event) {
      dynamic newTab = event['tab'];

      if (event['action'] == 'add') {
        tabList
            .add(TabTitleWidget(label: newTab.label, tabIndex: tabList.length));
        tabViewList.add(AutomaticKeepAlive(
          child: FrameWidget(itemDetails: newTab),
        ));
        // FrameService().createFrame(newTab);
        // openedTabs.add(selectedTab);
        // tabList.add(event['tab'].titleWidget);
        // tabViewList.add(event['tab'].widget);
        _selectedIndex = tabList.length - 1;
      } else {
        if (openedTabs.isEmpty) {
          return;
        }
        // int tabIndex =
        //     openedTabs.indexWhere((t) => t.tableName == selectedTab.tableName);
        // openedTabs.removeAt(tabIndex);
        // tabList.removeAt(tabIndex);
        // tabViewList.removeAt(tabIndex);
        // _selectedIndex = tabIndex > 0 ? tabIndex - 1 : 0;
      }
      updateTabs();
    });

    super.initState();
  }

  void updateTabs() {
    try {
      setState(() {
        tabController = TabController(
          length: tabList.length,
          vsync: this,
          initialIndex: _selectedIndex,
        );
      });
    } catch (on) {
      // print(on);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: TabBar(
            controller: tabController,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            onTap: (index) => _selectedIndex = index,
            automaticIndicatorColorAdjustment: true,
            tabs: _getTabList(),
          ),
          body: TabBarView(
            controller: tabController,
            children: _getTabViewList(),
          ),
        ));
  }

  addNewTab({required Map tabDetails, required Widget widget}) {
    // TODO NOT IMPLEMENTED
    throw "NOT IMPLEMENTED";
  }

  create(BsnTab tab) {
    tabList.add(tab.titleWidget);
    tabViewList.add(tab.widget);
  }

  close(int tabIndex) {
    tabList.removeAt(tabIndex);
    tabViewList.removeAt(tabIndex);
  }

  List<Widget> getWidgets() {
    return tabViewList;
  }

  Tab getWidget(int widgetNumber) {
    return Tab(
      child: tabViewList[widgetNumber],
    );
  }

  _getTabViewList() {
    return tabViewList;
  }

  _getTabList() {
    return tabList;
  }
}
