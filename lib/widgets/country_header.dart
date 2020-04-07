import 'package:flutter/material.dart';

class CountryHeader extends StatelessWidget {
  final String countryName;

  CountryHeader(this.countryName);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orange[50],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16
            ),
            child: Text(
              this.countryName,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}