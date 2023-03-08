import 'package:bisan_systems_erp/widgets/main_menu.dart';
import 'package:flutter/material.dart';

class BsnDrawer extends StatefulWidget {
  const BsnDrawer({Key? key}) : super(key: key);

  @override
  State<BsnDrawer> createState() => _BsnDrawerState();
}

class _BsnDrawerState extends State<BsnDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SafeArea(child: MainMenu()),
    );
  }
}
