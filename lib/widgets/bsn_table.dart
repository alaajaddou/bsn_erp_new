import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    columns = _buildColumns(widget.map['columns']);
    fields = _buildFields(widget.map['columns']);
    // Fetch the users when the widget is first created
    if (widget.isListing) {
      _getTableData(widget.name, fields);
      _source = ExampleSource(widget.name, fields);
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
      return data['rows'];
    } else {
      // If the request was not successful, display an error message
      if (kDebugMode) {
        print("Failed to load users");
      }
    }
  }

  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  late ExampleSource _source;
  var _sortIndex = 0;
  var _sortAsc = true;
  final _searchController = TextEditingController();
  var _customFooter = false;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return SingleChildScrollView(
        child: AdvancedPaginatedDataTable(
      addEmptyRows: false,
      source: _source,
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
      columns: [
        DataColumn(
          label: const Text('ID'),
          numeric: true,
        ),
        DataColumn(
          label: const Text('Company'),
        ),
        DataColumn(
          label: const Text('First name'),
        ),
        DataColumn(
          label: const Text('Last name'),
        ),
        DataColumn(
          label: const Text('Phone'),
        ),
      ],
      //Optianl override to support custom data row text / translation
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
    ));

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
              print(this.rows[i]['name']);
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

class ExampleSource extends AdvancedDataTableSource {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  final String link;
  final List<String> fields;

  ExampleSource(this.link, this.fields);

  @override
  DataRow? getRow(int index) =>
      lastDetails!.rows[index].getRow(selectedRow, selectedIds);

  @override
  int get selectedRowCount => selectedIds.length;

  // ignore: avoid_positional_boolean_parameters
  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    //the remote data source has to support the pagaing and sorting
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      'pageSize': pageRequest.pageSize.toString(),
      'sortIndex': ((pageRequest.columnSortIndex ?? 0) + 1).toString(),
      'sortAsc': ((pageRequest.sortAscending ?? true) ? 1 : 0).toString(),
      if (lastSearchTerm.isNotEmpty) 'companyFilter': lastSearchTerm,
    };

    Response<dynamic> response = await Api.listingData(link, fields);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      return RemoteDataSourceDetails(
        int.parse(data['totalRows'].toString()),
        (data['rows'] as List<dynamic>)
            .map(
              (json) => data['rows'],
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? (data['rows'] as List<dynamic>).length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
