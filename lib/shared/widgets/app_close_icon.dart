import 'package:flutter/material.dart';
import '../../core/style/colors.dart';


class AppCloseIcon extends StatelessWidget {
  const AppCloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkRed,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(Icons.close, color: whiteClr,size: 20,),
    );
  }
}
