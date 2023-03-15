import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:bisan_systems_erp/utils/configs.dart';
import 'package:bisan_systems_erp/view_models/bsn_action.dart';

class Api {
  static late String accountCode;
  static String url = "gw.bisan.com";
  static String apiUrl = '/api/v2/${Api.accountCode}';
  static String loginPath = "${Api.apiUrl}/login";
  static String mainMenuPath = "${Api.apiUrl}/mainMenu";
  static String mainToolbarPath = "${Api.apiUrl}/mainToolbar";
  static String token = '';

  static Map<String, String> loginHeaders = {
    "BSN-apiID": "BISANPOS",
    "BSN-apiSecret": "o2vkTHXDOFLfVAfubGcdcih7sxOTQBw8xQHL1AxX",
  };
  static Map<String, String> headers = {
    "BSN-token": Api.token,
    "BSN-return-booleans": "true"
  };

  static login(String username, String password) async {
    try {
      Dio dio = Dio(BaseOptions(
        headers: Api.loginHeaders,
        baseUrl: "https://gw.bisan.com",
        receiveTimeout: 50000,
      ));

      var jsonMap = {
        'user': username,
        'password': password,
      };

      return dio.request(Api.loginPath,
          data: json.encode(jsonMap), options: Options(method: 'post'));
    } on DioError catch (_, error) {
      print(error);
    }
  }

  static mainMenu() async {
    try {
      Dio dio = Dio(_getBaseOptions());

      return dio.request(Api.mainMenuPath);
    } on DioError catch (_, error) {
      print(error);
    }
  }

  static mainToolBar() async {
    try {
      Dio dio = Dio(_getBaseOptions());

      return dio.request(Api.mainToolbarPath);
    } on DioError catch (_, error) {
      print(error);
    }
  }

  static Future<Response> listing(String link) async {
    try {
      Dio dio = Dio(_getBaseOptions());
      String url = "${Api.apiUrl}/$link";
      return dio.request(url);
    } on DioError catch (_, error) {
      throw error;
    }
  }

  static listingData(String link, List<String> fields) {
    try {
      Dio dio = Dio(_getBaseOptions());
      String url = "${Api.apiUrl}/$link";
      return dio.request(url, queryParameters: {"fields": fields.join(',')});
    } on DioError catch (_, error) {
      throw error;
    }
  }

  static callAction(BsnAction action) async {
    String actionType = action.recordType ?? action.name;
    String actionName = action.newAction;

    Map<String, dynamic>? queryParams = {};

    if (action.code != null) {
      queryParams.putIfAbsent('code', () => action.code);
    } else if (action.entity.frame.getEntityId() != null) {
      // if not exists add entityID
      queryParams.putIfAbsent('code', () => action.entity.frame.getEntityId());
    } else {
      // if new tempCode
      queryParams.putIfAbsent('code', () => action.tempCode);
    }

    if (action.tempCode != null) {
      queryParams.putIfAbsent('temp_code', () => action.tempCode);
    }

    bool withGUI = false;
    if (!isGuiExists(action.recordType)) {
      withGUI = true;
      queryParams.putIfAbsent('withGUI', () => withGUI.toString());
    }

    String url = "${Api.apiUrl}/action/$actionType/$actionName";
    try {
      Dio dio = Dio(_getBaseOptions());
      return dio.request(url,
          queryParameters: queryParams, options: Options(method: 'POST'));
    } on DioError catch (_, error) {
      throw error;
    }
  }

  postUnflushedData(tableName, tempCode, params) async {
    String url = "${Api.apiUrl}/FLUSHVAL/$tableName?code=$tempCode";
    try {
      Dio dio = Dio(_getBaseOptions());
      // return dio.request(url,
      //     data: json.encode(params), options: Options(method: 'POST'));
      Response response = await dio.post(
        url,
        data: jsonEncode(params),
      );
      return response;
    } on DioError catch (_, error) {
      throw error;
    }
  }

  static BaseOptions? _getBaseOptions() => BaseOptions(
        headers: Api.headers,
        baseUrl: "https://gw.bisan.com",
        receiveTimeout: 50000,
      );
}
