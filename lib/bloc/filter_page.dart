import 'package:confs_tech/widgets/filter_body.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
        ),
        body: MyTabbedPage()
    );
  }

}