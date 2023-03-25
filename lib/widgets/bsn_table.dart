import 'dart:async';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
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
  List<DataRow> dataRows = [];
  List<DataColumn> columns = [];
  List<String> fields = [];
  BsnTableDataSource? _source;
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  int _sortIndex = 0;
  bool _sortAsc = true;

  @override
  void initState() {
    columns = _buildColumns(widget.map['columns']);
    fields = _buildFields(widget.map['columns']);
    // Fetch the users when the widget is first created
    if (widget.isListing) {
      _getTableData(widget.name, fields);
    }
    super.initState();
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
      var data = Map.from(response.data);
      rows = data['rows'];
      _source = _buildRows(rows, fields);
    } else {
      // If the request was not successful, display an error message
      if (kDebugMode) {
        print("Failed to load users");
      }
      rows = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return SingleChildScrollView(
        child: _source != null
            ? AdvancedPaginatedDataTable(
                addEmptyRows: false,
                source: _source!,
                showCheckboxColumn: true,
                onSelectAll: _toggleAll,
                showHorizontalScrollbarAlways: true,
                sortAscending: _sortAsc,
                sortColumnIndex: _sortIndex,
                showFirstLastButtons: true,
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: const [10, 20, 30, 50],
                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(() {
                      _rowsPerPage = newRowsPerPage;
                    });
                  }
                },
                columns: columns,
                getFooterRowText:
                    (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
                  final localizations = MaterialLocalizations.of(context);
                  var amountText = localizations.pageRowsInfoTitle(
                    startRow,
                    pageSize,
                    totalFilter ?? totalRowsWithoutFilter,
                    false,
                  );

                  if (totalFilter != null) {
                    //Filtered data source show addtional information
                    amountText += ' filtered from ($totalRowsWithoutFilter)';
                  }

                  return amountText;
                },
              )
            : const Center(child: CircularProgressIndicator()));

    /**
     *
        child: DataTable(
        dividerThickness: 1,
        onSelectAll: _toggleAll,
        columns: columns,
        rows: dataRows,
        )
     */
  }

  void _toggleAll(bool? value) {
    Map<int, bool> selectedRows = {};
    for (var element in widget.selectedRows.keys) {
      if (value == true) {
        if (!widget.frame.selectedCodes.contains(rows[element]['code'])) {
          widget.frame.selectedCodes.add(rows[element]['code']);
          selectedRows[element] = true;
        }
      } else {
        widget.frame.selectedCodes.remove(rows[element]['code']);
        selectedRows[element] = false;
      }
    }
    print(widget.frame.selectedCodes);
    widget.selectedRows = selectedRows;
  }

  List<DataColumn> _buildColumns(List<dynamic> listOfColumns) {
    List<DataColumn> columns = [];
    for (var element in listOfColumns) {
      columns.add(DataColumn(label: Text(element['label'])));
    }
    return columns;
  }

  BsnTableDataSource _buildRows(List<dynamic> data, List<String> columns) {
    BsnTableDataSource dataSource = BsnTableDataSource(data, columns, widget);
    setState(() {});
    return dataSource;
  }
}

class BsnTableDataSource extends AdvancedDataTableSource<DataRow> {
  List<DataRow> rows = [];
  final List<dynamic> localRows;
  final List<String> columns;
  final BsnTableWidget widget;

  BsnTableDataSource(this.localRows, this.columns, this.widget) {
    _buildRows();
  }

  @override
  Future<RemoteDataSourceDetails<DataRow>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(rows.length, _buildRows());
  }

  _buildRows() {
    final doubleTapChecker = DoubleTapChecker<dynamic>();

    for (int i = 0; i < localRows.length; i++) {
      dynamic element = localRows[i];
      List<DataCell> cells = [];

      for (String key in element.keys.toList()) {
        cells.add(DataCell(Text(element[key])));
      }
      while (cells.length != columns.length) {
        cells.add(const DataCell(Text('')));
      }

      rows.add(DataRow.byIndex(
        index: i,
        cells: cells,
        selected: _checkIfSelected(i),
        onSelectChanged: ((selected) {
          print(selected);
          if (doubleTapChecker.isDoubleTap(element)) {
            widget.frame.selectedCodes.add(localRows[i]['code']);
            widget.selectedRows[i] = true;
            widget.frame.actionToRecord(
                title: localRows[i]['name'] ?? 'New Tab',
                name: widget.name,
                code: localRows[i]['code'],
                tempCode: configs.getTempCode(),
                action: 'open');
            return;
          } else {
            if (selected == true) {
              widget.frame.selectedCodes.add(localRows[i]['code']);
              widget.selectedRows[i] = true;
            } else {
              widget.frame.selectedCodes.remove(localRows[i]['code']);
              widget.selectedRows[i] = false;
            }
          }
        }),
      ));
    }
    return rows;
  }

  @override
  DataRow? getRow(int index) {
    // final doubleTapChecker = DoubleTapChecker<dynamic>();
    print(rows);
    DataRow row = rows[index];
    // List<DataCell> cells = [];
    //
    // for (String key in element.keys.toList()) {
    //   cells.add(DataCell(Text(element[key])));
    // }
    // while (cells.length != columns.length) {
    //   cells.add(const DataCell(Text('')));
    // }
    //
    // DataRow row = DataRow.byIndex(
    //   index: index,
    //   cells: cells,
    //   selected: _checkIfSelected(index),
    //   onSelectChanged: ((selected) {
    //     if (doubleTapChecker.isDoubleTap(element)) {
    //       widget.frame.selectedCodes.add(rows[index]['code']);
    //       widget.selectedRows[index] = true;
    //       widget.frame.actionToRecord(
    //           title: rows[index]['name'],
    //           name: widget.name,
    //           code: rows[index]['code'],
    //           tempCode: configs.getTempCode(),
    //           action: 'open');
    //       return;
    //     } else {
    //       if (selected == true) {
    //         widget.frame.selectedCodes.add(rows[index]['code']);
    //         widget.selectedRows[index] = true;
    //       } else {
    //         widget.frame.selectedCodes.remove(rows[index]['code']);
    //         widget.selectedRows[index] = false;
    //       }
    //     }
    //   }),
    // );

    return row;
  }

  @override
  int get selectedRowCount => widget.selectedRows.length;

  bool _checkIfSelected(int i) {
    return widget.selectedRows[i] ??= false;
  }
}
