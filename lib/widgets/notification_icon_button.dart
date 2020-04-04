import 'package:flutter/material.dart';

class NotificationIconButton extends StatelessWidget {
  final int counter;
  final VoidCallback onPressed;
  final Icon icon;

  const NotificationIconButton({Key key, this.counter, this.onPressed,
    this.icon = const Icon(Icons.notifications)}):
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: this.icon,
            onPressed: this.onPressed,
          ),
          this.counter != 0 ? Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text('$counter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 8
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}