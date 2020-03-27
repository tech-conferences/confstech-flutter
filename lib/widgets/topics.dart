import 'package:flutter/widgets.dart';

class Topics extends StatelessWidget {

  final List<dynamic> topics;

  const Topics({Key key, this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(topics.map((topic) => '#$topic').join(' '),
      style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16),
    );
  }
}