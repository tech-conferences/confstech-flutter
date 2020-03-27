import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          width: 35,
          height: 35,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}