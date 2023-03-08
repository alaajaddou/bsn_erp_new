import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject selectedElementState = BehaviorSubject<String>();

class BsnStatusBar extends StatefulWidget {
  late String state = '';
  BsnStatusBar({Key? key}) : super(key: key);

  @override
  State<BsnStatusBar> createState() => _BsnStatusBarState();
}

class _BsnStatusBarState extends State<BsnStatusBar> {
  @override
  void initState() {
    super.initState();
    selectedElementState.stream.listen((event) {
      setState(() {
        widget.state = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(7.5),
      color: Colors.grey.shade300,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.state,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            )
          ]),
    );
  }
}
