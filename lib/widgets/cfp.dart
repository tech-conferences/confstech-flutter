import 'package:confs_tech/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CFP extends StatelessWidget{
  final String endDate;
  final String url;

  const CFP(this.endDate, this.url);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        "CFP closes ${Utils.formatSingleDate(endDate)}",
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      onTap: () async {
        if (await canLaunch(this.url)) {
          await launch(this.url);
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Something bad happened :('),
              )
          );
        }
      },
    );
  }
}