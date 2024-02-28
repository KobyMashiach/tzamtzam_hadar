import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/tests/colors_map.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class TestColors extends StatelessWidget {
  const TestColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(title: "Colors"),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView.builder(
          itemCount: colorsMap.length,
          itemBuilder: (context, index) {
            final color = colorsMap.entries.elementAt(index).value;
            final colorName = colorsMap.entries.elementAt(index).key;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Color(0XFF000000),
                    color: Color(int.parse(color)),
                    height: 50,
                    width: 50,
                  ),
                ),
                Expanded(
                    child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                )),
              ],
            );
          }),
    );
  }
}
