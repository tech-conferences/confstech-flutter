import 'package:flutter/material.dart';

class SliverSearchBar extends StatefulWidget {
  final List<Widget> actions;
  final Function(String) onSearchTextChanged;

  const SliverSearchBar({Key key, this.actions, this.onSearchTextChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SliverSearchBar(actions: actions, onSearchTextChanged: onSearchTextChanged);
  }
}

class _SliverSearchBar extends State<SliverSearchBar> {
  final TextEditingController _filter = new TextEditingController();
  Widget _appBarTitle = new Text('Confs.tech');

  final List<Widget> actions;
  Function(String) onSearchTextChanged;
  bool isInSearchMode = false;

  _SliverSearchBar({ this.actions, this.onSearchTextChanged });

  @override
  Widget build(BuildContext context) {
    return _buildBar(context);
  }

  Widget _buildBar(BuildContext context) {
    return new SliverAppBar(
        floating: true,
        title: _appBarTitle,
        leading: isInSearchMode ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _searchPressed,
        ) : null,
        actions: List.unmodifiable(() sync* {
          if (!isInSearchMode) yield IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchPressed,
          );
          if (!isInSearchMode && this.actions != null) {
            yield* this.actions;
          }
        }())
    );
  }

  void _searchPressed() {
    setState(() {
      if (!isInSearchMode) {
        isInSearchMode = true;
        this._appBarTitle = new TextField(
          onChanged: (text){
            if(onSearchTextChanged != null)
              onSearchTextChanged(_filter.text);
          },
          autofocus: true,
          controller: _filter,
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Event name or location...',
          ),
        );
      } else {
        isInSearchMode = false;
        this._appBarTitle = new Text('Confs.tech');
        if(onSearchTextChanged != null && _filter.text != '')
          onSearchTextChanged('');
        _filter.clear();
      }
    });
  }

  @override
  void dispose() {
    onSearchTextChanged = null;
    _filter.dispose();
    super.dispose();
  }

}