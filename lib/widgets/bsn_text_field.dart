import 'package:bisan_systems_erp/main.dart';
import 'package:bisan_systems_erp/utils/utils.dart';
import 'package:bisan_systems_erp/view_models/bsn_tab.dart';
import 'package:bisan_systems_erp/view_models/widgetInstances/fields/bsn_text.dart';
import 'package:bisan_systems_erp/widgets/bsn_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BsnTextField extends StatefulWidget {
  final BsnTab parent;
  final BsnText instance;
  final String type;
  final dynamic map;

  const BsnTextField({
    Key? key,
    required this.parent,
    required this.instance,
    required this.type,
    required this.map,
  }) : super(key: key);

  @override
  State<BsnTextField> createState() => _BsnTextFieldState();
}

class _BsnTextFieldState extends State<BsnTextField> {
  String label = '';
  String value = '';
  FocusNode focusNode = FocusNode();

  String? _errorText;

  String? get errorText => _errorText;

  @override
  void initState() {
    focusNode.debugLabel = widget.instance.name;
    label = widget.instance.label!;
    value =
        widget.parent.entity.getField(fieldName: widget.instance.name!) ?? '';
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        widget.instance.blurField(widget.instance.controller.text);
      } else {
        selectedElementState.add(
            'Selected Element: ${widget.instance.name} with value of ${widget.instance.controller.text}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    TextInputType inputType;
    bool isSecure = false;
    switch (widget.type) {
      case 'email':
        inputType = TextInputType.emailAddress;
        break;
      case 'date':
        inputType = TextInputType.datetime;
        break;
      case 'phone':
        inputType = TextInputType.phone;
        break;
      case 'number':
        inputType = TextInputType.number;
        break;
      case 'textArea':
        inputType = TextInputType.multiline;
        break;
      case 'password':
        inputType = TextInputType.text;
        isSecure = true;
        break;
      default:
        inputType = TextInputType.text;
        break;
    }

    return Padding(
        padding: const EdgeInsets.all(1),
        child: _getTextField(widget.instance.align, inputType, isSecure));
  }

  List<TextInputFormatter> _getFormatters() {
    List<TextInputFormatter> formatters = [];
    formatters
        .add(LengthLimitingTextInputFormatter(widget.instance.size!.toInt()));

    return formatters;
  }

  bool _valid = false;

  bool get valid {
    return _valid;
  }

  checkValidate(String? input) {
    String input = widget.instance.controller.text;
    if (widget.instance.pattern != null) {
      RegExp regexp = RegExp(widget.instance.pattern!);
      if (!regexp.hasMatch(input)) {
        _errorText = 'pattern validation error';
        _valid = false;
      } else {
        _errorText = null;
        _valid = true;
      }
    }

    num? max = widget.instance.max;
    if (max != null && input.length > max) {
      _errorText = 'max validation error';
      _valid = false;
    }
    num? min = widget.instance.min;
    if (min != null && input.length > min) {
      _errorText = 'min validation error';
      _valid = false;
    }
    setState(() {});
  }

  Widget _getTextField(String? align, TextInputType inputType, bool isSecure) {
    String? labelText;
    String? hintText;
    if (widget.instance.hasLabelTob()) {
      labelText = widget.instance.label;
    } else if (widget.instance.hasLabelPlaceholder()) {
      hintText = widget.instance.label;
    }

    Widget widgetToBuild = TextFormField(
      maxLines:
          inputType == TextInputType.multiline ? widget.instance.rows : null,
      controller: widget.instance.controller,
      focusNode: focusNode,
      keyboardType: inputType,
      obscureText: isSecure,
      enableSuggestions: false,
      autocorrect: false,
      inputFormatters: _getFormatters(),
      onChanged: checkValidate,
      decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.start,
          errorText: !_valid ? errorText : null,
          labelText: labelText,
          hintText: hintText),
      // onChanged: onChanged,
    );
    // return Container(child: widgetToBuild);
    return Utils.buildWidget(
        instance: widget.instance, fieldWidget: widgetToBuild);
  }
}
