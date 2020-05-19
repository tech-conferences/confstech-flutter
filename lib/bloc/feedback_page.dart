import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedbackPageState();
  }
}

class _FeedbackPageState extends State<FeedbackPage> {

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      bloc: BlocProvider.of(context),
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Send feedback"),
              actions: <Widget>[
                state is! SendingFeedbackState ? IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState.validate()){
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<FeedbackBloc>(context)
                          .add(SendFeedbackEvent(
                          title: _titleController.text,
                          comment: _commentController.text
                      )
                      );
                    }
                  },
                ) :
                Padding(padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: BlocListener<FeedbackBloc, FeedbackState>(
              listener: (context, state) {
                if (state is FeedbackFailureState) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("An error has ocurred, please try again"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is FeedbackSuccessState) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Thanks for sending your feedback"),
                      )
                  ).closed.then((_) => Navigator.of(context).pop());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Title"
                        ),
                        validator: (String value) {
                          return value.isEmpty ? 'Title field is required' : null;
                        },
                        controller: _titleController,
                      ),
                      TextFormField(
                        maxLines: 2,
                        minLines: 2,
                        decoration: InputDecoration(
                            labelText: "Comment"
                        ),
                        validator: (String value) {
                          return value.isEmpty ? 'Comment field is required' : null;
                        },
                        controller: _commentController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 16
                              ),
                              children: [
                                TextSpan(
                                    text: "This feedback will be publicly available on ",
                                    style: TextStyle(color: Colors.grey)
                                ),
                                TextSpan(
                                    text: "Conftechs-flutter Github repository",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () async {
                                      if (await canLaunch("https://github.com/leonardo2204/confstech-flutter/issues")) {
                                        launch("https://github.com/leonardo2204/confstech-flutter/issues");
                                      }
                                    }
                                ),
                                TextSpan(
                                    text: " as an issue.",
                                    style: TextStyle(color: Colors.grey)
                                )
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}