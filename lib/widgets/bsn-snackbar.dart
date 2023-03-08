import 'package:flutter/material.dart';

class BsnSnackBar extends StatelessWidget {
  const BsnSnackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: const Text('Message from SnackBar!'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
  }
}
