import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_table.dart';
import 'package:flutter/material.dart';

class BsnInternalTable extends StatefulWidget {
  BsnInternalTable({
    Key? key,
    required this.instance,
    required this.frame,
    required this.name,
    required this.map,
  }) : super(key: key);
  final BsnTable instance;
  final dynamic map;
  final String name;
  final BsnTab frame;

  @override
  State<BsnInternalTable> createState() => _BsnInternalTableState();
}

class _BsnInternalTableState extends State<BsnInternalTable> {
  List rows = [];
  List<String> fields = [];

  @override
  void initState() {
    super.initState();
    fields = _buildFields(widget.map['columns']);
    // Fetch the users when the widget is first created
    _getTableData(widget.name, fields);
  }

  List<String> _buildFields(List<dynamic> columns) {
    List<String> fields = [];
    for (var column in columns) {
      fields.add(column['name']);
    }

    widget.frame.fields = fields;
    return fields;
  }

  _getTableData(link, fields) async {
    setState(() {
      rows = widget.instance
              .getRoot()
              .getEntity()
              .getField(fieldName: widget.instance.name) ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget fieldWidget = SingleChildScrollView(
        child: DataTable(
      dividerThickness: 1,
      columns: _buildColumns(widget.map['columns']),
      rows: _buildRows(rows, fields.length),
    ));
    return Utils.buildWidget(
        fieldWidget: fieldWidget, instance: widget.instance);
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

      rows.add(DataRow.byIndex(index: i, cells: cells));
    }
    return rows;
  }
}
