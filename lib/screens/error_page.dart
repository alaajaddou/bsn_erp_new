
import 'package:bisan_systems_erp/widgets/bsn_appbar.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BsnAppBar(),
      body: Center(child: Text('Error')),
    );
  }
}
