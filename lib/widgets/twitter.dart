import 'package:flutter/widgets.dart';

class Twitter extends StatelessWidget {

  final String twitter;

  const Twitter({Key key, this.twitter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (twitter == null) { return Container(); }

    return Row(
      children: <Widget>[
        Text('・',
            style: TextStyle(
              fontWeight: FontWeight.w300,
            )
        ),
        Text(this.twitter,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            )
        )
      ],
    );
  }
}