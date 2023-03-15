import 'dart:convert';

import 'package:bisan_systems_erp/services/api.dart';
import 'package:bisan_systems_erp/services/frame.dart';
import 'package:bisan_systems_erp/services/ui_generator.dart';
import 'package:bisan_systems_erp/utils/configs.dart' as configs;
import 'package:bisan_systems_erp/view_models/bsn_menu_item.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FrameWidget extends StatefulWidget {
  final dynamic itemDetails;

  const FrameWidget({Key? key, required this.itemDetails}) : super(key: key);

  @override
  State<FrameWidget> createState() => _FrameWidgetState();
}

class _FrameWidgetState extends State<FrameWidget> {
  String listingName = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        initialData: const {},
        future: getData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            dynamic recordData = snapshot.data as dynamic;
            BsnTab frameObject = FrameService().createFrameObject(recordData);
            Widget frame = Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: UiGenerator()
                  .getChildren(frameObject, recordData['GUI']['children']),
            );
            return SingleChildScrollView(
              child: frame,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<dynamic> getData() async {
    if (widget.itemDetails is BsnMenuItem) {
      return getListingData();
    } else {
      return getRecordData();
    }
  }

  String _getListingName(String link) {
    List<String> guiLinkSplit = link.split('/');
    return "${guiLinkSplit[1]}_${guiLinkSplit[0]}";
  }

  Future getListingData() async {
    dynamic item = widget.itemDetails;
    // check if the GUI is stored, and store it if not exist.
    dynamic actionContent = {};
    listingName = _getListingName(item.link);
    if (configs.guiMap[listingName] == null) {
      Response<dynamic> response = await Api.listing(item.link);
      configs.setGui(
          guiName: json.decode(response.data)['GUI']['name'],
          gui: json.decode(response.data)['GUI']);
      actionContent = json.decode(response.data);
    } else {
      actionContent['GUI'] = configs.getGui(guiName: listingName);
    }
    return actionContent;
  }

  Future getRecordData() async {
    Response<dynamic> response = await Api.callAction(widget.itemDetails);
    dynamic recordData = json.decode(response.data);
    String tempRecordType = widget.itemDetails.recordType;
    var responseGUI = recordData['GUI'];
    if (responseGUI is String && responseGUI.isEmpty) {
      responseGUI = configs.getGui(guiName: tempRecordType);
    } else {
      configs.setGui(guiName: tempRecordType, gui: responseGUI);
    }
    recordData['GUI'] = responseGUI;
    return recordData;
  }
}
