import 'package:bisan_systems_erp/main.reflectable.dart';
import 'package:bisan_systems_erp/services/route_generator.dart';
import 'package:bisan_systems_erp/themes/bsn_theme.dart';
import 'package:flutter/material.dart';

BuildContext? currentContext;

void main() {
  initializeReflectable();
  runApp(const MyApp());
  // WidgetsFlutterBinding.ensureInitialized(); //imp line need to be added first
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   //this line prints the default flutter gesture caught exception in console
  //   //FlutterError.dumpErrorToConsole(details);
  //   print("Error From INSIDE FRAME_WORK");
  //   print("----------------------");
  //   print("Error :  ${details.exception}");
  //   print("StackTrace :  ${details.stack}");
  // };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bisan Systems',
      theme: BsnTheme.theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '',
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
