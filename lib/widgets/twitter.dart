import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Twitter extends StatelessWidget {

  final String twitter;

  const Twitter({Key key, this.twitter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (twitter == null) { return Container(); }

    final String twitterUrl = "https://www.twitter.com/$twitter";

    return Row(
      children: <Widget>[
        InkWell(
          child: Text('・ $twitter',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              )
          ),
          onTap: () async {
            if (await canLaunch(twitterUrl)) {
              await launch(twitterUrl);
            } else {
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Something bad happened :('),
                  )
              );
            }
          },
        ),
      ],
    );
  }
}