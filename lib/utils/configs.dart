library configs;

import 'package:bisan_systems_erp/constants/constants.dart';

bool isLoggedIn = false;
Map<String, dynamic> guiMap = {};
int sequence = 1;

String getTempCode() {
  return "$codePrefix${sequence++}";
}

isGuiExists(String? name) => name != null && guiMap[name.toLowerCase()] != null;

setGui({required String guiName, required dynamic gui}) {
  guiMap[guiName.toLowerCase()] = gui;
}

getGui({required String guiName}) {
  return guiMap[guiName.toLowerCase()];
}
