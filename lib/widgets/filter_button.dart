import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final int selectedCount;
  final String title;
  final VoidCallback onPressed;

  FilterButton({ @required this.selectedCount, @required this.title, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: this.onPressed,
      borderSide: BorderSide(
          width: .8,
          color: selectedCount > 0 ? Colors.black : Colors.black45
      ),
      child: (selectedCount > 0) ?
      Text('$title・$selectedCount',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          )
      ) :
      Text('$title'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}