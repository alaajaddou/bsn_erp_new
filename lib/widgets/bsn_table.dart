import 'dart:convert';

import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/services/api.dart';
import 'package:bisan_systems_erp/utils/configs.dart' as configs;
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/double_tap_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BsnTableWidget extends StatefulWidget {
  BsnTableWidget(
      {Key? key,
      required this.map,
      required this.name,
      required this.isListing,
      required this.frame})
      : super(key: key);
  final dynamic map;
  final String name;
  final bool isListing;
  final BsnTab frame;
  Map<int, bool> selectedRows = {};

  @override
  State<BsnTableWidget> createState() => _BsnTableWidgetState();
}

class _BsnTableWidgetState extends State<BsnTableWidget> {
  // final String apiUrl = "https://gw.bisan.com/api/v2/${  }/${ action.link }";
  List rows = [];
  List<String> fields = [];

  @override
  void initState() {
    super.initState();
    fields = _buildFields(widget.map['columns']);
    // Fetch the users when the widget is first created
    if (widget.isListing) {
      _getTableData(widget.name, fields);
    }
  }

  List<String> _buildFields(List<dynamic> columns) {
    List<String> fields = [];
    for (var column in columns) {
      fields.add(column['name']);
    }

    widget.frame.fields = fields;
    return fields;
  }

  Future<void> _getTableData(link, fields) async {
    Response<dynamic> response = await Api.listingData(link, fields);
    // Check the status code of the response
    if (response.statusCode == 200) {
      // If the request was successful, parse the JSON and store the users in the list
      var data = Map.from(json.decode(response.data));
      setState(() {
        rows = data['rows'];
      });
    } else {
      // If the request was not successful, display an error message
      if (kDebugMode) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return SingleChildScrollView(
        child: DataTable(
      dividerThickness: 1,
      onSelectAll: _toggleAll,
      columns: _buildColumns(widget.map['columns']),
      rows: _buildRows(rows, fields.length),
    ));
  }

  List<DataColumn> _buildColumns(List<dynamic> listOfColumns) {
    List<DataColumn> columns = [];
    for (var element in listOfColumns) {
      columns.add(DataColumn(label: Text(element['label'])));
    }
    return columns;
  }

  List<DataRow> _buildRows(List<dynamic> data, int columnsLength) {
    List<DataRow> rows = [];
    final doubleTapChecker = DoubleTapChecker<dynamic>();
    if (data.isEmpty) {
      return rows;
    }

    for (int i = 0; i < data.length; i++) {
      dynamic element = data[i];
      List<DataCell> cells = [];

      for (String key in element.keys.toList()) {
        cells.add(DataCell(Text(element[key])));
      }
      while (cells.length != columnsLength) {
        cells.add(const DataCell(Text('')));
      }

      // rows.add(DataRow.byIndex(
      //     index: i,
      //     cells: cells,
      //     onSelectChanged: (value) {
      //       setState(() {
      //         if (value == true) {
      //           widget.frame.selectedCodes.add(this.rows[i]['code']);
      //           widget.selectedRows[i] = true;
      //           widget.frame.actionToRecord(
      //               name: widget.name,
      //               code: this.rows[i]['code'],
      //               tempCode: configs.getTempCode(),
      //               action: 'open',
      //               context: context);
      //         } else {
      //           widget.frame.selectedCodes.remove(this.rows[i]['code']);
      //           widget.selectedRows[i] = false;
      //         }
      //       });
      //     },
      //     selected: _checkIfSelected(i)));

      rows.add(DataRow.byIndex(
        index: i,
        cells: cells,
        selected: _checkIfSelected(i),
        onSelectChanged: ((selected) {
          setState(() {
            if (doubleTapChecker.isDoubleTap(element)) {
              widget.frame.selectedCodes.add(this.rows[i]['code']);
              widget.selectedRows[i] = true;
              widget.frame.actionToRecord(
                  title: this.rows[i]['name'],
                  name: widget.name,
                  code: this.rows[i]['code'],
                  tempCode: configs.getTempCode(),
                  action: 'open');
              return;
            } else {
              if (selected == true) {
                widget.frame.selectedCodes.add(this.rows[i]['code']);
                widget.selectedRows[i] = true;
              } else {
                widget.frame.selectedCodes.remove(this.rows[i]['code']);
                widget.selectedRows[i] = false;
              }
            }
          });
        }),
      ));
    }

    return rows;
  }

  bool _checkIfSelected(int i) {
    return widget.selectedRows[i] ??= false;
  }

  void _toggleAll(bool? value) {
    for (var element in widget.selectedRows.keys) {
      if (value == true) {
        widget.frame.selectedCodes.add(rows[element]['code']);
        widget.selectedRows[element] = true;
      } else {
        widget.frame.selectedCodes.remove(rows[element]['code']);
        widget.selectedRows[element] = false;
      }
    }
    setState(() {
      widget.selectedRows = widget.selectedRows;
    });
  }
}
