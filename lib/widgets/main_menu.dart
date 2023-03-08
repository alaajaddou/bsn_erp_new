import 'dart:convert';

import 'package:bisan_systems_erp/services/frame.dart';
import 'package:dio/dio.dart';
import 'package:bisan_systems_erp/services/api.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
import 'package:bisan_systems_erp/utils/configs.dart' as configs;
import 'package:bisan_systems_erp/view_models/bsn_menu_item.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/widgets/bsn_tab.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<dynamic> _menuItemList = [];
  List<dynamic> gui = [];
  FrameService frameService = FrameService();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(0),
                    accountName: Text('Alaa M. Jaddou'),
                    accountEmail: Text('a.jaddou@bisan.com'),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://t3.ftcdn.net/jpg/03/22/68/66/360_F_322686690_FGS4GEosanesib73238v3vvYmU04SLpX.jpg'))),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/200'),
                    ))),
            Expanded(child: _getMenu())
          ],
        ));
  }

  Widget _getMenu() {
    return FutureBuilder(
        initialData: _menuItemList,
        future: _fetchListItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildMenuItems(snapshot.data as List<dynamic>);
          }
          return Container();
        });
  }

  Future<List<dynamic>> _fetchListItems() async {
    if (configs.guiMap.isEmpty || configs.guiMap["mainMenu"].isEmpty) {
      Response<dynamic> response = await Api.mainMenu();
      configs.guiMap["mainMenu"] = json.decode(response.data)['GUI'];
      _menuItemList = configs.guiMap["mainMenu"];
      return configs.guiMap["mainMenu"];
    }
    return configs.guiMap["mainMenu"];
  }

  Widget _buildMenuItems(List<dynamic> data) {
    if (data.isNotEmpty) {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            BsnMenuItem item = BsnMenuItem().fromJson(data[index]);
            return Card(
              child: ExpansionTile(
                title: Text(item.label),
                children: _getChildrenTree(item),
              ),
            );
          });
    } else {
      return Container();
    }
  }

  _getChildrenTree(BsnMenuItem item) {
    List<Widget> itemTiles = [];
    if (item.children.isNotEmpty) {
      for (var element in item.children) {
        Widget itemWidget;
        if (element.children.isNotEmpty) {
          itemWidget = ExpansionTile(
            title: Text(element.label),
            children: _getChildrenTree(element),
          );
        } else {
          itemWidget = ListTile(
            onTap: () {
              frameService.openFrame(element);
            },
            title: Text(element.label),
          );
        }
        itemTiles.add(itemWidget);
      }
    }
    return itemTiles;
  }

  // Future<void> getListingData(BsnMenuItem item) async {
  //   // check if the GUI is stored, and store it if not exist.
  //   dynamic actionContent = {};
  //   String listingName = _getListingName(item.link);
  //   if (configs.guiMap[listingName] == null) {
  //     Response<dynamic> response = await Api.listing(item.link);
  //     configs.setGui(
  //         guiName: json.decode(response.data)['GUI']['name'],
  //         gui: json.decode(response.data)['GUI']);
  //     actionContent = json.decode(response.data);
  //   } else {
  //     actionContent['GUI'] = configs.getGui(guiName: listingName);
  //   }
  //   BsnTab newTab = UiGenerator().buildFrame(
  //       actionContent: actionContent, recordType: item.name, context: context);
  //   newTab.isDataListNeeded = true;
  //   tabSubject.add({'tab': newTab, 'action': 'add'});
  // }

  String _getListingName(String link) {
    List<String> guiLinkSplit = link.split('/');
    return "${guiLinkSplit[1]}_${guiLinkSplit[0]}";
  }
}
