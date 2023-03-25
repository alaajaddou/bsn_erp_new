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
      theme: BsnTheme.theme(id: 0),
      debugShowCheckedModeBanner: false,
      initialRoute: '',
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: TestWidget(stop: false),
    );
  }
}

class TestWidget extends StatelessWidget {
  final bool stop;

  const TestWidget({Key? key, required this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !stop
        ? Scaffold(
            body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: GridView.count(
                    crossAxisCount: 15,
                    children: const [
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                    ],
                  )),
              Expanded(
                  flex: 20,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.redAccent),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: GridView.count(
                              crossAxisCount: 10,
                              children: const [
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                                Text(
                                  'new Tab',
                                ),
                              ],
                            )),
                        Expanded(flex: 10, child: TestWidget(stop: true))
                      ],
                    ),
                  ))
            ],
          ))
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.green),
          );
  }
}
