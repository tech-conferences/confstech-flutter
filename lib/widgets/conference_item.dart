import 'package:confs_tech/models/events.dart';
import 'package:confs_tech/utils/utils.dart';
import 'package:confs_tech/widgets/topics.dart';
import 'package:confs_tech/widgets/twitter.dart';
import 'package:flutter/material.dart';

class ConferenceItem extends StatelessWidget {
  final Event event;

  const ConferenceItem({Key key, @required this.event}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(event.name,
            style: TextStyle(
                color: Color(0xFF0b76d8),
                fontSize: 18
            ),
          ),
          SizedBox(height: 3,),
          Row(
            children: <Widget>[
              Text('${event.city}, ${event.country}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text('・', style: TextStyle(fontWeight: FontWeight.w500)),
              Text(Utils.formatDate(event.startDate, event.endDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )
              ),
            ],
          ),
          SizedBox(height: 3,),
          Row(children: <Widget>[
            Topics(topics: event.topics,),
            Twitter(twitter: event.twitter)
          ],
          )
        ],
      ),
    );
  }
}