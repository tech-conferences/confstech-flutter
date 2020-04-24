import 'package:flutter/material.dart';

class ConferenceLocation extends StatelessWidget{
  final String city;
  final String country;

  ConferenceLocation(this.city, this.country);

  @override
  Widget build(BuildContext context) {
    return Text(
      city != country ? "$city, $country" : "$city",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,),
    );
  }

}