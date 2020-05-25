import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        RichText(
            text: TextSpan(children: [
              TextSpan(text: "This application is open source at ",
                  style: TextStyle(
                      color: Colors.black
                  )
              ),
              TextSpan(
                  text: "github.com/leonardo2204/confstech-flutter",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    if (await canLaunch("https://github.com/leonardo2204/confstech-flutter")) {
                      launch("https://github.com/leonardo2204/confstech-flutter");
                    }
                  }
              ),
            ])
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: "The original application and all conferences are available at ",
                      style: TextStyle(
                          color: Colors.black
                      )
                  ),
                  TextSpan(
                      text: "confs.tech.",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () async {
                        if (await canLaunch("https://confs.tech")) {
                          launch("https://confs.tech");
                        }
                      }
                  ),
                ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text("Developer info",
              style: TextStyle(fontSize: 26)
          ),
        ),
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Leonardo Ferrari ",
                    style: TextStyle(color: Colors.black)
                ),
                TextSpan(
                    text: "Github",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () async {
                      if (await canLaunch("https://github.com/leonardo2204")) {
                        launch("https://github.com/leonardo2204");
                      }
                    }
                ),
                TextSpan(
                    text: " / ",
                    style: TextStyle(color: Colors.black)
                ),
                TextSpan(
                    text: "Linkedin",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () async {
                      if (await canLaunch("https://www.linkedin.com/in/leonardo2204/")) {
                        launch("https://www.linkedin.com/in/leonardo2204/");
                      }
                    }
                ),
              ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text("Search engine",
              style: TextStyle(fontSize: 26)
          ),
        ),
        Row(
          children: <Widget>[
            InkWell(
                onTap: () async {
                  if (await canLaunch("https://www.algolia.com")) {
                    launch("https://www.algolia.com");
                  }
                },
                child: Image(image: AssetImage("images/algolia.png"))
            ),
          ],
        )
      ],
    );
  }

}