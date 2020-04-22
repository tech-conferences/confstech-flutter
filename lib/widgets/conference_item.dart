import 'package:confs_tech/models/events.dart';
import 'package:confs_tech/utils/utils.dart';
import 'package:confs_tech/widgets/topics.dart';
import 'package:confs_tech/widgets/twitter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cfp.dart';

class ConferenceItem extends StatelessWidget {
  final Event event;
  final bool showCallForPapers;

  const ConferenceItem({Key key, @required this.event,
    @required this.showCallForPapers}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: Text(event.name,
              style: TextStyle(
                  color: Color(0xFF0b76d8),
                  fontSize: 18
              ),
            ),
            onTap: () async {
              if (await canLaunch(event.url)) {
                await launch(event.url);
              } else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Something bad happened :('),
                    )
                );
              }
            },
          ),
          SizedBox(height: 3,),
          Row(
            children: <Widget>[
              Text('${event.city}, ${event.country}',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,),
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
          this.showCallForPapers ? Column(
            children: <Widget>[
              SizedBox(height: 3,),
              CFP(event.cfpEndDate, event.cfpUrl),
            ],
          ) : const SizedBox(),
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