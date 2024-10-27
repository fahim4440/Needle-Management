import 'package:flutter/material.dart';
import 'package:needle_management/screen/desktop_homepage.dart';
import 'package:needle_management/screen/tablet_homepage.dart';

import 'mobile_homepage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Row(
          children: [
            Image.asset("assets/needle_management_logo.png", width: 50,),
            const SizedBox(width: 10,),
            const Text("EFL Ext Floor"),
          ],
        )
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          if (screenWidth < 600) {
            return MobileHomepage();
          }
          else if (screenWidth < 1200) {
            return TabletHomepage();
          } else {
            return DesktopHomepage();
          }
        },
      ),
    );
  }
}


