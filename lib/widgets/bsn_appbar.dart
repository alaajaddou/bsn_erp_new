import 'package:flutter/material.dart';

class BsnAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BsnAppBar({Key? key}) : super(key: key);

  @override
  State<BsnAppBar> createState() => _BsnAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _BsnAppBarState extends State<BsnAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: MediaQuery.of(context).size.width < 600,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Bisan Systems"))
        ],
      ),
      centerTitle: true,
    );
  }
}
