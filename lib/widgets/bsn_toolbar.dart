import 'package:bisan_systems_erp/themes/bsn_theme.dart';
import 'package:bisan_systems_erp/utils/configs.dart' as configs;
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:flutter/material.dart';

class BsnToolbarWidget extends StatelessWidget {
  final BsnTab frame;
  final dynamic actionDetails;

  const BsnToolbarWidget(
      {Key? key, required this.frame, required this.actionDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('here');
    return AppBar(
      backgroundColor: BsnTheme.secondaryColor,
      elevation: 2,
      automaticallyImplyLeading: false,
      title: Row(children: getChildren()),
    );
  }

  Widget _buildToolbarIconButton(BsnActionToolbar action, frame, name) {
    return GestureDetector(
      onTap: () => action._getAction(frame, name),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Tooltip(
          message: action.label,
          child: Icon(action._getIcon(name), color: BsnTheme.primaryColor),
        ), //Toolti
      ),
      // Icon(icon, color: BsnTheme.primaryColor),
    );
  }

  List<Widget> getChildren() {
    final List<Widget> children = [];

    for (var child in actionDetails['children']) {
      var action = BsnActionToolbar.fromJson(child);
      children.add(_buildToolbarIconButton(action, frame, action.name));
    }
    return children;
  }
}

class BsnActionToolbar {
  String? icon = '';
  String? label = '';
  String? name = '';
  String? type = '';

  BsnActionToolbar(
      {required this.icon,
      required this.label,
      required this.name,
      required this.type});

  BsnActionToolbar.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    label = json['label'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['label'] = label;
    data['name'] = name;
    data['type'] = type;
    return data;
  }

  _getAction(frame, name) async {
    String? code;
    if (frame.selectedCodes.isNotEmpty) {
      for (String code in frame.selectedCodes) {
        frame.actionToRecord(
            code: code,
            tempCode: configs.getTempCode(),
            action: name,
            name: name);
      }
    } else {
      frame.actionToRecord(
          code: code,
          tempCode: configs.getTempCode(),
          action: name,
          name: name);
    }
  }

  IconData? _getIcon(name) {
    switch (name) {
      case 'open':
        return Icons.open_in_new;
      case 'clone':
        return Icons.share;
      case 'new':
        return Icons.new_label;
      case 'print':
        return Icons.print;
      case 'delete':
        return Icons.delete;
      case 'history':
        return Icons.history;
      case 'updateRates':
        return Icons.rate_review;
      default:
        return Icons.circle;
    }
  }
}
