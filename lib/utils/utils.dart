import 'package:bisan_systems_erp/constants/fields.dart';
import 'package:bisan_systems_erp/utils/enums/enums.dart';
import 'package:flutter/material.dart';

class Utils {
  static Map resourcesMap = {};
  static num sequence = 0;
  static final List<String> _trueStrings = ["true", "yes", "نعم", "1"];
  static final List<String> _falseStrings = ["false", "no", "لا", "0", ''];

  ///
  ///
  /// @return {textAlign} left | right | center
  /// @param align
  static String? getTextDirection({String? align}) {
    String defaultDirection = ltr;
    String textAlign = left;
    if (align != null) {
      AlignEnum enumValue = AlignEnum.values
          .firstWhere((e) => e.toString() == "AlignEnum.$align");
      if ((enumValue == AlignEnum.leading && defaultDirection == ltr) ||
          (enumValue == AlignEnum.trailing && defaultDirection == rtl) ||
          enumValue == AlignEnum.left) {
        textAlign = left;
      }

      if ((enumValue == AlignEnum.trailing && defaultDirection == ltr) ||
          (enumValue == AlignEnum.leading && defaultDirection == rtl) ||
          enumValue == AlignEnum.right) {
        textAlign = right;
      }

      if (enumValue == AlignEnum.center) {
        textAlign = center;
      }
    } else {
      if (defaultDirection == ltr) {
        textAlign = left;
      }
      if (defaultDirection == rtl) {
        textAlign = right;
      }
    }

    return textAlign;
  }

  static T? getEnumValue<T>(List<T> listOfValues, String value) {
    T enumValue = listOfValues.firstWhere((e) => e.toString() == "$T.$value");
    return enumValue;
  }

  static bool checkIfKeyExist(
      {required List<Map<String, dynamic>> list, required String field}) {
    return list.where((e) => e.containsKey(field)).isNotEmpty;
  }

  ///
  /// @param element
  /// @param isDebug
  ///
  /// @return {label} if you are in normal mode.
  /// @return {name} if you are in debug mode.
  ///
  static getDisplayText({required element, bool? isDebug}) {
    return isDebug ?? false
        ? element['name'] ?? element['label'] ?? ''
        : element['label'] ?? '';
  }

  /// @summary convert given string to boolean logic that return true | false when run
  ///
  /// @author Alaa M. Jaddou <a.jaddou@bisan.com>
  ///
  /// @param originalString
  ///
  /// @returns boolean, string
  static Object toBooleanLogic(String? originalString) {
    if ((originalString == null)) {
      return true;
    }

    String string = originalString.toLowerCase().trim();

    if (_falseStrings.contains(string)) {
      return false;
    }

    if (_trueStrings.contains(string)) {
      return true;
    }

    return originalString;
  }

  /// Uses canvas.measureText to compute and return the width of the given text of given font in pixels.
  ///
  /// @param {String} size number of characters.
  /// @param {String} font The css font descriptor that text is to be rendered with (e.g. "11pt Roboto").
  ///
  static getTextWidth({size, TextDirection direction = TextDirection.ltr}) {
    if (size != null) {
      String text = List.filled(10, 0).join("");
      TextSpan span = TextSpan(text: text);
      TextPainter tp = TextPainter(text: span, textDirection: direction);
      tp.layout();
      return tp.width;
    }
  }

  static Widget buildWidget({
    required Widget fieldWidget,
    required instance,
  }) {
    List<Widget> children = [];
    Widget? labelWidget;
    Widget? nameValueWidget;
    if (instance.label != null) {
      labelWidget = Text(instance.label ?? '');
    }
    if (instance.runtimeType.toString().contains('nameValue')) {
      if (instance.nameValue != null) {
        nameValueWidget = Text(instance.nameValue ?? '');
      }
    }

    int labelFlex = 1;
    int widgetFlex = 4;

    if (labelWidget != null) {
      if (instance.hasLabelBefore()) {
        children.add(Flexible(flex: labelFlex, child: labelWidget));
        children.add(Flexible(flex: widgetFlex, child: fieldWidget));
      } else if (instance.hasLabelAfter()) {
        children.add(Flexible(flex: widgetFlex, child: fieldWidget));
        children.add(Flexible(flex: labelFlex, child: labelWidget));
      }
    }
    if (instance.runtimeType.toString().contains('nameValue') &&
        instance.hasNameValue() &&
        nameValueWidget != null) {
      children.add(Flexible(flex: labelFlex, child: nameValueWidget));
    }

    Widget widget;
    if (children.isNotEmpty) {
      // widget = GridView.count(
      //   shrinkWrap: true,
      //   crossAxisCount: children.length,
      //   children: children,
      // );
      widget = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      widget = fieldWidget;
    }
    // return Container();
    return widget;
  }
}
