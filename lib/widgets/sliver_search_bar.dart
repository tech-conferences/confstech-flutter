import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final Function(String) onSearchTextChanged;

  const SearchBar({Key key, this.actions, this.onSearchTextChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBar(actions: actions, onSearchTextChanged: onSearchTextChanged);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchBar extends State<SearchBar> {
  final TextEditingController _filter = new TextEditingController();
  Widget _appBarTitle = new Text('Confs.tech');

  final List<Widget> actions;
  Function(String) onSearchTextChanged;
  bool isInSearchMode = false;

  _SearchBar({ this.actions, this.onSearchTextChanged });

  @override
  Widget build(BuildContext context) {
    return _buildBar(context);
  }

  Widget _buildBar(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isInSearchMode){
          _searchPressed();
          return false;
        } else {
          return true;
        }
      },
      child: new AppBar(
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
        }()),
      ),
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